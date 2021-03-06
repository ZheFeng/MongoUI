
mongoUi.factory.underscore = ($window) ->
  $window._
mongoUi.factory.underscore.$inject = ['$window']

mongoUi.factory.string = ($window) ->
  $window.S
mongoUi.factory.underscore.$inject = ['$window']

mongoUi.factory.api = ($resource) -> 
  endPoint = '/api/'
  api = {}
  api.servers = do ($resource)->
    actions = 
      create:
        url: endPoint + 'servers/create'
        method: 'POST'
        cache: false
    $resource(endPoint + 'servers/:id')
  api.databases = do ($resource)->
    actions = 
      create:
        url: endPoint + 'servers/:serverId/databases/create'
        method: 'POST'
        cache: false
    $resource(endPoint + 'servers/:serverId/databases/:databaseName')
  api.collections = do ($resource)->
    actions = 
      create:
        url: endPoint + 'servers/:serverId/databases/:databaseName/collections/create'
        method: 'POST'
        cache: false
      count:
        url: endPoint + 'servers/:serverId/databases/:databaseName/collections/:collectionName/count'
        method: 'GET'
        cache: false
    $resource(endPoint + 'servers/:serverId/databases/:databaseName/collections/:collectionName', {}, actions)

  api
mongoUi.factory.api.$inject = ['$resource']