extends Node2D
@onready var player: CharacterBody2D = $player
@onready var button: Button = $Button
@onready var labelx: Label = $player/Labelx
@onready var label_2: Label = $player/Label2
@onready var label_3: Label = $player/Label3
@onready var label_4: Label = $player/Label4
@onready var label_5: Label = $player/Label5
@onready var label_7: Label = $player/Label7
@onready var label_8: Label = $player/Label8
@onready var label_9: Label = $player/Label9
@onready var label_10: Label = $player/Label10
@onready var label_6: Label = $player/Label6
@onready var label_11: Label = $player/Label11
@onready var animation_player_2: AnimationPlayer = $player/Camera2D/AnimationPlayer2
@onready var boss: Node2D = $boss





var played = false
var wave1_started = false
var wave2_started = false
var wave3_started = false
var wave4_started = false
var wave5_started = false
var wave6_started = false
var wave7_started = false
var wave8_started = false
var wave9_started = false
var wave10_started = false
func _ready() -> void:
	boss.player = player
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
		labelx.visible = true
		
	if player.global_position.x >= 5693 and !wave2_started:
		wave2_started = true
		player.JUMP_VELOCITY = -380.0
		label_2.visible = true
		labelx.visible = false
		animation_player_2.play("DD")
		for enemy in get_tree().get_nodes_in_group("enemies5%"):
			enemy.moving = true
	
	if player.global_position.x >= 7750 and !wave3_started:
		wave3_started = true
		label_3.visible = true
		label_2.visible = false
		for enemy in get_tree().get_nodes_in_group("enemies10%"):
			enemy.moving = true
	if player.global_position.x >= 10173 and !wave4_started:
		wave4_started = true
		label_3.visible = false
		label_4.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies15%"):
			enemy.moving = true
	if player.global_position.x >= 13800 and !wave5_started:
		wave5_started = true
		label_4.visible = false
		label_5.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies20%"):
			enemy.moving = true
	if player.global_position.x >= 15800 and !wave6_started:
		wave6_started = true
		label_5.visible = false
		label_6.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies25%"):
			enemy.moving = true
	if player.global_position.x >= 18350 and !wave7_started:
		wave7_started = true
		label_6.visible = false
		label_7.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies30%"):
			enemy.moving = true
	if player.global_position.x >= 20470 and !wave8_started:
		wave8_started = true
		label_7.visible = false
		label_8.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies35%"):
			enemy.moving = true
	if player.global_position.x >= 22890 and !wave9_started:
		wave9_started = true
		label_8.visible = false
		label_9.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies40%"):
			enemy.moving = true
	if player.global_position.x >= 25600 and !wave10_started:
		wave10_started = true
		label_9.visible = false
		label_10.visible = true
		for enemy in get_tree().get_nodes_in_group("enemies45%"):
			enemy.moving = true
	if player.global_position.x >= 28900 and !boss.active:
		boss.active = true
		boss.get_node("timer").start()
		label_11.visible = true
		label_10.visible = false
