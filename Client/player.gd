extends Node3D

@onready var tooltip = %ToolTip
@onready var healthbar = $HUD/HealthBar
@onready var hud = $HUD
#@onready var server = get_node("/root/World")

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	#if not is_multiplayer_authority(): return
	hud.show()

func _unhandled_key_input(event):
	tooltip.text = ""
	if event.is_pressed():
		match event.as_text():
			"0": 
				tooltip.text = "[center]Demolish[/center]"
				$character.build("Demolish")
			"1": 
				tooltip.text = "[center]Build Tower[/center]"
				$character.build("Tower")
			"2": 
				tooltip.text = "[center]Build Barack[/center]"
				$character.build("Baracks")
			"3": 
				tooltip.text = "[center]Build Market[/center]"
				$character.build("Market")
			"4": 
				tooltip.text = "[center]Build Armory[/center]"
				$character.build("Armory")
