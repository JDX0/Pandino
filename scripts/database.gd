extends Node

func _ready():
	pass

func _process(_delta):
	pass

func select():
	Supabase.database.connect("selected", _on_selected)
	var query = SupabaseQuery.new().from("scores").select()
	Supabase.database.query(query)
	
func _on_selected(result : Array):
	print(result)
	
func insert_score(value):
	var query = SupabaseQuery.new().from("scores").insert([{"value":value,"user_id":State.user.id}])
	Supabase.database.connect("error", _on_insert_score_error)
	Supabase.database.query(query)
	
func sign_in(email,password):
	Supabase.auth.connect("signed_in", _on_signed_in)
	Supabase.auth.connect("error", _on_auth_error)
	Supabase.auth.sign_in(email,password)
	
func _on_signed_in(user : SupabaseUser):
	State.user = user
	print(State.user)
	
func insert_account_info(username,description):
	var query = SupabaseQuery.new().from("profiles").insert([{"id":State.user.id,"username":username,"description":description}])
	Supabase.database.connect("error", _on_database_error)
	Supabase.database.query(query)
	
func update_account_info(username,description):
	var query = SupabaseQuery.new().from("profiles").update({"username":username,"description":description}).eq("id",State.user.id)
	Supabase.database.connect("error", _on_database_error)
	Supabase.database.query(query)

func _on_auth_error(error : SupabaseAuthError):
	print(error)
	
func _on_database_error(error : SupabaseDatabaseError):
	print(error)
	
func _on_insert_score_error(error : SupabaseDatabaseError):
	print(error)


