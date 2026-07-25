extends Node2D
@onready var player: CharacterBody2D = $player
@onready var button: Button = $Button
@onready var animation_player: AnimationPlayer = $player/Label7/AnimationPlayer
@onready var label_7: Label = $player/Label7

var played = false


func _on_button_pressed() -> void:
	player.can_move = true
	button.disabled = true

	player.get_node("AnimatedSprite2D2").visible = true
	player.get_node("AnimatedSprite2D3").visible = true
	player.get_node("AnimatedSprite2D4").visible = true

	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.moving = true


  
func _process(delta: float) -> void:
	if player.global_position.x >= 2890:
		player.SPEED = 85
		for enemy in get_tree().get_nodes_in_group("enemiess"):
			enemy.moving = true
		animation_player.play("jjk")
		label_7.visible = true
