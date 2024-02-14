# Author: Sheshire | MIT Licensed.
extends RichTextLabel
class_name DialogLabel


# Signals
signal text_finished
# enums

# Constants

# Node References
var timer := Timer.new()
var tween : Tween

# Exported Variables
@export var chars_pro_sec := 10.0


# Properties

# Public Functions
func show_text(display_text) -> void:
	var duration := float(display_text.length()) / chars_pro_sec
	text = display_text
	visible_characters = 0
	show()
	tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, duration)
	timer.start(duration * 1.5)
	await timer.timeout
	hide()
	text_finished.emit()


# Logic
func _ready() -> void:
	bbcode_enabled = true
	timer.one_shot = true
	add_child(timer)


# ==================================
# Private Section
# ==================================


