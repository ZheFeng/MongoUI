
mongoUi.controller.main = ($scope, $location, api, _) ->
  template = (name) ->
    '/html/mongoUi/' + name.replace(/\./g, '/') + '.html'

  $scope.title = 'Mongo UI'
  $scope.templates = 
    layout: template('layout')
    topbar: template('topbar')
    server:
      leftNav: template('server.leftNav')

  $scope.server = null

  $scope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    trySelectServer()


  trySelectServer = ->
    $scope.server = null
    parseServerId = (id) -> if isNaN id then id else id * 1
    if angular.isArray($scope.servers) and angular.isDefined($scope.$stateParams.serverId)
      serverId = parseServerId($scope.$stateParams.serverId)
      $scope.server = _.find($scope.servers, (server) -> server.id is serverId)
      if angular.isUndefined($scope.server) then $location.path('/servers')
    this
  fetchServers = ->
    $scope.servers = api.servers.query(-> trySelectServer())
    this

  fetchServers()
  this
mongoUi.controller.main.$inject = ['$scope', '$location', 'mongoUi.factory.api', 'mongoUi.factory.underscore']


mongoUi.controller.global = ($scope) ->

  this
mongoUi.controller.global.$inject = ['$scope']


mongoUi.controller.server = ($scope, $location, api, _) ->
  $scope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    fetchCollections() if toState.name is 'server.database' || angular.isUndefined($scope.collections[$scope.$stateParams.databaseName])
    

  $scope.collections = {}
  $scope.databases = api.databases.query {serverId: $scope.$stateParams.serverId}, ->

  fetchCollections = ->
    serverId = $scope.$stateParams.serverId
    databaseName = $scope.$stateParams.databaseName
    if angular.isDefined(databaseName)
      $scope.collections[databaseName] = [];
      $scope.collections[databaseName] = api.collections.query {serverId: serverId, databaseName: databaseName}, ->
        for collection in $scope.collections[databaseName]
          collection.fullName = collection.name
          collection.name = collection.name.replace(databaseName + '.', '') 

  $scope.databaseToggle = (database) ->
    if($scope.$state.is('server.databases'))
      $scope.$state.go('server.database', {databaseName: database.name})
    else
      $scope.$state.go('server.databases')

  this
mongoUi.controller.server.$inject = ['$scope', '$location', 'mongoUi.factory.api', 'mongoUi.factory.underscore']


mongoUi.controller.server.index = ($scope, api) ->

  this
mongoUi.controller.server.index.$inject = ['$scope', 'mongoUi.factory.api']


mongoUi.controller.server.databases = ($scope, api) ->



  this
mongoUi.controller.server.databases.$inject = ['$scope', 'mongoUi.factory.api']


mongoUi.controller.server.database = ($scope, api) ->


  this
mongoUi.controller.server.database.$inject = ['$scope', 'mongoUi.factory.api']


mongoUi.controller.server.collections = ($scope, api) ->


  this
mongoUi.controller.server.collections.$inject = ['$scope', 'mongoUi.factory.api']


mongoUi.controller.server.collection = ($scope, api) ->
  $scope.limit = 10
  $scope.skip = 0

  $scope.fetch = ->
    $scope.documents = []
    query = angular.extend({
      skip: $scope.skip
      limit: $scope.limit
    }, $scope.$stateParams)
    api.collections.query query, (documents) -> $scope.documents = documents

  $scope.fetch()

  this
mongoUi.controller.server.collection.$inject = ['$scope', 'mongoUi.factory.api']