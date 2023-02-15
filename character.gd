extends CharacterBody3D

@onready var anim_player = $Animations/AnimationPlayer
@onready var raycast = $FPS/RayCast3D
#@onready var server = get_node("/root/World")
@onready var camera = $FPS

const SPEED = 50
const JUMP_VELOCITY = 10.0
var destination = Vector2()
var rotaNormal = Vector3()
var rota = Vector3()
var distance
var gravity = 20.0
var cameraMode = 0

func _ready():
	set_multiplayer_authority(str(name).to_int())
	pass

func _unhandled_input(event):
	#if not is_multiplayer_authority(): return
	
	if event is InputEventMouseMotion:
		var scr = get_viewport().get_visible_rect().size
		rota=Vector2((event.global_position.x-scr.x/2),(event.global_position.y-scr.y/2))
		rotaNormal=Vector2((event.global_position.x-scr.x/2)/scr.x,(event.global_position.y-scr.y/2)/scr.y)
		distance=Vector2(0,0).distance_to(Vector2((event.global_position.x-scr.x/2)/scr.x,(event.global_position.y-scr.y/2)/scr.y))

		if cameraMode != 2:
			rotate_y(-event.relative.x * .005)
			camera.rotate_x(-event.relative.y * .005)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
			
		if cameraMode == 2:
			look_at(Vector3(rota.x,position.y,rota.y))
			camera.rotation = Vector3(deg_to_rad(-90),deg_to_rad(0),deg_to_rad(0))
		
			destination=Vector2()
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				destination = rotaNormal/distance
	
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
		camera.rotation = Vector3(deg_to_rad(-70),deg_to_rad(0),deg_to_rad(0))
		camera.position = position + Vector3 (0,150,55)	
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		if destination:
			direction = Vector3(destination.x, 0, destination.y)
		if input_dir:
			direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
		
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
