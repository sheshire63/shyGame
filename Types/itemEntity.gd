# Author: Sheshire | MIT Licensed.
extends RigidBody2D
class_name ItemEntity


# Signals

# enums

# Constants

# Node References
var sprite := Sprite2D.new()

# Exported Variables
@export var item: Item


# Properties


# Public Functions


# Logic
func _ready() -> void:
	if !item:
		queue_free()

	sprite.texture = item.icon
	add_child(sprite)

	collision_layer = 16
	collision_mask = 1

	var collision := CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 16
	add_child(collision)





# ==================================
# Private Section
# ==================================


