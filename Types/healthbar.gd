# Author: Sheshire | MIT Licensed.
extends TextureProgressBar
class_name HealthBar


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var health := 1.0:
	set(new):
		health = new
		value = new
		if tween:
			tween.stop()
		tween = create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 1.0)
		timer.start()


# Properties
var tween: Tween
var timer := Timer.new()

# Public Functions


# Logic
func _ready() -> void:
	timer.wait_time = 3
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)

	var texture = GradientTexture2D.new()
	texture.gradient = Gradient.new()
	texture.gradient.colors = [Color.CRIMSON, Color.BLACK]
	texture.width = 64
	texture.height = 16
	offset_left = - texture.width / 2.0
	texture_progress = texture

	max_value = 1.0
	step = 0.001


func _on_timeout() -> void:
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0)

# ==================================
# Private Section
# ==================================


