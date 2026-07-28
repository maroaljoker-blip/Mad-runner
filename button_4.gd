extends Button
@onready var player: CharacterBody2D = $"../player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("High"):
		pressed.emit()
		player.JUMP_VELOCITY = -500
