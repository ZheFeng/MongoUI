'use strict'

_ = require 'underscore'
mongo = require('../lib/mongoResource').Mongo


servers = [{
        username: '',
        password: '!',
        host: 'localhost',
        port: 27017,
        database: ''
        name: ''
        id: 1
  }]

exports = module.exports = (server) ->
  server.get '/api/servers', (req, res) ->
    serversInfo = (_.pick(serverConfig, 'id', 'name') for serverConfig in servers)
    res.send(serversInfo)

  server.get '/api/servers/:serverId/databases', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    mongo(serverInfo).databases().then((databases)-> res.send(databases))

  server.get '/api/servers/:serverId/databases/:databaseName/collections', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    mongo(serverInfo).collections().then((collections)-> res.send(collections))

  # server.get '/api/servers/:serverId/databases/:databaseName/collections/:collectionName', (req, res) ->
  #   serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
  #   mongoServer = mongo(serverInfo);

  #   promise = q.all([ mongoServer.collection(req.params.collectionName, req.query.skip, req.query.limit), mongoServer.count(req.params.collectionName) ])

  #   promise.then((collections, count)-> res.send({collections:collections, count:count})).fail((err) -> res.send(500, err))

  server.get '/api/servers/:serverId/databases/:databaseName/collections/:collectionName', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)

    collectionName = req.params.collectionName
    skip = req.query.skip
    limit = req.query.limit
    query =  JSON.parse(req.query.query)

    mongoServer = mongo(serverInfo);
    promise = mongoServer.collection(collectionName, query, skip, limit)
    promise.then((docs) -> res.send(docs)).fail((err) -> res.send(500, err))

  server.get '/api/servers/:serverId/databases/:databaseName/collections/:collectionName/count', (req, res) ->
    serverInfo = _.find(servers, (server) -> server.id is req.params.serverId * 1)
    query =  JSON.parse(req.query.query)
    mongoServer = mongo(serverInfo);

    promise = mongoServer.count(req.params.collectionName, query)

    promise.then((count) -> res.send({count:count})).fail((err) -> res.send(500, err))
