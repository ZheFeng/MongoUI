

mongoUi.config.routes = ($stateProvider, $urlRouterProvider) ->

  # stateSetting = (url, controllerName) ->
  #   setting =
  #     templateUrl: '/html/business/' + controllerName.replace(/\./g, '/') + '.html',
  #     controller: controllerName,
  #     url: url
  #   setting

  # $urlRouterProvider.otherwise('/') 
  # $stateProvider
  #   .state('home', stateSetting('/', 'home'))
  #   .state('campaigns', stateSetting('/campaigns', 'campaign.home'))
  #   .state('campaignsStatus', stateSetting('/campaigns/:status', 'campaign.home'))
  #   .state('campaign', stateSetting('/campaign/:id', 'campaign.campaign'))
  #   .state('campaign.edit', stateSetting('/edit', 'campaign.edit'))
  #   .state('campaign.filter', stateSetting('/filter', 'campaign.filter'))
mongoUi.config.routes.$inject = ['$stateProvider', '$urlRouterProvider'];

mongoUi.config.routerState = ($rootScope,   $state,   $stateParams) -> 
  $rootScope.$state = $state; 
  $rootScope.$stateParams = $stateParams;
  this
mongoUi.config.routerState.$inject = ['$rootScope', '$state', '$stateParams'];











# MongoLib
mongoUi.lib = angular.module 'MongoLib', []

# factory registration
mongoUi.lib.factory 'mongoUi.factory.template', mongoUi.factory.template
mongoUi.lib.factory 'mongoUi.factory.api', mongoUi.factory.api












# MongoUI
mongoUi.app = angular.module 'MongoUI', ['MongoLib', 'ngResource', 'ui.router']

mongoUi.app.run mongoUi.config.routerState


# config registration
mongoUi.app.config mongoUi.config.routes

# controller registration
mongoUi.app.controller 'main', mongoUi.controller.main
