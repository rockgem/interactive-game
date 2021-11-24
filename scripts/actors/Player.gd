extends KinematicBody2D

enum DIRECTION{
	LEFT,
	RIGHT
}

onready var joystick = $CanvasLayer/UI/Sprite/TouchScreenButton

var move_speed = 140
var velocity = Vector2.ZERO
var dir = DIRECTION.RIGHT

var foot_active: bool = false


func _physics_process(delta):
	velocity = Vector2.ZERO

	if ManagerGameManager.can_move:
		velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#		global_translate(Vector2(Input.get_action_strength("ui_right") * move_speed - Input.get_action_strength("ui_left")  * move_speed, 0))

		if velocity.x > 0:
			$Sprite.play("run")
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.play("run")
			$Sprite.flip_h = true
		else:
			$Sprite.play("idle")

#		velocity = move_and_slide(Vector2(joystick.get_pos().x * move_speed, 0))
		velocity = move_and_slide(velocity * move_speed)
		if velocity.x != 0 && !$Footstep.playing && foot_active:
			$Footstep.play()
			foot_active = false


#func _input(event):
#	if ManagerGameManager.can_move:
#		if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_WHEEL_UP:
#			global_translate(Vector2(30, 0))
##			velocity = move_and_slide(Vector2(move_speed,0))
#			$Sprite.play("run")
#			$Sprite.flip_h = false
#		elif event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_WHEEL_DOWN:
#			global_translate(-Vector2(30, 0))
##			velocity = move_and_slide(-Vector2(move_speed, 0))
#			$Sprite.play("run")
#			$Sprite.flip_h = true
#
##	elif !ManagerGameManager.can_move:
##		if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_WHEEL_UP:
##			ManagerGameManager.emit_signal("stopper_forward", 1)
##		if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_WHEEL_DOWN:
##			ManagerGameManager.emit_signal("stopper_forward", -1)


func set_camera_bounds(top_left: Vector2, bottom_right: Vector2):
	$Camera2D.limit_bottom = bottom_right.x
	$Camera2D.limit_top = top_left.y
	$Camera2D.limit_left = top_left.x
	$Camera2D.limit_right = bottom_right.y


func _on_Sprite_animation_finished():
	foot_active = true
