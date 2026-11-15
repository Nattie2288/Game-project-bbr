extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_count=0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_count=0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count<2:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("Walk")
		if direction < 0:
			print('test')
			animated_sprite.flip_h=1
		if direction>0:
			animated_sprite.flip_h=0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		print(direction)

	move_and_slide()
