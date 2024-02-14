# Author: Sheshire | MIT Licensed.
extends Node
class_name DialogManager


# Signals

# enums

# Constants

# Node References
@export var info_text_box: DialogLabel

# Exported Variables


# Properties
var is_busy := false


# Public Functions
func display_text(text: String) -> void:
	if is_busy == true:
		return
	info_text_box.show_text(text)
	is_busy = true


# Logic
func _ready() -> void:
	Global.dialog = self
	info_text_box.text_finished.connect(func(): is_busy = false)



# ==================================
# Private Section
# ==================================


