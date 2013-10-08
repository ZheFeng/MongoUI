


mongoUi.config.routes = ($stateProvider, $urlRouterProvider) ->
  template = (name) ->
    '/html/mongoUi/' + name.replace(/\./g, '/') + '.html'

  stateSetting = (url, controllerName) ->
    setting =
      templateUrl:  template controllerName
      controller: controllerName
      url: url
    setting

  $urlRouterProvider.otherwise('/') 
  $stateProvider
    .state('global', stateSetting('/', 'global'))
    .state('server', stateSetting('/servers/:serverId', 'server'))
    .state('server.index', stateSetting('/', 'server.index'))
    .state('server.databases', stateSetting('/databases', 'server.databases'))
    .state('server.database', stateSetting('/databases/:databaseName', 'server.database'))
    .state('server.collections', stateSetting('/databases/:databaseName/collections', 'server.collections'))
    .state('server.collection', stateSetting('/databases/:databaseName/collections/:collectionName', 'server.collection'))
    # .state('campaigns', stateSetting('/campaigns', 'campaign.home'))
    # .state('campaignsStatus', stateSetting('/campaigns/:status', 'campaign.home'))
    # .state('campaign', stateSetting('/campaign/:id', 'campaign.campaign'))
    # .state('campaign.edit', stateSetting('/edit', 'campaign.edit'))
    # .state('campaign.filter', stateSetting('/filter', 'campaign.filter'))
mongoUi.config.routes.$inject = ['$stateProvider', '$urlRouterProvider'];

mongoUi.config.routerState = ($rootScope, $state, $stateParams) -> 
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
  this
mongoUi.config.routerState.$inject = ['$rootScope', '$state', '$stateParams'];





