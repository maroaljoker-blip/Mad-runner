extends Node2D
@onready var player: CharacterBody2D = $player
@onready var button: Button = $Button
@onready var skeleton: Area2D = $skeleton


func _on_button_pressed() -> void:
	player.can_move = true
	button.disabled = true # Hides the button after clicking Play
	skeleton.moving = true
