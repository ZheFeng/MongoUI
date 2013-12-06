'use strict'

_ = require 'underscore'
_.templateSettings = interpolate: /\{\{(.+?)\}\}/g
mongodb = require 'mongodb'
q = require 'q'

class Mongo
  config = null
  constructor: (customConfig) ->
    config = new ServerConfig(customConfig)
  databases: ->
    deferred = q.defer()


    deferred.resolve [{name: config.db()}]
    # if this.config.hasDb() 
    #   deferred.resolve this.config.db()
    # else
    #   success = (businessCount) ->
    #     deferred.resolve businessCount
    #   accountModels.business.count().success(success).error deferred.reject

    deferred.promise
  collections: ->
    deferred = q.defer()

    mongodb.MongoClient.connect config.connectionString(), (err, db) ->
      if err 
       deferred.reject err
      else 
        db.collectionNames (err, names) ->
          db.close();
          if err 
            deferred.reject err 
          else 
            deferred.resolve names

    deferred.promise
  collection: (collectionName, query, skip, limit)->
    deferred = q.defer()

    mongodb.MongoClient.connect config.connectionString(), (err, db) ->
      if err 
       deferred.reject err
      else 
        collection = db.collection(collectionName)
        collection.find(query, {}, skip, limit).toArray (err, docs) ->
          db.close();
          if err 
            deferred.reject err 
          else 
            deferred.resolve docs

    deferred.promise
  count: (collectionName, query)->
    deferred = q.defer()

    mongodb.MongoClient.connect config.connectionString(), (err, db) ->
      if err 
       deferred.reject err
      else 
        collection = db.collection(collectionName)
        collection.count query, (err, count) ->
          db.close();
          if err 
            deferred.reject err 
          else 
            deferred.resolve count

    deferred.promise



class ServerConfig
  config = {}

  constructor: (customConfig) ->
    defaultConfig = 
      host: '127.0.0.1'
      port: 27017
      username: null
      password: null
      database: 'test'
    config = _.extend(defaultConfig, customConfig || {})

  hasStringValue = (val)->
    val and typeof val is 'string'

  hasAuth: ->
    hasStringValue(config.username) and hasStringValue(config.password)
  hasDb: ->
    hasStringValue config.database
  db: -> if this.hasDb() then config.database else null
  connectionString: ->
    authString = if this.hasAuth() then _.template('{{username}}:{{password}}@', config) else ''
    dbString = if this.hasDb() then _.template('/{{database}}', config) else ''


    template = _.template 'mongodb://{{authString}}{{host}}:{{port}}{{dbString}}'
    data = 
      authString: authString
      dbString: dbString
    data = _.extend(data, config)

    template(data)


exports.Mongo = (config) ->
  new Mongo(config)