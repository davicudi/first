extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speedScale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if not loop:
		animation.play("up_down")
		animation.speedScale = speedScale
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress += speed
