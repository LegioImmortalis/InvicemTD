extends Node3D

@onready var baracks= preload("res://baracks.tscn")
@onready var tower 	= preload("res://tower.tscn")
@onready var smithy = preload("res://smithy.tscn")
# Called when the node enters the scene tree for the first time.

var instance

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func place(pos):
	if instance:
		$"../Buildings".instance.transform.origin = pos
	
func _input(event):
	if instance:
		if event is InputEventMouseButton:
			$"../Buildings".instance.get_node("Mesh").get_active_material(3).albedo_color *= Color(1, 1, 1, 1)
			$"../Buildings".instance = null

func build(building):
	if building == "tower":
		instance = tower.instantiate()
		instance.get_node("Mesh").get_active_material(3).albedo_color *= Color(1, 1, 1, 0.5)
