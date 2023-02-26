extends Control

@onready var tower = preload("res://barrack.tscn")
@onready var Buttons = [$"1", $"2", $"3", $"4", $"5", $"6", $"7", $"8", $"9", $"10", $"11", $"12"]
var vector =[
	Vector3.ZERO,
	Vector3(-37,0,-8),
	Vector3(-37,0,-18),
	Vector3(-37,0,-28),
	Vector3(-27,0,-8),
	Vector3(-27,0,-18),
	Vector3(-27,0,-28),
	Vector3(-27,0,8),
	Vector3(-27,0,18),
	Vector3(-27,0,28),
	Vector3(-27,0,8),
	Vector3(-27,0,18),
	Vector3(-27,0,28),
]
# Called when the node enters the scene tree for the first time.
func _ready():
	for button in Buttons:
		button.connect("pressed", _on_button_pressed.bind(button))
	pass

func _on_button_pressed(button):
	var Tower = tower.instantiate()
	Tower.position = vector[button.name.to_int()]
	$"../../../Buildings".add_child(Tower)
	pass
