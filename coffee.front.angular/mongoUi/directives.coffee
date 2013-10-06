

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