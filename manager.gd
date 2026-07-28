extends Node
@onready var coins_label: Label = $"../player/coins label"

@onready var boss: Node2D = $"../boss"
@onready var label_12: Label = $"../player/Label12"
@onready var label_11: Label = $"../player/Label11"

var score = 0
func add_point():
	score += 1
	coins_label.text = str(score) + "🖤 "
	print("+1 coin!")

	if score >= 20:
		call_deferred("go_to_next_scene")

func go_to_next_scene():
	boss.queue_free()
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://game.tscn")
	label_12.visible = true
	label_11.visible = false
