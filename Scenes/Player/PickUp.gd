# Author: Sheshire | MIT Licensed.
extends Area2D
class_name PickUp


# Signals

# enums

# Constants

# Child Nodes References
@export var inventory: Inventory
# Exported Variables

# Properties


# Public Functions
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	collision_mask = 16
	collision_layer = 0

# Logic



# ==================================
# Private Section
# ==================================




func _on_body_entered(body: Node2D) -> void:
	if body is ItemEntity:
		inventory.add(body.item)
		body.queue_free()
