# Author: Sheshire | MIT Licensed.
extends AnimatedSprite2D
class_name MovingSprite


# Signals

# enums

# Constants

# Node References
@onready var body: CharacterBody2D = $".."

# Exported Variables
@export var idle_time := 5.0

# Properties
var timer := Timer.new()

# Public Functions


# Logic
func _ready() -> void:
	timer.wait_time = idle_time
	timer.timeout.connect(_on_idle_timeout)
	add_child(timer)


func _unhandled_input(_event: InputEvent) -> void:
	timer.start()


func _physics_process(_delta: float) -> void:
	if body.velocity.is_zero_approx():
		if str(animation).begins_with("walk"):
			play("Idle" + str(animation)[-1])

	else:
		timer.start()

		match abs(body.velocity).max_axis_index():
			Vector2.AXIS_X:
				if body.velocity.x > 0:
					play("walkE")
				else:
					play("walkW")
			Vector2.AXIS_Y:
				if body.velocity.y > 0:
					play("walkS")
				else:
					play("walkN")

func _on_idle_timeout() -> void:
	play("Idle1" if randf() > 0.5 else "Idle2")

# ==================================
# Private Section
# ==================================


