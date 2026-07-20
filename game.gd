extends Node2D
@onready var player: CharacterBody2D = $player
@onready var button: Button = $Button



func _on_button_pressed() -> void:
	player.can_move = true
	button.disabled = true

	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.moving = true
