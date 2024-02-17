# Author: Sheshire | MIT Licensed.
extends Item
class_name Weapon


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var hitbox_offset := Vector2.ZERO
@export var hitbox_size := Vector2(4, 4)
@export var texture: Texture2D
@export var damage := 1.0
@export var speed := 2.0
@export var animation := WeaponHandler.ANIMATIONS.Swing

# Properties


# Public Functions
func get_range() -> float:
	return hitbox_size.x

# Logic



# ==================================
# Private Section
# ==================================


