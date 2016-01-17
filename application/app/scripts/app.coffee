app = angular.module 'agileApp', [
  'ui.router',
  'ui.bootstrap'
]

app.constant 'config', require("../config/#{process.env.AGILE_ENV or 'dev'}")
