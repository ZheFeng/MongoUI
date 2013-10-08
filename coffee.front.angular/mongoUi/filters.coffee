mongoUi.filter.string = (stringjs)->
  (input, funcName)->
    obj = stringjs(input)
    func = obj[funcName]
    args = []
    args.push arg for arg, i in arguments when i > 1
    func.apply(obj, args).s
mongoUi.filter.string.$inject = ['mongoUi.factory.string']


mongoUi.filter.truncate = ()->
  (input, count)->
    return input if input.length <= count
    truncate = input.substring(0, count - 3)
    return truncate + '...'


mongoUi.filter.jsonCell = ($filter) ->
  format = (data) ->
    return "[ ... ]" if angular.isArray(data)
    return "{ ... }" if angular.isObject(data)
    # return $filter('truncate')(data, 20) if angular.isString(data)
    return $filter('json')(data)


  return (input) ->
    return format(input)

mongoUi.filter.jsonCell.$inject = ['$filter']