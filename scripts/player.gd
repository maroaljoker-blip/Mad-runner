extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var cat: CollisionShape2D = $"cat 2/cat"
@onready var mice: CollisionShape2D = $"mice 2/mice"
@onready var camera_2d: Camera2D = $Camera2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d_22: CollisionShape2D = $Area2D/CollisionShape2D22
@onready var label: Label = $Label
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d_3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animated_sprite_2d_4: AnimatedSprite2D = $AnimatedSprite2D4

var SPEED = 70.0
var JUMP_VELOCITY = -350.0

var dead = false
var can_move = false
var attacking = false
var rolling = false
var lives := 3
var can_take_hit := true

func _ready():
	cat.set_deferred("disabled", true)
	mice.set_deferred("disabled", true)
	update_label()
	# Stop all sprites from playing automatically at start
	animated_sprite_2d_2.stop()
	animated_sprite_2d_3.stop()
	animated_sprite_2d_4.stop()
	
	# Optional: Set them all to frame 0 so they show their starting pose
	animated_sprite_2d_2.frame = 0
	animated_sprite_2d_3.frame = 0
	animated_sprite_2d_4.frame = 0
	set_collision_mask_value(2, true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "sin":
		if not can_take_hit:
			return
		animated_sprite_2d.play("hit")
		can_take_hit = false
		if body.name == "Nemo":
			lives -= 2
		else:
			lives -= 1

		print("Hit from:", body.name)
		print("Lives:", lives)

		update_label()

		if lives <= 0:
			die()
			await get_tree().create_timer(1.0).timeout
			get_tree().reload_current_scene()
			return

		can_take_hit = true

func update_label():
	label.text = "Lives: " + str(lives)
	if lives == 2:
		animated_sprite_2d_2.play("1")
	elif lives == 1:
		animated_sprite_2d_3.play("2")
	elif lives == 0:
		animated_sprite_2d_4.play("3")

func die():
	dead = true
	velocity = Vector2.ZERO
	animated_sprite_2d.play("die")
	audio_stream_player_2d.play()

func attack_one():
	attacking = true
	animated_sprite_2d.play("attack")

	await get_tree().create_timer(0.3).timeout
	cat.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	cat.set_deferred("disabled", true)

	attacking = false



func attack_two():
	attacking = true
	animated_sprite_2d.play("attack 2")

	await get_tree().create_timer(0.6).timeout
	mice.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	mice.set_deferred("disabled", true)

	attacking = false

func roll():
	rolling = true
	animated_sprite_2d.play("roll")
	set_collision_mask_value(2, false)
	collision_shape_2d.rotation_degrees = 90
	collision_shape_2d.position.y += 3

	await get_tree().create_timer(0.7).timeout

	collision_shape_2d.rotation_degrees = 0
	collision_shape_2d.position.y -= 3

	rolling = false
	
	
func _physics_process(delta: float) -> void:
	if dead:
		return
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Roll
	if can_move and !rolling and !attacking and Input.is_action_just_pressed("roll"):
		await roll()
		return

	# Attack 1
	if can_move and !rolling and !attacking and Input.is_action_just_pressed("attack"):
		await attack_one()
		return

	# Attack 2
	if can_move and !rolling and !attacking and Input.is_action_just_pressed("attack 2"):
		await attack_two()
		return

	# Jump
	if can_move and !rolling and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Auto run
	if can_move:
		velocity.x = SPEED
	else:
		velocity.x = 0

	# Face right
	animated_sprite_2d.flip_h = false

	# Animations
	if dead:
		pass
	elif attacking or rolling:
		pass
	elif !can_move:
		animated_sprite_2d.play("idle")
	elif is_on_floor():
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	move_and_slide()
