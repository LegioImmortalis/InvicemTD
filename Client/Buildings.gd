extends Node3D
# Called when the node enters the scene tree for the first time.

@onready var Castle = preload("res://castle.tscn")

func _ready():
	add_child(Castle.instantiate())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
