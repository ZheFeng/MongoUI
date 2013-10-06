

# MongoLib
mongoUi.lib = angular.module 'MongoLib', []

# factory registration
mongoUi.lib.factory 'mongoUi.factory.api', mongoUi.factory.api
mongoUi.lib.factory 'mongoUi.factory.underscore', mongoUi.factory.underscore

# directive registration
mongoUi.lib.directive 'mgClickOutside', mongoUi.directive.ClickOutside









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
mongoUi.app.controller 'server.database', mongoUi.controller.server.database
mongoUi.app.controller 'server.collection', mongoUi.controller.server.collection
