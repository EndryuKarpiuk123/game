extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):

	# Гравітація
	if not is_on_floor():
		velocity.y += gravity * delta

	# Стрибок
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	# Рух вліво/вправо
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		
		if is_on_floor():
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if is_on_floor():
			anim.play("idle")

	# Поворот спрайта
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false

	# Анімація падіння
	if velocity.y > 0 and not is_on_floor():
		anim.play("fall")

	move_and_slide()
