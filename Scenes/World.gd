# Author: Sheshire | MIT Licensed.
extends Node2D
class_name World


# Signals

# enums

# Constants

# Node References
@onready var Map: TileMap = $Level
# Exported Variables

# Properties


# Public Functions
func _ready() -> void:
	Global.world = self

# Logic



# ==================================
# Private Section
# ==================================


