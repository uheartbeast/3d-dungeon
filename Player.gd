extends Spatial

onready var tween: = $Tween
onready var forward: = $RayForward
onready var back: = $RayBack
onready var right: = $RayRight
onready var left: = $RayLeft

func _physics_process(delta):
	if Input.is_action_pressed("forward") and collision_check(forward):
		set_physics_process(false)
		yield(tween_translation(get_direction(forward)), "completed")
		set_physics_process(true)
	elif Input.is_action_pressed("back") and collision_check(back):
		set_physics_process(false)
		yield(tween_translation(get_direction(back)), "completed")
		set_physics_process(true)
	elif Input.is_action_pressed("strafe_left") and collision_check(left):
		set_physics_process(false)
		yield(tween_translation(get_direction(left)), "completed")
		set_physics_process(true)
	elif Input.is_action_pressed("strafe_right") and collision_check(right):
		set_physics_process(false)
		yield(tween_translation(get_direction(right)), "completed")
		set_physics_process(true)
	elif Input.is_action_pressed("turn_left"):
		set_physics_process(false)
		yield(tween_rotation(PI/2), "completed")
		set_physics_process(true)
	elif Input.is_action_pressed("turn_right"):
		set_physics_process(false)
		yield(tween_rotation(-PI/2), "completed")
		set_physics_process(true)
		print(rotation_degrees)

func collision_check(direction):
	return direction.is_colliding()

func get_direction(direction):
	if not direction is RayCast: return
	return direction.get_collider().global_transform.origin - global_transform.origin

func tween_translation(change):
	$AnimationPlayer.play("Step")
	tween.interpolate_property(
		self, "translation", translation, translation + change,
		0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")

func tween_rotation(change):
	tween.interpolate_property(
		self, "rotation", rotation, rotation + Vector3(0, change, 0),
		0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
