
mongoUi.controller.main = ($scope, template, api) ->
  tempalteEndPoint = '/html/mongoUi/'

  $scope.title = 'Mongo UI'
  $scope.templates = 
    layout: template('layout')
    leftNav: template('leftNav')


  $scope.collections = api.collections.query()

  this
mongoUi.controller.main.$inject = ['$scope', 'mongoUi.factory.template', 'mongoUi.factory.api']