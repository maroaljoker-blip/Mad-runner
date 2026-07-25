extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2: CollisionShape2D = $sin/CollisionShape2


@onready var sin: CharacterBody2D = $sin







var speed = -30
var moving = false
var dead = false
func die():
	if dead:
		return

	dead = true
	moving = false
	animated_sprite_2d.play("die")
	sin.collision_layer = 8
	sin.collision_mask = 8
	
	await get_tree().create_timer(10.0).timeout
	queue_free()

func _process(delta):
	if moving and !dead:
		position.x += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if dead:
		return

	# Player attack hit
	if body.name == "cat 2" or body.name == "mice 2":
		collision_shape_2.set_deferred("disabled", true)
		await die()
		return

	# Normal attack
	animated_sprite_2d.play("attack")
	await get_tree().create_timer(0.01).timeout
	collision_shape_2.set_deferred("disabled", false)
	await get_tree().create_timer(0.5).timeout

	if !dead:
		collision_shape_2.set_deferred("disabled", true)
