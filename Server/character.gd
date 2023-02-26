extends CharacterBody3D

@onready var anim_player = $Animations/AnimationPlayer
@onready var raycast = $FPS/RayCast3D
#@onready var server = get_node("/root/World")
@onready var Baracks= preload("res://baracks.tscn")
@onready var Tower 	= preload("res://tower.tscn")
@onready var Armory = preload("res://armory.tscn")
@onready var Market = preload("res://house.tscn")
@onready var House = preload("res://market.tscn")
@onready var Star = preload("res://star.tscn")

const SPEED = 50
const JUMP_VELOCITY = 10.0
var destination
var rotaNormal = Vector3()
var rota = Vector3()
var distance
var gravity = 20.0
var cameraMode = 0
var instance
var mousePos 
var camera

func _ready():
	set_multiplayer_authority(str(name).to_int())	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera = $TOP
	pass

func _unhandled_input(event):
	mousePos = camera.get_viewport().get_mouse_position()
	var rayLength = 200
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	rayQuery.collide_with_areas = true
	rayQuery.collide_with_bodies = false
	var result = space.intersect_ray(rayQuery)
	#rayQuery.collide_with_areas = false
	#rayQuery.collide_with_bodies = true
	#var building = space.intersect_ray(rayQuery)
	
	#if building:
	#	print(building)
		
	if result:
		destination = result.position
		
	
	if event is InputEventMouseMotion:
		if cameraMode != 2:
			rotate_y(-event.relative.x * .005)
			camera.rotate_x(-event.relative.y * .005)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		if cameraMode == 2 && destination && destination != Vector3.ZERO:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
			look_at(destination*Vector3(1,0,1)+Vector3(0,1,0))
			#camera.rotation = Vector3(deg_to_rad(-90),deg_to_rad(0),deg_to_rad(0))
			
		if instance && destination:
			instance.position = destination*Vector3(1,0,1)
	if instance && instance != Star:
		if destination:
			instance.position = round(destination*Vector3(1,0,1))
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			instance = Star.instantiate()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			instance.free()
			instance = Star.instantiate()
		if Input.is_action_just_pressed("q"):	
			instance.rotation.y += deg_to_rad(90)
		if Input.is_action_just_pressed("e"):	
			instance.rotation.y -= deg_to_rad(90)
	#if Input.is_action_just_pressed("") \
	#		and anim_player.current_animation != "":
	#	play_effects("shoot")
	#	server.rpc("damage", name)

func _physics_process(delta):
	#if not is_multiplayer_authority(): return

	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if cameraMode == 2:
		camera.position=Vector3(position.x,camera.position.y,position.z)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_player.play("KayKit Animated Character|Hop")
		
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction
	
	if cameraMode != 2:
		if input_dir:
			direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if cameraMode == 2:
		#camera.rotation = Vector3(deg_to_rad(-70),deg_to_rad(0),deg_to_rad(0)
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
			camera=$TOP
			$TOP.current = true


# Called when the node enters the scene tree for the first time.
	
func build(building):
	if instance:
		instance.free()
		instance = Star.instantiate()
	if building == "Demolish":
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
