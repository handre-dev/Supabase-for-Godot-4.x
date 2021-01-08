extends Node

const ENVIRONMENT_VARIABLES : String = "supabase/config/"

var auth : SupabaseAuth
var database : SupabaseDatabase

var config : Dictionary = {
	"supabaseUrl": "https://swoxtqjlueblkgbdskuo.supabase.co",
	"supabaseKey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYwOTY5MjU1NiwiZXhwIjoxOTI1MjY4NTU2fQ.asoFYnjYrbUFjb83nJ-J76CO_KebszxyFUsu8BKcxaQ"
}

var header : PoolStringArray = [
	"Content-Type: application/json",
	"Accept: application/json"
]

func _ready() -> void:
	load_config()
	load_nodes()

# Load all config settings from ProjectSettings
func load_config() -> void:
	if ProjectSettings.has_setting(ENVIRONMENT_VARIABLES+"supabaseUrl"):
		for key in config.keys(): 
			var setting : String = ProjectSettings.get_setting(ENVIRONMENT_VARIABLES+key)
			config[key] = setting if setting!=null and setting!="" else config[key]
	else: printerr("No configuration settings found, add them in override.cfg file.")
	header.append("apikey: %s"%[config.supabaseKey])

func load_nodes() -> void:
	auth = SupabaseAuth.new(config, header)
	add_child(auth)
	
	database = SupabaseDatabase.new(config, header)
	add_child(database)
