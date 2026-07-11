extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2: CollisionShape2D = $Sin/CollisionShape2
@onready var collision_shape_2d: CollisionShape2D = $Cos/CollisionShape2D

@onready var collision_shape_2d_3: CollisionShape2D = $Tan/CollisionShape2D3
@onready var sin: CharacterBody2D = $Sin

@onready var cos: CharacterBody2D = $Cos

@onready var tan: CharacterBody2D = $Tan




var speed = -30
var moving = false
var dead = false
func die():
	if dead:
		return

	dead = true
	moving = false
	animated_sprite_2d.play("dead")
	sin.collision_layer = 8
	sin.collision_mask = 8
	cos.collision_layer = 8
	cos.collision_layer = 8
	tan.collision_layer = 8
	tan.collision_mask = 8
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _process(delta: float) -> void:
	if moving:
		position.x += speed * delta

func _on_body_entered(body: Node2D) -> void:
		speed = 70
		animated_sprite_2d.play("attack")
		await get_tree().create_timer(1).timeout
		collision_shape_2.set_deferred("disabled", false)

		await get_tree().create_timer(1.3).timeout
		collision_shape_2d.set_deferred("disabled", false)

		await get_tree().create_timer(1.2).timeout
		collision_shape_2d_3.set_deferred("disabled", false)
