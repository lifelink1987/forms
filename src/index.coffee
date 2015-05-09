port = process.env.PORT
port ?= 8080

config = require(__dirname + '/../package.json').config
_ = require 'lodash'
express = require 'express'
bodyParser = require 'body-parser'
mysql = require 'mysql'

app = express()
app.use express.static "#{__dirname}/../public"
app.use bodyParser.urlencoded extended: true
app.use bodyParser.multipart()

app.post '/register/school', (req, resp) ->
  db = mysql.createConnection {
    host: config.mysql.host
    user: config.mysql.user
    password: config.mysql.password
    database: config.mysql.database
  }
  async.waterfall [
    db.connect
    (next) ->
      school = _.pick body, ['school']
      db.query 'INSERT INTO member_schools SET ?', school, (err, results) ->
        next err  if err?
        next()
    db.end



app.post '/register/action', () ->

app.listen port
console.log "Listening on port #{port}..."
