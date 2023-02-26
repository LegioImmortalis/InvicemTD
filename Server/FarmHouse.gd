extends Control

@onready var instance = preload("res://house.tscn")
@onready var Buttons = get_children()
var vector =[
	Vector3.ZERO,
	Vector3(-10,0,-25),
	Vector3(-10,0,-10),
	Vector3(0,0,-25),
	Vector3(0,0,-10),
	Vector3(10,0,-25),
	Vector3(10,0,-10),
	Vector3(-10,0,10),
	Vector3(-10,0,25),
	Vector3(0,0,10),
	Vector3(0,0,25),
	Vector3(10,0,10),
	Vector3(10,0,25),
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
