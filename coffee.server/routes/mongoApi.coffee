'use strict'

_ = require 'underscore'
mongo = require('../lib/mongoResource').Mongo


servers = require '../config/servers'

exports = module.exports = (server) ->
  server.get('/api/servers', (req, res) ->
    serversInfo = (_.pick(serverConfig, 'id', 'name') for serverConfig in servers)
    res.send(serversInfo)
  )
  server.get('/api/servers/:serverId/databases', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    mongo(serverInfo).databases().then((databases)-> res.send(databases))
  )
  server.get('/api/servers/:serverId/databases/:databaseName/collections', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    mongo(serverInfo).collections().then((collections)-> res.send(collections))
  )
  server.get('/api/servers/:serverId/databases/:databaseName/collections/:collectionName', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    mongo(serverInfo).collection(req.params.collectionName, req.query.skip, req.query.limit)
    .then((collections)-> res.send(collections)).fail((err) -> res.send(500, err))
  )