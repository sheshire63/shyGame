# Author: Sheshire | MIT Licensed.
extends StaticObject
class_name FellableTree


# Signals
signal felled

# enums

# Constants

# Node References
@onready var animation := $AnimationPlayer

# Exported Variables


# Properties
var is_alive := true


# Public Functions


# Logic
func _break() -> void:
	if is_alive:
		is_alive = false
		animation.play("Fell")
		felled.emit()
		health = 10.0
	else:
		super._break()



# ==================================
# Private Section
# ==================================


