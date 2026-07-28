extends Button
@onready var button_5: Button = $"../Button5"
@onready var button_4: Button = $"../Button4"
@onready var button_3: Button = $"../Button3"
@onready var button_2: Button = $"../Button2"


@onready var button: Button = $"../Button"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.disabled = true
	button_3.disabled = false
	button_4.disabled = false
	button_5.disabled = false
	disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back"):
		pressed.emit()
		button_3.disabled = true
	button_4.disabled = true
	button_5.disabled = true
	button_2.disabled = false
	button.disabled = false
