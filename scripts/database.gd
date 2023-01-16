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
	var query = SupabaseQuery.new().from("scores").insert([{"value":value}])
	Supabase.database.query(query)
	
	
func sign_in(email,password):
	Supabase.auth.connect("signed_in", _on_signed_in)
	Supabase.auth.sign_in(email,password)

func _on_signed_in(user : SupabaseUser):
	print("Successfully signed as ", user)
	print(Supabase.auth.__get_session_header())
	

func sign_up(email,password):
	var auth_task: AuthTask = await Supabase.auth.sign_up(
		email,
		password
	).completed
	print(auth_task.user)
	print(Supabase.auth.user())


