extends Node2D
@onready var player: CharacterBody2D = $player
@onready var button: Button = $Button


@onready var animation_player: AnimationPlayer = $player/Labelx/AnimationPlayer



var played = false
var wave1_started = false
var wave2_started = false
var wave3_started = false
func _on_button_pressed() -> void:
	player.can_move = true
	button.disabled = true

	player.get_node("AnimatedSprite2D2").visible = true
	player.get_node("AnimatedSprite2D3").visible = true
	player.get_node("AnimatedSprite2D4").visible = true

	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.moving = true


  
func _process(delta):
	if player.global_position.x >= 2890 and !wave1_started:
		wave1_started = true
		player.SPEED = 85
		for enemy in get_tree().get_nodes_in_group("enemiess"):
			enemy.moving = true
		
		animation_player.play("1.1")
	if player.global_position.x >= 5693 and !wave2_started:
		wave2_started = true
		player.JUMP_VELOCITY = -380.0
		for enemy in get_tree().get_nodes_in_group("enemies5%"):
			enemy.moving = true
	animation_player.play("1.2")
	if player.global_position.x >= 7750 and !wave3_started:
		wave3_started = true
		for enemy in get_tree().get_nodes_in_group("enemies10%"):
			enemy.moving = true
