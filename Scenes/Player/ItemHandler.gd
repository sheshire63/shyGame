# Author: Sheshire | MIT Licensed.
extends Node2D
class_name ItemHandler


# Signals

# enums

# Constants

# Nodes References

# Exported Variables

# Properties
var active_item: Item:
	set(new):
		active_item = new
		#if active_item:
			#texture = active_item.icon
		#else:
			#texture = null
var is_busy := false
var items : Array[Item]


# Public Functions
func select(id := -1) -> void:
	if id >= 0 and id < items.size():
		active_item = items[id]
	else:
		active_item = null


# Logic
func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_item"):
		active_item.use(global_position)


# ==================================
# Private Section
# ==================================


