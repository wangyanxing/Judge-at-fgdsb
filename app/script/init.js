var gui = require('nw.gui');
var util = require('util');
var exec = require('child_process').exec;
var cur_dir = process.cwd();

/*
var splashwin = gui.Window.open('splash/loading.html', {
    'frame': false,  // frameless
    'position': 'center', // centered
    'always-on-top': true // always on top
});
*/

var pkg = require('../package.json');
var upd = new updater(pkg);

console.log('Current version:' + pkg['version']);

var update = function(manifest) {
    upd.download(function(error, filename) {
        if (!error) {
            console.log(filename);
            $('#down-progress').css('width', '100%').attr('aria-valuenow', 100);
            $('#down-msg').text('Download finished! Please restart the app.');
            $('#btn-update').prop("disabled",false).text('Restart');

            upd.doUpdate(filename);
        } else {
            $('#down-msg').text('Download failed: ' + error);
        }
    }, function (state) {
        var rec = Math.round(state.received/1024);
        var tpt = Math.round(state.total/1024);
        $('#down-msg').text(rec + 'K /' + tpt + 'K downloaded');
        $('#down-progress').css('width', state.percent+'%').attr('aria-valuenow', state.percent);
    }, manifest);
};

if (!pkg.dev) {
    upd.checkNewVersion(function(error, newVersionExists, manifest) {
        if (error) {
            console.log(error);
            return;
        }
        if (newVersionExists) {
            var msg = '<div class="callout callout-info">\
                <h4>New version available!</h4>\
                <table style=\"width:100%; font-size: 15px;\"><tr><td>Current version:</td><td>' +
                pkg.version + '</td> </tr><tr><td>New version:</td><td>' +
                manifest.version + '</td> </tr><tr><td>Update log:</td><td>' +
                manifest.update_log + '</td> </tr></table>\
            </div><div id="download-panel" style="display: none;">\
                <div class="progress sm progress-striped active"> \
                  <div class="progress-bar progress-bar-success" id="down-progress" role="progressbar" \
                    aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%"> \
                  </div> \
                </div>\
                <p id="down-msg"></p>\
            </div>';

            bootbox.dialog({
                message: msg,
                title: "Update info",
                buttons: {
                    default: {
                        label: "Ignore",
                        className: "btn-default",
                        callback: function() {}
                    },
                    success: {
                        label: "Update",
                        className: "btn-success",
                        callback: function(e) {
                            if($(e.target).text() == 'Restart') {
                                upd.restart();
                            } else {
                                $('#download-panel').show("slow");
                                $(e.target).prop("disabled",true).attr("id","btn-update");
                                update(manifest);
                            }
                            return false;
                        }
                    }
                }
            });
        }
    });
}

// change directory settings per user platform
if (process.platform === 'darwin') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    baseDIR = process.env.HOME

} else if (process.platform === 'win32') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    baseDIR = process.env.HOME

} else {
    var user_menu = new gui.Menu({ type: 'menubar' });
    gui.Window.get().menu = user_menu;
    baseDIR = process.env.HOME
}

var win = gui.Window.get();
var nativeMenuBar = new gui.Menu({ type: "menubar" });
try {
    nativeMenuBar.createMacBuiltin("Judge@fgdsb");
    win.menu = nativeMenuBar;
} catch (ex) {
    console.log(ex.message);
}

win.show();
//win.maximize();
win.focus();

$(window).on('dragover', function (e) {
    e.preventDefault();
    e.originalEvent.dataTransfer.dropEffect = 'none';
});
$(window).on('drop', function (e) {
    e.preventDefault();
});
