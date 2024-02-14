# Author: Sheshire | MIT Licensed.
extends StaticBody2D
class_name StaticObject


# Signals
signal used
signal destroyed

# enums

# Constants

# Node References
var bar := HealthBar.new()


# Exported Variables
@export var health := 1.0:
	set(new):
		bar.health = new
		if new <= 0.0:
			_break()
		else:
			health = new

@export var inventory: Array[Item] = []#todo make this a seperate node

# Properties

# Public Functions
func use() -> void:
	used.emit()
	_use()


func damage(amount := 1.0) -> void:
	health -= amount / 10


# Logic
func _ready() -> void:
	add_child(bar)


# virtual
func _break() -> void:
	destroyed.emit()
	queue_free()


func _use() -> void:
	pass

# ==================================
# Private Section
# ==================================


