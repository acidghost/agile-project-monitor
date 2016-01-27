app = angular.module 'agileApp'

app.controller 'MonitorCtrl', ['config', 'Pengine', class MonitorCtrl

    config = Pengine = null

    constructor: (_config, _Pengine) ->
        config = _config
        Pengine = _Pengine

    do: ->
        project_id = @projectId
        console.log 'Doing monitor', project_id

]
