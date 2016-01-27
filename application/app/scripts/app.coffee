app = angular.module 'agileApp', [
  'ui.router',
  'ui.bootstrap'
]

app.constant 'config', require("../config/#{process.env.AGILE_ENV or 'dev'}")

app.directive 'showBtn', ->
  template: '<a class="btn btn-default btn-xs" ui-sref="{{state}}"><i class="fa fa-eye">&nbsp;</i>Show</a>'
  replace: true
  scope:
    state: '@'
  link: (scope) ->

app.directive 'backBtn', ->
  template: '<a class="btn btn-xs btn-default pull-right" ui-sref="{{state}}"><i class="fa fa-chevron-left fa-">&nbsp;</i>Back</a>'
  replace: true
  scope:
    state: '@'
  link: (scope) ->

app.directive 'monitorBtn', ->
  template: '<a ng-click="monitor.do()" class="btn btn-red btn-xs"><i class="fa fa-line-chart">&nbsp;</i>Monitor</a>'
  replace: true
  bindToController:
    projectId: '@'
  controllerAs: 'monitor',
  controller: 'MonitorCtrl'
