app = angular.module 'agileApp'

app.controller 'AppCtrl', [ 'config', class AppCtrl

    gui = require 'nw.gui'
    win = gui.Window.get()

    constructor: (config) ->
        win.showDevTools() if config.debug

    exitApp: ->
        # Allow saving...
        window.setTimeout gui.App.quit, 100

]
