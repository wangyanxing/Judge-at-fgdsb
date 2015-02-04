var moment = require('moment');
var db = openDatabase('JudgeDB', '1.0', 'DB for auto-saves and submissions', 5 * 1024 * 1024);

db.transaction(function (tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS autosave (id UNIQUE NOT NULL PRIMARY KEY, cpp text, ruby text, python text, java text, scala text, csharp text, objc text, swift text, js text, lua text, last_lang)');
});
db.transaction(function (tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS submission (sid INTEGER PRIMARY KEY AUTOINCREMENT, id, code text, subtime DATETIME, language, runtime int, status, detail text)');
});

var langs_to_db = {
    "C++" : "cpp",
    "Java" : "java",
    "Ruby" : "ruby",
    "Python" : "python",
    "Scala" : "scala",
    "C#" : "csharp",
    "JavaScript" : "js",
    "Swift" : "swift",
    "Objective-C" : "objc",
    "Lua" : "lua"
};

var update_autosave = function(id, language, content) {
    var lang = langs_to_db[language];
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO autosave (id) VALUES ("' + id + '")');
    });
    db.transaction(function (tx) {
        content = content.replace(new RegExp("'", 'g'), "''");
        var sql = 'UPDATE autosave SET ' + lang + ' = \'' + content + '\', last_lang = \'' + language + '\' WHERE id = \'' + id + '\'';
        tx.executeSql(sql);
    });
};

var get_last_language = function(id, func) {
    db.transaction(function (tx) {
        tx.executeSql('SELECT last_lang FROM autosave WHERE id = \'' + id + '\'', [], function (tx, results) {
            if(results.rows.length > 0) {
                func(results.rows.item(0).last_lang);
            } else {
                func('C++');
            }
        });
    });
};

var get_autosave = function(id, language, func) {
    var lang = langs_to_db[language];
    db.transaction(function (tx) {
        tx.executeSql('SELECT ' + lang + ' FROM autosave WHERE id = \'' + id + '\'', [], function (tx, results) {
            if(results.rows.length > 0) {
                func(results.rows.item(0)[lang]);
            } else {
                func('');
            }
        });
    });
};

var clear_submissions = function($q, id) {
    var deferred = $q.defer();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM submission WHERE id = \'' + id + '\'', [], function(tx, results) {
            deferred.resolve();
        });
    });
    return deferred.promise;
}

var clear_single_submission = function($q, sid) {
    var deferred = $q.defer();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM submission WHERE sid = ' + sid, [], function(tx, results) {
            deferred.resolve();
        });
    });
    return deferred.promise;
}

var get_submission_detail = function($q, sid) {
    var deferred = $q.defer();
    db.transaction(function (tx) {
        tx.executeSql('SELECT * FROM submission WHERE sid = ' + sid, [], function (tx, results) {
            if(results.rows.length > 0) {
                deferred.resolve(results.rows.item(0));
            } else {
                deferred.reject();
            }
        });
    });
    return deferred.promise;
};

var get_submissions = function($q, id) {
    var deferred = $q.defer();
    db.transaction(function (tx) {
        tx.executeSql('SELECT * FROM submission WHERE id = \'' + id + '\' ORDER BY subtime DESC', [], function (tx, results) {
            var len = results.rows.length, i;
            if(len > 0) {
                var ret = [];
                for (i = 0; i < len; i++) {
                    ret.push(results.rows.item(i));
                }
                deferred.resolve(ret);
            } else {
                deferred.reject();
            }
        });
    });
    return deferred.promise;
};

var get_all_submissions = function(func) {
    db.transaction(function (tx) {
        tx.executeSql('SELECT * FROM submission ORDER BY subtime DESC', [], function (tx, results) {
            var len = results.rows.length, i;
            var ret = [];
            for (i = 0; i < len; i++) {
                ret.push(results.rows.item(i));
            }
            func(ret);
        });
    });
};

var add_submission = function(id, code, language, status, runtime, detail) {
    if(status != 'Accepted') runtime = 0;
    code = code.replace(new RegExp("'", 'g'), "''");
    db.transaction(function (tx) {
        var time = moment().format('YYYY-MM-DD HH:mm:ss');
        var query = 'INSERT INTO submission (id, code, subtime, language, status, detail, runtime) VALUES (\'' + id + '\',\'' + code + '\',\'' + time +  '\',\'' + language + '\',\'' + status + '\', \'' + detail + '\', ' + runtime + ')';
        tx.executeSql(query);
    });
};
