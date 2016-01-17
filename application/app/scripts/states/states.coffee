app = angular.module 'agileApp'

app.config [ '$urlRouterProvider', '$stateProvider', 'viewProvider',
  ($urlRouterProvider, $stateProvider, viewProvider) ->

    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        template: viewProvider.renderView 'home'
        controller: 'HomeCtrl',
        controllerAs: 'home'

]
