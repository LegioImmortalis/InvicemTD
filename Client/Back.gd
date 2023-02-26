extends Control

@onready var instance = preload("res://house.tscn")
@onready var Buttons = get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in Buttons:
		button.connect("pressed", _on_button_pressed.bind(button))
	pass

func _on_button_pressed(_button):
	if $"../../Timer".is_stopped():
		for a in $"../Areas".get_children():
			a.visible = false
			$".".visible = false
	pass
