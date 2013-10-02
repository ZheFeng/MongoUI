
mongoUi.factory.template = ->
  (name) ->
    '/html/mongoUi/' + name.replace(/\./g, '/') + '.html'


mongoUi.factory.api = ($resource) -> 
  endPoint = '/api/'
  api = {}
  api.collections = do ($resource)->
    actions = 
      create:
        url: endPoint + 'collections/create'
        method: 'POST'
        cache: false
    $resource(endPoint + 'collections/:name')

  api
mongoUi.factory.api.$inject = ['$resource']