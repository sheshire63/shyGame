# Author: Sheshire | MIT Licensed.
extends Resource
class_name Item


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var name := "Item"
@export var icon: Texture
@export var quality := 1.0
@export var tags: PackedStringArray = []
@export var inventory: Array[Item]

# Properties


# Public Functions

func use_on_static(_target: StaticObject, _at: Vector2) -> void:
	pass


func use_on_entity(_target: Entity, _at: Vector2) -> void:
	pass


func use(_at: Vector2) -> void:
	pass


# Logic



# ==================================
# Private Section
# ==================================


