app = angular.module 'agileApp'

app.controller 'ProjectCtrl', [ 'config', 'Pengine', 'project', 'iterations', class ProjectCtrl

    config = Pengine = null

    constructor: (_config, _Pengine, @project, @iterations) ->
        config = _config
        Pengine = _Pengine

]
