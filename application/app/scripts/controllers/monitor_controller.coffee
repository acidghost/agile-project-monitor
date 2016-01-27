app = angular.module 'agileApp'

app.controller 'MonitorCtrl', ['config', 'Pengine', '$uibModal', 'view', class MonitorCtrl

    config = Pengine = $uibModal = viewProvider = null

    constructor: (_config, _Pengine, _$uibModal, _viewProvider) ->
        config = _config
        Pengine = _Pengine
        $uibModal = _$uibModal
        viewProvider = _viewProvider

    do: ->
        data =
            velocity: null
            burndown: null

        show_results = ->
            if data.velocity and data.burndown
                $uibModal.open(
                    templateUrl: 'templates/modal.html'
                    controller: ['$scope', 'results', ($scope, results) ->
                        $scope.results = results
                    ]
                    resolve:
                        results: -> data
                )

        velocity_query = "
            velocity_chart(#{@projectId}, Current, Mean, Percentile66, Percentile33),
            velocity_chart_discrepancy(Current, Percentile66, Percentile33, Discrepancy), !."

        Pengine(velocity_query).then (resp) ->
            resp = resp[0]
            console.log 'velocity', resp if config.debug
            data.velocity = resp
            show_results()

        burndown_query = "
            aggregated_burndown(#{@projectId}, Current, Mean, Behind, OnSchedule, Ahead),
            aggregated_burndown_discrepancy(Current, Behind, OnSchedule, Ahead, Discrepancy), !."

        Pengine(burndown_query).then (resp) ->
            resp = resp[0]
            console.log 'burndown', resp if config.debug
            data.burndown = resp
            show_results()

]
