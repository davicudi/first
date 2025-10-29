extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const BOUNCE_FORCE = 500.0
@onready var sprite_2d = $Sprite2D

# Jump vars
var jump_count = 0
var max_jumps = 2

# Collide enemy
func jump():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	# Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"

	if is_on_floor():
		jump_count = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()

	var isLeft  = velocity.x < 0
	sprite_2d.flip_h = isLeft
