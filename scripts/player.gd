extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var cat: CollisionShape2D = $Cat
@onready var mice: CollisionShape2D = $Mice
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED = 70.0
const JUMP_VELOCITY = -300.0

var dead = false
var can_move = false
var attacking = false
var rolling = false

func _ready():
	cat.set_deferred("disabled", true)
	mice.set_deferred("disabled", true)

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

	await get_tree().create_timer(0.1).timeout
	cat.set_deferred("disabled", true)

	attacking = false

func attack_two():
	attacking = true
	animated_sprite_2d.play("attack 2")

	await get_tree().create_timer(0.6).timeout
	mice.set_deferred("disabled", false)

	await get_tree().create_timer(0.1).timeout
	mice.set_deferred("disabled", true)

	attacking = false

func roll():
	rolling = true
	animated_sprite_2d.play("roll")

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
