extends CharacterBody3D

@onready var anim_player = $Animations/AnimationPlayer
@onready var raycast = $FPS/RayCast3D
#@onready var server = get_node("/root/World")
@onready var camera = $"../TOP"
@onready var Baracks= preload("res://baracks.tscn")
@onready var Tower 	= preload("res://tower.tscn")
@onready var Armory = preload("res://armory.tscn")
@onready var Market = preload("res://house.tscn")
@onready var House = preload("res://market.tscn")

const SPEED = 50
const JUMP_VELOCITY = 10.0
var destination = Vector3()
var rotaNormal = Vector3()
var rota = Vector3()
var distance
var gravity = 20.0
var cameraMode = 0
var instance


func _ready():
	set_multiplayer_authority(str(name).to_int())	
	$"../TOP".current = true
	pass

func _unhandled_input(event):
	var mousePos = camera.get_viewport().get_mouse_position()
	var rayLength = 200
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	rayQuery.collide_with_areas = false
	rayQuery.collide_with_bodies = true
	var result = space.intersect_ray(rayQuery)
	if result:
		destination = result.position
	
	if event is InputEventMouseMotion:
		
		#var scr = get_viewport().get_visible_rect().size
		#rota=Vector2((event.global_position.x-scr.x/2),(event.global_position.y-scr.y/2))
		#rotaNormal=Vector2((event.global_position.x-scr.x/2)/scr.x,(event.global_position.y-scr.y/2)/scr.y)
		#distance=Vector2(0,0).distance_to(Vector2((event.global_position.x-scr.x/2)/scr.x,(event.global_position.y-scr.y/2)/scr.y))

		if cameraMode != 2:
			rotate_y(-event.relative.x * .005)
			camera.rotate_x(-event.relative.y * .005)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
			
		if cameraMode == 2:
			if destination:
				look_at(Vector3(destination.x,1,destination.z))
			#camera.rotation = Vector3(deg_to_rad(-90),deg_to_rad(0),deg_to_rad(0))
		
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				print (result.position)
				pass
			
		if instance:
			instance.position = round(destination*Vector3(1,0,1))
			
	if instance:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			#instance.get_node("Mesh").get_active_material().albedo_color *= Color(1, 1, 1, 1)
			instance = Node3D.new()
	
	#if Input.is_action_just_pressed("") \
	#		and anim_player.current_animation != "":
	#	play_effects("shoot")
	#	server.rpc("damage", name)

func _physics_process(delta):
	#if not is_multiplayer_authority(): return

	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_player.play("KayKit Animated Character|Hop")
		
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction
	
	if cameraMode != 2:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if input_dir:
			direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if cameraMode == 2:
		#camera.rotation = Vector3(deg_to_rad(-70),deg_to_rad(0),deg_to_rad(0))
		camera.position = position + Vector3 (0,150,55)	
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		if input_dir:
			direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if anim_player.current_animation == "KayKit Animated Character|Shoot(2h)Bow":
		pass
	elif input_dir != Vector2.ZERO and is_on_floor():
		anim_player.play("KayKit Animated Character|Walk")
	else:
		anim_player.play("KayKit Animated Character|Idle")

	move_and_slide()

func play_effects(effect):
	anim_player.stop()
	anim_player.play(effect)
	if effect == "KayKit Animated Character|Shoot(2h)Bow":
		pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "KayKit Animated Character|Shoot(2h)Bow":
		anim_player.play("KayKit Animated Character|Idle")		

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_home"):
		cameraMode+=1
		if cameraMode >= 3:
			cameraMode=0
		if cameraMode == 0:
			camera=$FPS
			$FPS.current = true
		if cameraMode == 1: 
			camera=$TPS
			$TPS.current = true
		if cameraMode == 2: 
			camera=$"../TOP"
			$"../TOP".current = true


# Called when the node enters the scene tree for the first time.
	
func build(building):
	if building == "Demolish":
		#instance = Demolish.instantiate()
		pass
	if building == "Tower":
		instance = Tower.instantiate()
	if building == "Baracks":
		instance = Baracks.instantiate()
	if building == "Market":
		instance = Market.instantiate()
	if building == "Armory":
		instance = Armory.instantiate()
	if building == "House":
		instance = House.instantiate()
	#instance.get_node("Mesh").get_active_material().albedo_color *= Color(1, 1, 1, 0.5)
	$"../Buildings".add_child(instance)
