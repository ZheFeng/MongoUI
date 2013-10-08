

mongoUi.directive.ClickOutside = ($document) ->
  directiveDefinitionObject = 
    link: 
      pre: (scope, element, attrs, controller) ->
      post: (scope, element, attrs, controller) ->
        onClick = (event) ->
          if !element.has(event.target).length
            scope.$apply(attrs.mgClickOutside)
        $document.click(onClick)
  directiveDefinitionObject
mongoUi.directive.ClickOutside.$inject = ['$document']


mongoUi.directive.jsonTable = (_) ->
  directiveDefinitionObject = 
    templateUrl: '/html/directiveTemplates/jsonTable.html'
    scope: 
      documents: '='
    link: 
      pre: (scope, element, attrs, controller) ->
      post: (scope, element, attrs, controller) ->

        scope.$watch 'documents', ->
          generateColumns()

        generateColumns = ->
          scope.columns = [];
          _.each scope.documents, (document) ->
            scope.columns = _.union(scope.columns, _.keys(document))
        generateColumns()


  directiveDefinitionObject
mongoUi.directive.jsonTable.$inject = ['mongoUi.factory.underscore']