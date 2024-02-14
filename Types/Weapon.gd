# Author: Sheshire | MIT Licensed.
extends Item
class_name Weapon


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var hitbox_offset := Vector2.ZERO
@export var hitbox_size := Vector2(32, 4)
@export var texture: Texture2D
@export var damage := 3.0

# Properties


# Public Functions
func get_range() -> float:
	return hitbox_size.x

# Logic



# ==================================
# Private Section
# ==================================


