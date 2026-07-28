extends Node2D

@export var follow_speed := 130.0
@export var player_speed := 85.0
@export var offset := Vector2(300, 0)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var nemo: CharacterBody2D = $nemo


var active := false
var player: CharacterBody2D

var attacking := false
var attack_time := 0.5

var nemo_start_position := Vector2.ZERO


func _ready() -> void:
	sprite_2d.visible = false
	animated_sprite_2d_2.visible = false
	
	nemo_start_position = nemo.position


func _process(delta):
	if !active:
		return

	if player == null:
		return

	if attacking:
		global_position.x += player_speed * delta
		return

	var target = player.global_position + offset
	global_position = global_position.move_toward(target, follow_speed * delta)


func _on_timer_timeout() -> void:
	start_attack()


func start_attack():
	attacking = true

	sprite_2d.visible = true
	animation_player.play("MM")

	animated_sprite_2d_2.visible = true
	animated_sprite_2d_2.play("blast")

	await get_tree().create_timer(attack_time).timeout

	fire_blast()

	await get_tree().create_timer(0.8).timeout

	sprite_2d.visible = false
	animated_sprite_2d_2.visible = false

	attacking = false


func fire_blast():
	print("BOSS BLAST")

	var attack_position = nemo_start_position + Vector2(-223.5, 0)

	var tween = create_tween()
	tween.tween_property(nemo, "position", attack_position, 0.3)

	await tween.finished

	await get_tree().create_timer(0.5).timeout

	var return_tween = create_tween()
	return_tween.tween_property(nemo, "position", nemo_start_position, 0.3)

	await return_tween.finished
