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

var update = function() {
    upd.download(function(error, filename) {
        if (!error) {
            console.log(filename);
        } else {
            console.log(error);
        }
    }, function (state) {
        console.log('percent', state.percent);
    });

};

upd.checkNewVersion(function(error, newVersionExists, manifest) {
    if (error) {
        console.log(error);
        return;
    }
    if (!newVersionExists) {
        var msg = "<table style=\"width:100%; font-size: 15px;\"><tr><td>Current version:</td><td>" +
            pkg.version + "</td> </tr><tr><td>New version:</td><td>" +
            manifest.version + "</td> </tr><tr><td>Update log:</td><td>" +
            manifest.update_log + "</td> </tr></table>";

        bootbox.dialog({
            message: msg,
            title: "Update info",
            buttons: {
                success: {
                    label: "Ignore",
                    className: "btn-default",
                    callback: function() {}
                },
                danger: {
                    label: "Update",
                    className: "btn-success",
                    callback: function() {
                        update();
                    }
                }
            }
        });
    }
});

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

$(window).on('dragover', function (e) {
    e.preventDefault();
    e.originalEvent.dataTransfer.dropEffect = 'none';
});
$(window).on('drop', function (e) {
    e.preventDefault();
});
