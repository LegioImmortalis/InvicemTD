extends Node3D

@onready var baracks= get_node("res://baracks.tscn")
@onready var tower 	= get_node("res://tower.tscn")
@onready var smithy = get_node("res://smithy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_RayCast_output(object, position, normal, id):
	tower.i
	$MeshInstance.transform.origin = position
