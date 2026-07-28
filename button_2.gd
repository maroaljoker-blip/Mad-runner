extends Button
@onready var button: Button = $"../Button"
@onready var button_3: Button = $"../Button3"
@onready var button_4: Button = $"../Button4"
@onready var button_5: Button = $"../Button5"
@onready var animation_player_1: AnimationPlayer = $"../Button3/AnimationPlayer1"
@onready var animation_player_2: AnimationPlayer = $"../Button4/AnimationPlayer2"
@onready var animation_player_3: AnimationPlayer = $"../Button5/AnimationPlayer3"


func _ready() -> void:
	button.disabled = false
	button_3.disabled = true
	button_4.disabled = true
	button_5.disabled = true
	



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("settings"):
		pressed.emit()
		
		button_3.disabled = false
		button_4.disabled = false
		button_5.disabled = false
		
		animation_player_1.play("new_animation")
		animation_player_2.play("nn")
		animation_player_3.play("ll")
		
		disabled = true
