extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func select():
	Supabase.database.connect("selected", _on_selected)
	var query = SupabaseQuery.new().from("scores").select()
	Supabase.database.query(query)
	
func _on_selected(result : Array):
	print(result)
	
	
func insert_score(value):
	var query = SupabaseQuery.new().from("scores").insert([{"value":value,"user_id":State.user.id}])
	Supabase.database.connect("error", _on_database_error)
	Supabase.database.query(query)
	
	
func sign_in(email,password):
	Supabase.auth.connect("signed_in", _on_signed_in)
	Supabase.auth.connect("error", _on_auth_error)
	Supabase.auth.sign_in(email,password)
	
func _on_signed_in(user : SupabaseUser):
	State.user = user
	print(State.user)
	
func _on_auth_error(error : SupabaseAuthError):
	print(error)
	
func _on_database_error(error : SupabaseDatabaseError):
	print(error)

func sign_up(email,password):
	var auth_task: AuthTask = await Supabase.auth.sign_up(
		email,
		password
	).completed
	State.user = auth_task.user
	print(State.user)
	
func insert_account_info(username,description):
	var query = SupabaseQuery.new().from("profiles").insert([{"id":State.user.id,"username":username,"description":description}])
	Supabase.database.connect("error", _on_database_error)
	Supabase.database.query(query)


