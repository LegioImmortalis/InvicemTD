extends Node3D

@onready var tooltip = %ToolTip
@onready var healthbar = $HUD/HealthBar
@onready var hud = $HUD
#@onready var server = get_node("/root/World")

const SPEED = 15
const JUMP_VELOCITY = 10.0
var destination = Vector2()
var rotaNormal = Vector3()
var rota = Vector3()
var distance
var gravity = 20.0

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	#if not is_multiplayer_authority(): return
	hud.show()
	$TOP.current = true

func _unhandled_key_input(event):
	tooltip.text = ""
	if event.is_pressed():
		match event.as_text():
			"0": tooltip.text = "[center]Demolish[/center]"
			"1": tooltip.text = "[center]Build Tower[/center]"
			"2": tooltip.text = "[center]Build Barack[/center]"
			"3": tooltip.text = "[center]Build Market[/center]"
			"4": tooltip.text = "[center]Build Armory[/center]"
