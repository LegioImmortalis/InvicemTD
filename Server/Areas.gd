extends Node3D

var area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_baracks_mouse_exited():
	area = ""
	pass # Replace with function body.

func _on_farm_house_mouse_exited():
	area = ""
	pass # Replace with function body.

func _on_market_mouse_exited():
	area = ""
	pass # Replace with function body.

func _on_armory_academy_mouse_exited():
	area = ""
	pass # Replace with function body.

func _on_tower_mouse_exited():
	area = ""
	pass # Replace with function body.
	
func _on_baracks_mouse_entered():
	area = "Baracks"
	pass # Replace with function body.

func _on_farm_house_mouse_entered():
	area = "FarmHouse"
	pass # Replace with function body.

func _on_market_mouse_entered():
	area = "Market"
	pass # Replace with function body.

func _on_armory_academy_mouse_entered():
	area = "ArmoryAcademy"
	pass # Replace with function body.

func _on_tower_mouse_entered():
	area = "Towers"
	pass # Replace with function body.
	
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && area && $"../Timer".is_stopped():
		for a in $"../HUD/Areas".get_children():
			if a.visible:
				pass
		$"../HUD/Areas".get_node(area).visible = true
		$"../HUD/Back".visible = true
		$"../Timer".start()
		pass

func _on_baracks_input_event(camera, event, position, normal, shape_idx):
	#print(area)
	pass # Replace with function body.
