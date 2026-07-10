extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


const SPEED = 70.0
const JUMP_VELOCITY = -300

var dead = false

func die():
	dead = true
	velocity = Vector2.ZERO
	animated_sprite_2d.play("die")
	audio_stream_player_2d.play()
func _physics_process(delta: float) -> void:
	if dead:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Always move to the right
	velocity.x = SPEED

	# Face right
	animated_sprite_2d.flip_h = false

	# Animations
	if is_on_floor():
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	move_and_slide()
