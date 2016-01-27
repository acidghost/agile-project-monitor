app = angular.module 'agileApp'

app.controller 'ProjectCtrl', [ 'config', 'Pengine', 'iterations', class ProjectCtrl

    config = Pengine = null

    constructor: (_config, _Pengine, @iterations) ->
        config = _config
        Pengine = _Pengine

]
