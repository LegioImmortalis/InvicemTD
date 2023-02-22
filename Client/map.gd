extends Area3D

#@onready var server = get_node("/root/World")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func PlayerColor(C):
	var material = get_node("Castle/Mesh").get_active_material(3)
	material.albedo_color = C
	for child in $Baracks.get_children():
		material = get_node("Castle/Mesh").get_active_material(3)
		material.albedo_color = C
	for child in $Towers.get_children():
		material = get_node("Castle/Mesh").get_active_material(3)
		material.albedo_color = C
	#if not is_multiplayer_authority(): return


func _on_castle_input_event(_camera, _event, _position, _normal, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass # Replace with function body.
