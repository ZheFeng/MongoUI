

# MongoLib
mongoUi.lib = angular.module 'MongoLib', []

# factory registration
mongoUi.lib.factory 'mongoUi.factory.api', mongoUi.factory.api
mongoUi.lib.factory 'mongoUi.factory.underscore', mongoUi.factory.underscore
mongoUi.lib.factory 'mongoUi.factory.string', mongoUi.factory.string

# directive registration
mongoUi.lib.directive 'mgClickOutside', mongoUi.directive.ClickOutside
mongoUi.lib.directive 'mgJsonTable', mongoUi.directive.jsonTable

# filter registration
mongoUi.lib.filter 'string', mongoUi.filter.string
mongoUi.lib.filter 'truncate', mongoUi.filter.truncate
mongoUi.lib.filter 'jsonCell', mongoUi.filter.jsonCell







# MongoUI
mongoUi.app = angular.module 'MongoUI', ['MongoLib', 'ngResource', 'ui.router']
mongoUi.app.run mongoUi.config.routerState


# config registration
mongoUi.app.config mongoUi.config.routes

# controller registration
mongoUi.app.controller 'main', mongoUi.controller.main
mongoUi.app.controller 'global', mongoUi.controller.global
mongoUi.app.controller 'server', mongoUi.controller.server
mongoUi.app.controller 'server.index', mongoUi.controller.server.index
mongoUi.app.controller 'server.databases', mongoUi.controller.server.databases
mongoUi.app.controller 'server.database', mongoUi.controller.server.database
mongoUi.app.controller 'server.collections', mongoUi.controller.server.collections
mongoUi.app.controller 'server.collection', mongoUi.controller.server.collection
