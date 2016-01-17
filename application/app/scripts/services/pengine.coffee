app = angular.module 'agileApp'

app.factory 'Pengine', ['config', '$q', (config, $q) ->

    (query) ->
        response = []
        pengine = null
        $q (resolve, reject) ->
            pengine = new Pengine(
                application: 'monitoring'
                ask: query
                onsuccess: ->
                    response = response.concat @data
                    if @more
                        pengine.next()
                    else
                        resolve response
                onerror: ->
                    reject @data
                onfailure: ->
                    reject @data
                server: "#{config.prolog_url}/pengine"
            )

]
