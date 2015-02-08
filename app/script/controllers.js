'use strict';

/* Controllers */

var modes = {
    "C++" : "ace/mode/c_cpp",
    "Java" : "ace/mode/java",
    "Ruby" : "ace/mode/ruby",
    "Python" : "ace/mode/python",
    "Lua" : "ace/mode/lua"
};
var codes = {
    "C++" : "code_cpp",
    "Java" : "code_java",
    "Ruby" : "code_ruby",
    "Python" : "code_python",
    "Lua" : "code_lua"
};

var langs = [
    'C++',
    'Java',
    'Ruby',
    'Python',
    'Lua'
];

var fgdsbControllers = angular.module('fgdsbControllers', ['ui.bootstrap']);

fgdsbControllers.controller('ProblemListCtrl', ['$scope', '$q', 'Problem',
    function($scope, $q, Problem) {
        $scope.problems = Problem.query();
        $scope.problems.$promise.then(function (result) {
            result.sort(function (a, b) {
                var ta = moment(a.time, "YYYY-MM-DD HH:mm:ss");
                var tb = moment(b.time, "YYYY-MM-DD HH:mm:ss");
                return ta - tb;
            });
            for(var i = 0; i < result.length; ++i) {
                result[i].number = i+1;
                has_cleared($q, result[i]).then(function(){
                });
            }
        });
        $scope.orderProp = 'number';
    }]);

fgdsbControllers.controller('AddNewCtrl', ['$scope', '$q', '$routeParams', 'Problem',
    function($scope, $q, $routeParams, Problem) {
        $scope.languages = langs;
        $scope.cur_lang = 'C++';
        $scope.desc = "";
        $scope.question = {};
        $scope.question.name = "";
        $scope.question.discuss_url = "";
        $scope.question.difficulty = "Easy";
        $scope.question.source = "Unknown";
        $scope.question.id = $routeParams.problemId.replace(/id=/,'');
        $scope.judge_obj = {};
        $scope.judge_json = "";

        if ($scope.question.id != '') {
            $scope.problem = Problem.get({problemId: $scope.question.id, 'foo':new Date().getTime()}, function(problem) {
                var excluded_key = ["name", "id", "discuss_link", "desc",
                    "code_cpp", "code_java", "code_ruby", "code_python", "code_lua"];
                for (var prop in $scope.problem) {
                    if(excluded_key.indexOf(prop) >= 0) continue;
                    $scope.judge_obj[prop] = $scope.problem[prop];
                }
                $scope.judge_json = JSON.stringify($scope.judge_obj, null, '    ')
                    .replace(/"judge_type_cpp"/, '\n    $&')
                    .replace(/"judge_type_java"/, '\n    $&')
                    .replace(/"judge_type_lua"/, '\n    $&');
                $scope.$judge_editor.setValue($scope.judge_json);
                $scope.$judge_editor.clearSelection();

                $scope.question.name = $scope.problem.name;
                $scope.question.discuss_url = $scope.problem.discuss_link;
                $scope.question.difficulty = $scope.problem.difficulty;
                if ($scope.problem.source) {
                    $scope.question.source = $scope.problem.source;
                }
            });
        }

        $scope.onSave = function(e) {
            if ($scope.question.id == '') {
                bootbox.dialog({
                    message: "ID cannot be empty.",
                    title: "Error",
                    buttons: {
                        success: {
                            label: "OK",
                            className: "btn-success"
                        }
                    }
                });
            }
        };

        $scope.onClear = function(e) {
            bootbox.dialog({
                message: "Do you really want to clear all fields?",
                title: "Clear Confirmation",
                buttons: {
                    success: {
                        label: "No",
                        className: "btn-success"
                    },
                    danger: {
                        label: "Yes",
                        className: "btn-danger",
                        callback: function() {
                            $scope.doClear();
                        }
                    }
                }
            });
        };
        
        $scope.doClear = function () {
            
        };

        $scope.langClick = function($index) {
            var lang = $scope.languages[$index];
            $scope.cur_lang = lang;

            $("#cur-lang").text(lang);

            $scope.$default_code_editor.getSession().setMode(modes[lang]);
        };

        $scope.desc_editor_loaded = function(_editor) {
            $scope.$desc_editor = _editor;
            _editor.setFontSize(12);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true);
            _editor.setHighlightActiveLine(false);
            _editor.setValue('<p></p>');
            _editor.clearSelection();
        };

        $scope.desc_editor_changed = function(e) {
            $scope.desc = $scope.$desc_editor.getValue();
        };

        $scope.default_code_editor_loaded = function(_editor) {
            $scope.$default_code_editor = _editor;
            _editor.setFontSize(12);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true);
            _editor.setHighlightActiveLine(false);
        };

        $scope.default_code_editor_changed = function(e) {
        };

        $scope.script_editor_loaded = function(_editor) {
            $scope.$script_editor = _editor;
            _editor.setFontSize(12);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true);
            _editor.setHighlightActiveLine(false);
        };

        $scope.script_editor_changed = function(e) {
        };

        $scope.judge_editor_loaded = function(_editor) {
            $scope.$judge_editor = _editor;
            _editor.setFontSize(12);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true);
            _editor.setHighlightActiveLine(false);
        };

        $scope.judge_editor_changed = function(e) {
        };
    }]);

fgdsbControllers.controller('SubDetailCtrl', ['$scope', '$q', '$window', '$routeParams', 'Problem',

    function($scope, $q, $window, $routeParams, Problem) {

        $scope.onEdit = function() {
            update_autosave($scope.submission.id, $scope.submission.language, $scope.submission.code);
            $window.location.href = '#/problems/' + $scope.submission.id;
        };

        $scope.onDelete = function() {
            bootbox.dialog({
                message: "Do you really want to delete this submission?",
                title: "Delete Submission",
                buttons: {
                    success: {
                        label: "No",
                        className: "btn-success",
                        callback: function() {
                        }
                    },
                    danger: {
                        label: "Yes",
                        className: "btn-danger",
                        callback: function() {
                            clear_single_submission($q, $scope.submission.sid).then(function (){
                                var pa = '#/submissions/' + $scope.submission.id;
                                $window.location.href= pa;
                            });
                        }
                    }
                }
            });
        };

        $scope.aceLoaded = function(_editor) {
            $scope.$editor = _editor;
            _editor.setFontSize(14);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true)
            _editor.setReadOnly(true);
        };

        get_submission_detail($q, $routeParams.subid).then(function(data) {
            $scope.submission = data;
            $scope.problem = Problem.get({problemId: data.id, 'foo':new Date().getTime()}, function(problem) {
            });

            $scope.$editor.getSession().setMode(modes[$scope.submission.language]);
            $scope.$editor.setValue($scope.submission.code);
            $scope.$editor.clearSelection();

            $("#error-msg-div").hide();
            $("#wrong-answer-div").hide();
            $("#ac-msg-div").hide();

            if ($scope.submission.status == 'Compile Error') {
                $("#error-msg-div").show();
                $('#error-msg').text($scope.submission.detail);
            } else if ($scope.submission.status == 'Wrong Answer') {
                var was = $scope.submission.detail.split(';');
                $("#wrong-answer-div").show();
                $("#ret_wa_tests").text(was[0]);
                $("#ret_wa_input").text(was[1]);
                $("#ret_wa_output").text(was[2]);
                $("#ret_wa_expected").text(was[3]);
            } else if ($scope.submission.status == 'Accepted') {
                $("#ac-msg-div").show();
                $("#ac-msg").text("Run time : " + $scope.submission.runtime + " ms");
            }
        }, function() {

        });
    }]);

fgdsbControllers.controller('SubmissionsCtrl', ['$scope', '$q', '$routeParams', 'Problem',

    function($scope, $q, $routeParams, Problem) {
        var id = $routeParams.problemId;
        $scope.onClear = function() {
            bootbox.dialog({
                message: "Do you really want to delete all submissions for this problem?",
                title: "Clear Submissions",
                buttons: {
                    success: {
                        label: "No",
                        className: "btn-success",
                        callback: function() {
                        }
                    },
                    danger: {
                        label: "Yes",
                        className: "btn-danger",
                        callback: function() {
                            clear_submissions($q, $scope.problem.id).then(function (){
                                // update
                                $scope.subs = [];
                            });
                        }
                    }
                }
            });
        };

        $scope.problem = Problem.get({problemId: $routeParams.problemId, 'foo':new Date().getTime()}, function(problem) {
            get_submissions($q, id).then(function (data) {
                $scope.subs = data;
                for(var i = 0; i < data.length; ++i) {
                    $scope.subs[i].reltime = moment($scope.subs[i].subtime, "YYYY-MM-DD HH:mm:ss").fromNow();
                }
            }, function () {
                //console.log('no submission');
            });
        });
    }]);

fgdsbControllers.controller('ProblemDetailCtrl', ['$scope', '$routeParams', 'Problem',
    function($scope, $routeParams, Problem) {

        $scope.last_autosave = new Date().getTime();
        $scope.languages = langs;
        $scope.cur_lang = 'C++';

        var judge_funcs = {
            "C++" : judge_cpp,
            "Java" : judge_java,
            "Ruby" : judge_ruby,
            "Python" : judge_python,
            "Lua" : judge_lua
        };

        $scope.problem = Problem.get({problemId: $routeParams.problemId, 'foo':new Date().getTime()}, function(problem) {

            get_last_language($scope.problem['id'], function(last_lang) {
                $scope.cur_lang = last_lang;

                get_autosave($scope.problem['id'], $scope.cur_lang, function(data) {
                    if(!last_lang || last_lang == '') last_lang = "C++";
                    if($("#cur-lang").text() != $scope.cur_lang) {
                        $("#cur-lang").text($scope.cur_lang);
                        $scope.$editor.getSession().setMode(modes[$scope.cur_lang]);
                    }

                    if(data && data != '') {
                        $scope.$editor.setValue(data);
                    } else {
                        $scope.$editor.setValue(problem[codes[$scope.cur_lang]]);
                    }
                    $scope.$editor.clearSelection();
                });
            });
        });

        $scope.aceLoaded = function(_editor) {
            $scope.$editor = _editor;
            _editor.setFontSize(14);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;
            _editor.getSession().setUseSoftTabs(true)

            _editor.commands.addCommand({
                name: 'SaveCommand',
                bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
                exec: function(editor) {
                    update_autosave($scope.problem['id'], $scope.cur_lang, $scope.$editor.getValue());
                },
                readOnly: true // false if this command should not apply in readOnly mode
            });

            $('#error-msg-panel').hide();
            $('#submission-ret-panel').hide();
        };

        $scope.aceChanged = function(e) {
        };

        $scope.langClick = function($index) {
            var lang = $scope.languages[$index];
            $scope.cur_lang = lang;

            $("#cur-lang").text(lang);

            $scope.$editor.getSession().setMode(modes[lang]);

            get_autosave($scope.problem['id'], $scope.cur_lang, function(data){
                if(data && data != '') {
                    $scope.$editor.setValue(data);
                } else {
                    $scope.$editor.setValue($scope.problem[codes[$scope.cur_lang]]);
                }
                $scope.$editor.clearSelection();
            });
        };

        $('#debug-panel').on('DOMMouseScroll mousewheel', function(ev) {
            var $this = $(this),
                scrollTop = this.scrollTop,
                scrollHeight = this.scrollHeight,
                height = $this.height(),
                delta = (ev.type == 'DOMMouseScroll' ? ev.originalEvent.detail * -40 : ev.originalEvent.wheelDelta),
                up = delta > 0;

            var prevent = function() {
                ev.stopPropagation();
                ev.preventDefault();
                ev.returnValue = false;
                return false;
            }

            if (!up && -delta > scrollHeight - height - scrollTop) {
                $this.scrollTop(scrollHeight);
                return prevent();
            } else if (up && delta > scrollTop) {
                $this.scrollTop(0);
                return prevent();
            }
        });

        $scope.collapsed = true;
        $scope.onToggleDebug = function(e) {
            if ($scope.collapsed) {
                $scope.collapsed = false;
                $("#edit-panel").animate({
                    width: '100%'
                }, 250);
            } else {
                $scope.collapsed = true;
                $("#edit-panel").animate({
                    width: '135%'
                }, 250);
            }
        };

        $scope.onSave = function(e) {
            update_autosave($scope.problem['id'], $scope.cur_lang, $scope.$editor.getValue());
        };

        $scope.onReload = function(e) {
            $scope.$editor.setValue($scope.problem[codes[$scope.cur_lang]]);
            $scope.$editor.clearSelection();
        };

        $scope.onSubmit = function(e) {
            update_autosave($scope.problem['id'], $scope.cur_lang, $scope.$editor.getValue());

            $('#error-msg-panel').hide();
            $('#submission-ret-panel').show();

            var judge_f = judge_funcs[$scope.cur_lang];

            judge_f($scope, function(ret) {

                var detail = "";
                if (ret['result'] == 'Wrong Answer') {
                    detail = ret["tests"] + ";" + ret["input"] + ";" + ret["output"] + ";" + ret["expected"];
                } else if (ret['result'] == 'Compile Error') {
                    detail = ret['details'];
                }
                add_submission($scope.problem['id'], $scope.$editor.getValue(), $scope.cur_lang, ret['result'], ret['runtime'], detail);

                if (ret['result'] == 'Accepted') {
                    $('#judge-ret').css('color', '#398439');
                } else {
                    $('#judge-ret').css('color', '#ed432f');

                    $('#error-msg-panel').show();
                    $("#error-msg-div").hide();
                    $("#wrong-answer-div").hide();
                    if (ret['result'] == 'Compile Error' || ret['result'] == 'Runtime Error') {
                        $("#error-msg-div").show();
                        $('#error-msg').text(ret['details']);
                    } else if (ret['result'] == 'Wrong Answer') {
                        $("#wrong-answer-div").show();
                        $("#ret_wa_input").text(ret['input']);
                        $("#ret_wa_output").text(ret['output']);
                        $("#ret_wa_expected").text(ret['expected']);
                    }
                }
                $('#judge-ret').text(ret['result']);

                // std out file
                fs.readFile('judge/stdout.txt', function (err, data) {
                    if (err) throw err;

                    var obj = $("#debug-panel").text(data);
                    obj.html(obj.html().replace(/\n/g,'<br/>')
                        .replace(/Testing case #\d+/g,'<br><span class="label label-success">$&</span>')
                        .replace(/<br>/,''));
                });

            }, function(msg) {
                $('#judge-ret').css('color', '#158db8');
                $('#judge-ret').text(msg);
            });
        };
    }]);
