
mongoUi.controller.main = ($scope, $location, api, _) ->
  template = (name) ->
    '/html/mongoUi/' + name.replace(/\./g, '/') + '.html'

  $scope.title = 'Mongo UI'
  $scope.templates = 
    layout: template('layout')
    topbar: template('topbar')
    server:
      leftNav: template('server.leftNav')

  $scope.serverId = null
  $scope.server = null

  $scope.onLocatinoChange = ->
    setServer()

  setServer = ->
    $scope.server = null
    parseServerId = (id) -> if isNaN id then id else id * 1
    if angular.isArray($scope.servers) and angular.isDefined($scope.$stateParams.serverId)
      $scope.server = _.find($scope.servers, (server) -> server.id is parseServerId($scope.$stateParams.serverId))
      if angular.isUndefined($scope.server) then $location.path('/servers')


  $scope.servers = api.servers.query(-> setServer())

  this
mongoUi.controller.main.$inject = ['$scope', '$location', 'mongoUi.factory.api', 'mongoUi.factory.underscore']


mongoUi.controller.global = ($scope) ->
  $scope.onLocatinoChange()

  this
mongoUi.controller.global.$inject = ['$scope']


mongoUi.controller.server = ($scope, $location, api, _) ->
  $scope.onLocatinoChange = ->
    $scope.$parent.onLocatinoChange()
    fetchCollections()

  $scope.collections = {}
  $scope.nav =
    server: true
    databases: false

    hide: ->
      $scope.nav.server = false
      $scope.nav.databases = false
    show:
      server: ->
        $scope.nav.hide()
        $scope.nav.server = true
      databases: ->
        $scope.nav.hide()
        $scope.nav.databases = true
        # $location.path('/servers/' + $scope.server.id + '/databases/' + )

  $scope.databasesLoaded = false
  $scope.databases = api.databases.query {serverId: $scope.$stateParams.serverId}, ->
    addCollectionsToDatabases()
    $scope.databasesLoaded = true

  addCollectionsToDatabases = ->
    if angular.isArray($scope.databases)
      for database in $scope.databases
        database.collections = $scope.collections[database.name] if angular.isDefined($scope.collections[database.name])
  fetchCollections = ->
    serverId = $scope.$stateParams.serverId
    databaseName = $scope.$stateParams.databaseName
    if angular.isDefined(databaseName)
      $scope.collections[databaseName] = api.collections.query {serverId: serverId, databaseName: databaseName}, ->
        collection.displayName = collection.name.replace(databaseName + '.', '') for collection in $scope.collections[databaseName]
        addCollectionsToDatabases()

  $scope.goServer = ->
    $scope.nav.show.server()
  $scope.goDatabases = ->
    $scope.nav.show.databases()

  this
mongoUi.controller.server.$inject = ['$scope', '$location', 'mongoUi.factory.api', 'mongoUi.factory.underscore']


mongoUi.controller.server.index = ($scope, api) ->
  $scope.onLocatinoChange()
  this
mongoUi.controller.server.index.$inject = ['$scope', 'mongoUi.factory.api']


mongoUi.controller.server.database = ($scope, api) ->
  $scope.onLocatinoChange()


  this
mongoUi.controller.server.database.$inject = ['$scope', 'mongoUi.factory.api']



mongoUi.controller.server.collection = ($scope, api) ->
  $scope.onLocatinoChange()

  this
mongoUi.controller.server.collection.$inject = ['$scope', 'mongoUi.factory.api']