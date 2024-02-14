# Author: Sheshire | MIT Licensed.
extends Entity
class_name Player


# Signals

# enums

# Constants

# Node References
@onready var item_handler := $FacingRot/ItemHandler
@onready var facing := $FacingRot
@onready var inventory := $Inventory

# Exported Variables


# Properties


# Public Functions


# Logic

func _ready() -> void:
	Global.players.append(self)


func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("player_left", "player_right", "player_up", "player_down")

	if !dir.is_zero_approx():
		facing.rotation = dir.angle()

	velocity = dir * speed * Global.UNIT
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_inventory"):
		inventory.visible = !inventory.visible




# ==================================
# Private Section
# ==================================


