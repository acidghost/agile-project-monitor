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
            .state 'project',
                url: '/project/:id',
                template: viewProvider.renderView 'project'
                controller: 'ProjectCtrl'
                controllerAs: 'project'
                resolve:
                    iterations: ['$stateParams', 'Pengine', ($stateParams, Pengine) ->
                        proj_id = $stateParams.id
                        query = Pengine("
                            project_iteration(#{proj_id}, ItId),
                            iteration(ItId, Start, End).")
                        query.then (data) ->
                            data.map (it) ->
                                id: it.ItId
                                start: new Date(it.Start * 1000)
                                end: new Date(it.End * 1000)
                    ]
            .state 'iteration',
                url: '/iteration/:id'
                template: viewProvider.renderView 'iteration'
                controller: 'IterationCtrl',
                controllerAs: 'iteration'
                resolve:
                    iteration: ['$stateParams', 'Pengine', ($stateParams, Pengine) ->
                        it_id = $stateParams.id
                        query = Pengine("iteration(#{it_id}, Start, End), project_iteration(PId, #{it_id}).")
                        query.then (data) ->
                            mapped = data.map (it) ->
                                id: it_id
                                start: new Date(it.Start * 1000)
                                end: new Date(it.End * 1000)
                                project_id: it.PId
                            mapped[0]
                    ]
                    updates: ['$stateParams', 'Pengine', ($stateParams, Pengine) ->
                        it_id = $stateParams.id
                        query = Pengine("
                            iteration_updates(#{it_id}, UpdateIds),
                            task_update(UId, TId, When, Init, Rem),
                            task(TId, Name, Story, Labels),
                            member(UId, UpdateIds); !.")
                        query.then (data) ->
                            data.map (update) ->
                                id: update.UId
                                task:
                                    id: update.TId
                                    name: update.Name
                                    story: update.Story
                                    labels: update.Labels
                                when: new Date(update.When * 1000)
                                initial: update.Init
                                remaining: update.Rem
                    ]

]
