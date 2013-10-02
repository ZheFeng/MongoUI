'use strict'


process.env.NODE_ENV = 'development' if !process.env.NODE_ENV
process.env.PORT = 3000 if !process.env.PORT
isDev = process.env.NODE_ENV is 'development' 

express = require 'express'
http = require 'http'
path = require 'path'

app = express()

app.set('port', process.env.PORT)
app.set('views', __dirname + '/../views')
app.set('view engine', 'jade')
app.use(express.favicon())

app.use(express.bodyParser())
app.use(express.methodOverride())


app.use(app.router)
app.use(express.static(path.join(__dirname, '../public')))

app.use(isDev) if process.env.NODE_ENV is 'development'
# if ('development' == app.get('env')) {
  # app.use(express.errorHandler())
# }

app.get('/', (req, res) -> res.render('index', { title: 'MongoUI' }))
require('./lib/mongoApi')(app)

now = new Date()
now = 'start at ' + now
http.createServer(app).listen(app.get('port'), -> console.log('MongoUI server listening on port ' + app.get('port') + ' ' + now))
