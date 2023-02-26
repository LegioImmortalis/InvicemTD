extends Control

@onready var instance = preload("res://tower.tscn")
@onready var Buttons = get_children()
var vector =[
	Vector3.ZERO,
	Vector3(19,0,-17.5),
	Vector3(19,0,-10),
	Vector3(27,0,-17.5),
	Vector3(27,0,-10),
	Vector3(35,0,-17.5),
	Vector3(35,0,-10),
	Vector3(43,0,-17.5),
	Vector3(43,0,-10),
	Vector3(19,0,10),
	Vector3(19,0,17.5),
	Vector3(27,0,10),
	Vector3(27,0,17.5),
	Vector3(35,0,10),
	Vector3(35,0,17.5),
	Vector3(43,0,10),
	Vector3(43,0,17.5),
]
# Called when the node enters the scene tree for the first time.
func _ready():
	for button in Buttons:
		button.connect("pressed", _on_button_pressed.bind(button))
	pass

func _on_button_pressed(button):
	var Instance = instance.instantiate()
	Instance.position = vector[button.name.to_int()]
	$"../../../Buildings".add_child(Instance)
	pass
	
	
	
	
