extends Node3D

@onready var tooltip = %ToolTip
@onready var hud = $HUD
@export var PlayerNumber=1
@onready var Castle = preload("res://castle.tscn")
#@onready var server = get_node("/root/World")

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	$"../Maps".get_node(str(PlayerNumber)).visible = true
	position = $"../Maps".get_node(str(PlayerNumber)).position
	$Buildings.add_child(Castle.instantiate())
	#if not is_multiplayer_authority(): return
	hud.show()

func _unhandled_key_input(event):
	tooltip.text = ""
	if event.is_pressed():
		print($TOP.position)
		match event.as_text():
			"1": $TOP.position = $"../Maps/1".position + Vector3(10,70,0)
			"2": $TOP.position = $"../Maps/2".position + Vector3(0,70,0)
			"3": $TOP.position = $"../Maps/3".position + Vector3(0,70,0)
			"4": $TOP.position = $"../Maps/4".position + Vector3(0,70,0)
			"5": $TOP.position = $"../Maps/5".position + Vector3(0,70,0)
			"6": $TOP.position = $"../Maps/6".position + Vector3(0,70,0)
			"7": $TOP.position = $"../Maps/7".position + Vector3(0,70,0)
			"8": $TOP.position = $"../Maps/8".position + Vector3(0,70,0)
			"9": $TOP.position = $"../Maps/9".position + Vector3(0,70,0)
