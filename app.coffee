
require("coffee-script")

express = require 'express'
eco = require 'eco'

# Criando o Server
app = express.createServer()

# Configuracoes do server
app.configure ->
	app.set 'views', __dirname + "/views"
	app.set 'view engine', 'eco'

	app.use express.bodyParser()
	app.use express.static(__dirname + "/public")

# Rota Root
app.get '/', (req, res) ->
	res.render 'login', title:'log in'

# Rota para o post
app.post '/login', (req, res) ->

	# Objeto vindo do form
	user = req.body.user

	# Para testes os dados do login são adicionados aqui. Porém, caso necessário
  # os mesmos podem vir de um banco de dados
	if user.name is 'admin' and user.password is 'admin'
		res.render 'loggedin', title: "Logged in as #{user.name}", user: user
	else
		res.render 'login', title:'Error', error:true


app.post '/logout', (req, res) ->
	res.render 'login', title:'logged out', loggedOut:true

# Executa o server
port = process.env.PORT or 9294
app.listen port, -> console.log "Server is starting on port: #{port}"
