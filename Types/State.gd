# Author: Sheshire | MIT Licensed.
extends Node
class_name State


# Signals

# enums

# Constants

# Nodes References
@onready var body: Entity = $"."

# Exported Variables

# Properties


# Public Functions


# Logic
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


#virtual

func _state_entered() -> void:
	pass


func _state_exited() -> void:
	pass

# ==================================
# Private Section
# ==================================


