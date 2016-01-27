app = angular.module 'agileApp'

app.controller 'IterationCtrl', [ 'config', 'Pengine', 'iteration', 'updates', class IterationCtrl

    config = Pengine = null

    constructor: (_config, _Pengine, @iteration, @updates) ->
        config = _config
        Pengine = _Pengine

        @grouped = _.groupBy(@updates, 'task.id')
        delete @grouped._
        @last_task_id = _.last(_.keys(@grouped))

]

