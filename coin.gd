extends Area2D
@onready var manager: Node = $"../manager"

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "cat 2" or body.name == "mice 2":
		manager.add_point()
		sprite_2d.play("default")
		await sprite_2d.animation_finished
		queue_free()
