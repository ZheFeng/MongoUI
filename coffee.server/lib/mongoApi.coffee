'use strict'

mongodb = require "mongodb"

getCollections = (callback, context) ->
  # server = new mongodb.Server('mongo1.prod.pureprofile.com', 27017, {native_parser: true})
  # db = new mongodb.Db('dnaOld', server)
  db = null

  sendBackCollectionNames = (err, names) ->
    console.log names
    db.close();
    if err then callback.apply(context or {}, [err]) else callback.apply(context or {}, [null, names])

  collections = (err, authDb) ->
    if err then callback.apply(context or {}, [err]) else db = authDb; db.collectionNames(sendBackCollectionNames)

  # authenticate = (err, db) ->
  #   if err then callback.apply(context or {}, [err]) else db.authenticate('pureprofile','Adm1nSQL!', collectionNames)

  # db.open(authenticate)

  mongodb.MongoClient.connect("mongodb://pureprofile:Adm1nSQL!@mongo1.prod.pureprofile.com:27017/dnaOld",collections)
  

exports = module.exports = (server) ->
  server.get('/api/collections', (req, res) ->
    getCollections((err, names)-> res.send(names))
  )