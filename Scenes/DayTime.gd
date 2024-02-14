# Author: Sheshire | MIT Licensed.
extends CanvasModulate
class_name DayTime


# Signals
signal day_passed

# enums

# Constants

# Node References

# Exported Variables
@export var duration := 20 * 60
@export var gradient := Gradient.new()
@export var start := 6
# Properties
var time := 0.0

# Public Functions


# Logic
func _ready() -> void:
	time = duration / 24.0 * start

func _process(delta: float) -> void:
	time = (time + delta)
	if time > duration:
		time = 0.0
		day_passed.emit()
	var factor = abs(time / duration * 2 - 1)
	color = gradient.sample(factor)

# ==================================
# Private Section
# ==================================


