extends Button

@onready var player = $"../player"
@onready var damage_area = player.find_child("damage area")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Invicible"):
		pressed.emit()

func _on_pressed() -> void:
	damage_area.monitoring = false
	damage_area.monitorable = false
	
