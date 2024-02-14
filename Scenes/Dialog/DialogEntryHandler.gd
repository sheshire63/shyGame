# Author: Sheshire | MIT Licensed.
extends Node
class_name DialogEntryHandler


# Signals

# enums

# Constants

# Node References

# Exported Variables

# Properties
var current_entry_index := 0

# Public Functions
func show_dialog() -> void:
	if Global.dialog.is_busy:
		return
	for i in get_child_count():
		var entry = get_child((current_entry_index + i) % get_child_count())
		if entry.test_condition(get_parent()):
			Global.dialog.display_text(entry.text)
			if entry.onetime:
				entry.queue_free()
			else:
				current_entry_index = entry.get_index() + 1
			break


# Logic
func _ready() -> void:
	get_parent().used.connect(show_dialog)


# ==================================
# Private Section
# ==================================


