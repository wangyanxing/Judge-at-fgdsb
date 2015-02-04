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

var fgdsbControllers = angular.module('fgdsbControllers', ['ui.bootstrap']);

fgdsbControllers.controller('ProblemListCtrl', ['$scope', 'Problem',
    function($scope, Problem) {
        $scope.problems = Problem.query();
        $scope.orderProp = 'age';
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
        $scope.languages = [
            'C++',
            'Java',
            'Ruby',
            'Python',
            'Lua'
        ];
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
            }, function(msg) {
                $('#judge-ret').css('color', '#158db8');
                $('#judge-ret').text(msg);
            });
        };
    }]);
