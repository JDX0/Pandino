extends Node

func _ready():
	pass

func _process(_delta):
	pass

func select():
	Supabase.database.connect("selected", _on_selected)
	Supabase.database.connect("error", _on_database_error)
	var query = SupabaseQuery.new().from("scores").select()
	Supabase.database.query(query)
	
func _on_selected(result : Array):
	print(result)
	
func insert_score(value):
	Supabase.database.connect("error", _on_database_error)
	var query = SupabaseQuery.new().from("scores").insert([{"value":value,"user_id":State.user.id}])
	Supabase.database.query(query)
	
func sign_in(email,password):
	Supabase.auth.connect("signed_in", _on_signed_in)
	Supabase.auth.connect("error", _on_auth_error)
	Supabase.auth.sign_in(email,password)
	
func _on_signed_in(user : SupabaseUser):
	State.user = user
	print(State.user)
	
func update_account_info(username,description,country):
	var query = SupabaseQuery.new().from("profiles").update({"username":username,"description":description,"country_id":country}).eq("id",State.user.id)
	Supabase.database.query(query)

func _on_auth_error(error : SupabaseAuthError):
	print(error)
	
func _on_database_error(error : SupabaseDatabaseError):
	print(error)


