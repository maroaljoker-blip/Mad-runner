extends Button
@onready var button_2: Button = $"../Button2"
@onready var button_3: Button = $"../Button3"
@onready var button_4: Button = $"../Button4"
@onready var button_5: Button = $"../Button5"


func _ready() -> void:
	button_2.disabled = false
	
	
func _process(delta):
	if Input.is_action_just_pressed("go"):
		pressed.emit()
		button_2.disabled = true
		button_3.disabled = true
		button_4.disabled = true
		button_5.disabled = true
