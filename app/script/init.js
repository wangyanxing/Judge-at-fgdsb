var gui = require('nw.gui');

var pkg = require('../package.json');
var updater = require('node-webkit-updater');
var upd = new updater(pkg);

upd.checkNewVersion(function(error, newVersionExists, manifest) {
    if (error) {
        console.log(error);
        return;
    }
    if (newVersionExists) {
        console.log("new version exists!");
    } else {
        console.log("No new version exists!");
    }
});

//change directory settings per user platform
if (process.platform === 'darwin') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    //console.log('mac')
    baseDIR = process.env.HOME

} else if (process.platform === 'win32') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    //console.log('windows')
    baseDIR = process.env.HOME

} else {
    var user_menu = new gui.Menu({ type: 'menubar' });
    gui.Window.get().menu = user_menu;
    //console.log('not windows or mac')
    baseDIR = process.env.HOME
}

var win = gui.Window.get();
var nativeMenuBar = new gui.Menu({ type: "menubar" });
try {
    nativeMenuBar.createMacBuiltin("fgdsb@Judge");
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

console.log('app inited');
