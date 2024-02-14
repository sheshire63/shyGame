# Author: Sheshire | MIT Licensed.
extends Button
class_name InventoryItem


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var item: Item:
	set(new):
		item = new
		icon = item.icon

@export var amount := 1:
	set(new):
		amount = new
		text = str(amount)
# Properties


# Public Functions


# Logic



# ==================================
# Private Section
# ==================================


