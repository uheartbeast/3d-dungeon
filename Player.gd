extends Spatial

onready var timerprocessor: = $Timer
onready var tween: = $Tween
onready var forward: = $RayForward
onready var back: = $RayBack
onready var right: = $RayRight
onready var left: = $RayLeft
func collision_check(direction):
	if direction != null:
		return direction.is_colliding()
	else:
		return false

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


func _on_Timer_timeout() -> void:
	var GO_W := Input.is_action_pressed("forward")
	var GO_S := Input.is_action_pressed("back")
	var GO_A := Input.is_action_pressed("strafe_left")
	var GO_D := Input.is_action_pressed("strafe_right")
	var TURN_Q := Input.is_action_pressed("turn_left")
	var TURN_E := Input.is_action_pressed("turn_right")

	var ray_dir
	var turn_dir = int(TURN_Q) - int(TURN_E)


	if GO_W: 
		ray_dir = forward
	elif GO_S: 
		ray_dir = back
	elif GO_A: 
		ray_dir = left
	elif GO_D: 
		ray_dir = right
	elif turn_dir:
		timerprocessor.stop()
		yield(tween_rotation(PI/2 * turn_dir), "completed")
		timerprocessor.start()

	if collision_check(ray_dir):
		timerprocessor.stop()
		yield(tween_translation(get_direction(ray_dir)), "completed")
		timerprocessor.start()
