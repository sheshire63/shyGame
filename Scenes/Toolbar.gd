# Author: Sheshire | MIT Licensed.
extends HBoxContainer
class_name Toolbar


# Signals

# enums

# Constants

# Node References
@onready var item_handler := Global.players[0].item_handler
@export var color_inaktive := Color(1,1,1,0.5)

# Exported Variables


# Properties
var selected := 0 :
	set(new):
		get_child(selected).modulate = color_inaktive
		selected = new % (item_handler.get_child_count() + 1)
		item_handler.select(selected - 1)
		get_child(selected).modulate = Color.WHITE


# Public Functions


# Logic
func _ready() -> void:
	_setup()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hud_up"):
		selected += 1

	if event.is_action_pressed("hud_down"):
		selected -= 1

	for i in range(9):
		if event.is_action_pressed("hud%d" % i):
			selected = i - 1


# ==================================
# Private Section
# ==================================

func _clear() -> void:
	for i in get_children():
		if i.get_index() > 0:
			i.queue_free()


func _setup() -> void:
	_clear()

	for i in item_handler.items.size():
		var button := Button.new()
		var item: Item = item_handler.items[i]
		button.icon = item.icon
		button.modulate = color_inaktive
		button.pressed.connect(func(): selected = i)
		add_child(button)

