extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select():
	Supabase.database.connect("selected", self._on_selected)
	var query = SupabaseQuery.new().from("scores").select()
	Supabase.database.query(query)
	
func insert_score(value):
	var query = SupabaseQuery.new().from("scores").insert([{"value":value}])
	Supabase.database.query(query)

func _on_selected(result : Array):
	print(result)

