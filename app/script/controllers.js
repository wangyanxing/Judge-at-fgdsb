'use strict';

/* Controllers */

var fgdsbControllers = angular.module('fgdsbControllers', ['ui.bootstrap']);

fgdsbControllers.controller('ProblemListCtrl', ['$scope', 'Problem',
    function($scope, Problem) {
        $scope.problems = Problem.query();
        $scope.orderProp = 'age';
    }]);

fgdsbControllers.controller('ProblemDetailCtrl', ['$scope', '$routeParams', 'Problem',
    function($scope, $routeParams, Problem) {

        $scope.languages = [
            'C++',
            'Java',
            'Ruby',
            'Python'
        ];
        $scope.cur_lang = 'C++';

        $scope.problem = Problem.get({problemId: $routeParams.problemId, 'foo':new Date().getTime()}, function(problem) {
            $scope.$editor.setValue(problem['code_cpp']);
            $scope.$editor.clearSelection();
        });

        $scope.aceLoaded = function(_editor) {
            $scope.$editor = _editor;
            _editor.setFontSize(14);
            _editor.setHighlightActiveLine(false);
            _editor.$blockScrolling = Infinity;

            $('#error-msg-panel').hide();
            $('#submission-ret-panel').hide();
        };

        $scope.aceChanged = function(e) {
        };

        $scope.langClick = function($index) {
            var lang = $scope.languages[$index];
            $scope.cur_lang = lang;

            $("#cur-lang").text(lang);
            var modes = {
                "C++" : "ace/mode/c_cpp",
                "Java" : "ace/mode/java",
                "Ruby" : "ace/mode/ruby",
                "Python" : "ace/mode/python"
            };
            var codes = {
                "C++" : "code_cpp",
                "Java" : "code_java",
                "Ruby" : "code_ruby",
                "Python" : "code_python"
            };
            $scope.$editor.getSession().setMode(modes[lang]);
            $scope.$editor.setValue($scope.problem[codes[lang]]);
            $scope.$editor.clearSelection();
        };

        $scope.onSubmit = function(e) {
            $('#error-msg-panel').hide();
            $('#submission-ret-panel').show();

            var judge_funcs = {
                "C++" : judge_cpp,
                "Java" : judge_java,
                "Ruby" : judge_ruby,
                "Python" : judge_python
            };
            var judge_f = judge_funcs[$scope.cur_lang];

            judge_f($scope, function(ret){
                if (ret['result'] == 'Accepted') {
                    $('#judge-ret').css('color', '#398439');
                } else {
                    $('#judge-ret').css('color', '#ed432f');

                    $('#error-msg-panel').show();
                    $("#error-msg-div").hide();
                    $("#wrong-answer-div").hide();
                    if (ret['result'] == 'Compile Error') {
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
