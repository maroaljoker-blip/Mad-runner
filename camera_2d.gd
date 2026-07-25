extends Camera2D

var fixed_y := 0.0

func _ready():
	fixed_y = position.y

func _process(delta):
	position.y = fixed_y
