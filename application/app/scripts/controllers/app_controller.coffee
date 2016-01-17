app = angular.module 'agileApp'

app.controller 'AppCtrl', [ 'config', 'Pengine', class AppCtrl

    gui = require 'nw.gui'
    win = gui.Window.get()
    config = null
    Pengine = null

    constructor: (_config, _Pengine) ->
        config = _config
        Pengine = _Pengine
        win.showDevTools() if config.debug

        projects_query = Pengine('project(Id, Name, Start, End, Iterations).')
        projects_query.then (data) =>
            @projects = _.map data, (proj) ->
                id: proj.Id
                name: proj.Name
                start: new Date(proj.Start * 1000)
                end: new Date(proj.End * 1000)
                iterations: []

        iterations_query = Pengine('iteration(Id, Start, End, _).')
        iterations_query.then (data) ->
            console.log data


    exitApp: -> gui.App.quit()

]
