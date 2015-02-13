
// this file was adapted from node-webkit-updater
// https://github.com/edjafarov/node-webkit-updater

var fs = require('fs');
var exec = require('child_process').exec;
var spawn = require('child_process').spawn;
var os = require('os');
var path = require('path');
var request = require('request');
var progress = require('request-progress');
var semver = require('semver');
var ncp = require('ncp');
var del = require('del');

var platform = process.platform;
platform = /^win/.test(platform)? 'win' : /^darwin/.test(platform)? 'mac' : 'linux' + (process.arch == 'ia32' ? '32' : '64');

function updater(manifest) {
    this.manifest = manifest;
}

/**
 * Will check the latest available version of the application by requesting the manifest specified in `manifestUrl`.
 *
 * The callback will always be called; the second parameter indicates whether or not there's a newer version.
 * This function assumes you use [Semantic Versioning](http://semver.org) and enforces it; if your local version is `0.2.0` and the remote one is `0.1.23456` then the callback will be called with `false` as the second paramter. If on the off chance you don't use semantic versioning, you could manually download the remote manifest and call `download` if you're happy that the remote version is newer.
 *
 * @param {function} cb - Callback arguments: error, newerVersionExists (`Boolean`), remoteManifest
 */
updater.prototype.checkNewVersion = function(cb){
    request.get(this.manifest.manifestUrl, gotManifest.bind(this)); //get manifest from url

    /**
     * @private
     */
    function gotManifest(err, req, data){
        if(err) {
            return cb(err);
        }

        if(req.statusCode < 200 || req.statusCode > 299){
            return cb(new Error(req.statusCode));
        }

        try{
            data = JSON.parse(data);
        } catch(e){
            return cb(e)
        }

        cb(null, semver.gt(data.version, this.manifest.version), data);
    }
};

/**
 * Downloads the new app to a template folder
 * @param  {Function} cb - called when download completes. Callback arguments: error, downloaded filepath
 * @param  {Function} prog_cb - callback for downloading progress. Callback arguments: download status
 * @param  {Object} newManifest - see [manifest schema](#manifest-schema) below
 * @return {Request} Request - stream, the stream contains `manifest` property with new manifest and 'content-length' property with the size of package.
 */
updater.prototype.download = function(cb, prog_cb, newManifest){
    var manifest = newManifest || this.manifest;
    var url = manifest.packages[platform].url;
    var pkg = progress(request(url, function(err, response){
        if(err){
            cb(err);
        }
        if(response.statusCode < 200 || response.statusCode >= 300){
            pkg.abort();
            return cb(new Error(response.statusCode));
        }
    }));
    pkg.on('response', function(response){
        if(response && response.headers && response.headers['content-length']){
            pkg['content-length'] = response.headers['content-length'];
        }
    });
    var filename = path.basename(url),
        destinationPath = path.join(os.tmpdir(), filename);

    // download the package to template folder
    fs.unlink(path.join(os.tmpdir(), filename), function(){
        pkg.pipe(fs.createWriteStream(destinationPath));
        pkg.resume();
    });

    pkg.on('progress', prog_cb);
    pkg.on('error', cb);
    pkg.on('end', appDownloaded);
    pkg.pause();

    function appDownloaded(){
        process.nextTick(function(){
            if(pkg.response.statusCode >= 200 && pkg.response.statusCode < 300){
                cb(null, destinationPath);
            }
        });
    }
    return pkg;
};

/**
 * Returns executed application path
 * @returns {string}
 */
updater.prototype.getAppPath = function(){
    var appPath = {
        mac: path.join(process.cwd(),'../../..'),
        win: path.dirname(process.execPath)
    };
    appPath.linux32 = appPath.win;
    appPath.linux64 = appPath.win;
    return appPath[platform];
};

/**
 * Returns current application executable
 * @returns {string}
 */
updater.prototype.getAppExec = function(){
    var execFolder = this.getAppPath();
    var exec = {
        mac: '',
        win: path.basename(process.execPath),
        linux32: path.basename(process.execPath),
        linux64: path.basename(process.execPath)
    };
    return path.join(execFolder, exec[platform]);
};

/**
 * Runs installer
 * @param {string} appPath
 * @param {array} args - Arguments which will be passed when running the new app
 * @param {object} options - Optional
 * @returns {function}
 */
updater.prototype.runInstaller = function(appPath, args, options){
    return pRun[platform].apply(this, arguments);
};

var pRun = {
    /**
     * @private
     */
    mac: function(appPath, args, options){
        //spawn
        if(args && args.length) {
            args = [appPath].concat('--args', args);
        } else {
            args = [appPath];
        }
        return run('open', args, options);
    },
    /**
     * @private
     */
    win: function(appPath, args, options, cb){
        return run(appPath, args, options, cb);
    },
    /**
     * @private
     */
    linux32: function(appPath, args, options, cb){
        var appExec = path.join(appPath, path.basename(this.getAppExec()));
        fs.chmodSync(appExec, 0755)
        if(!options) options = {};
        options.cwd = appPath;
        return run(appPath + "/"+path.basename(this.getAppExec()), args, options, cb);
    }
};

pRun.linux64 = pRun.linux32;

/**
 * @private
 */
function run(path, args, options){
    var opts = {
        detached: true
    };
    for(var key in options){
        opts[key] = options[key];
    }
    console.log("path:" + path);
    console.log("args:" + args);
    var sp = spawn(path, args, opts);
    sp.unref();
    return sp;
}

/**
 * Installs the app (copies current application to `copyPath`)
 * @param {string} copyPath
 * @param {function} cb - Callback arguments: error
 */
updater.prototype.install = function(copyPath, cb){
    pInstall[platform].apply(this, arguments);
};

var pInstall = {
    /**
     * @private
     */
    mac: function(to, cb){
        //ncp(this.getAppPath(), to, cb);
    },
    /**
     * @private
     */
    win: function(to, cb){
        var self = this;
        var errCounter = 50;
        deleteApp(appDeleted);

        function appDeleted(err){
            if(err){
                errCounter--;
                if(errCounter > 0) {
                    setTimeout(function(){
                        deleteApp(appDeleted);
                    }, 100);
                } else {
                    return cb(err);
                }
            }
            else {
                ncp(self.getAppPath(), to, appCopied);
            }
        }
        function deleteApp(cb){
            del(to, {force: true}, cb);
        }
        function appCopied(err){
            if(err){
                setTimeout(deleteApp, 100, appDeleted);
                return
            }
            cb();
        }
    },
    /**
     * @private
     */
    linux32: function(to, cb){
        ncp(this.getAppPath(), to, cb);
    }
};
pInstall.linux64 = pInstall.linux32;
