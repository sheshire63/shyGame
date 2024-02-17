# Author: Sheshire | MIT Licensed.
extends CharacterBody2D
class_name Entity


# Signals
signal destroyed

# enums

# Constants

# Node References
var bar := HealthBar.new()

# Exported Variables
@export var speed := 1.0
@export var health := 1.0:
	set(new):
		if new <= 0.0:
			die()
		health = new
		bar.health = new


# Properties


# Public Functions
func die() -> void:
	destroyed.emit()
	queue_free()

func damage(amount := 0.0) -> void:
	health -= amount

# Logic
func _ready() -> void:
	add_child(bar)


# ==================================
# Private Section
# ==================================


