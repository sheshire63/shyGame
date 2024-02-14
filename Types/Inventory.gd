# Author: Sheshire | MIT Licensed.
extends GridContainer
class_name Inventory


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export var drop_on_destroyed := true
# Properties
var items := {} #key is the item value the InventoryItem

# Public Functions
func add(item: Item) -> void:
	if item in items:
		items[item].amount += 1
	else:
		items[item] = _create_item(item)


func drop() -> void:
	for i in get_children():
		for j in i.amount:
			_create_item_entity(i.item)


# Logic

func _ready() -> void:
	hide()
	if drop_on_destroyed:
		get_parent().destroyed.connect(drop)
	for i in get_children():
		if i.item in items:
			items[i.item].amount += i.amount
		else:
			items[i.item] = i



# ==================================
# Private Section
# ==================================


func _create_item_entity(item: Item) -> void:
	var entity := ItemEntity.new()
	var rand_dir: Vector2 = Vector2.RIGHT.rotated(randf() * TAU) * Global.UNIT * (randf() + 0.5)

	entity.item = item
	Global.world.call_deferred("add_child", entity)
	entity.global_position = get_parent().global_position + rand_dir
	entity.apply_central_impulse(rand_dir)


func _create_item(item:Item) -> InventoryItem:
	var icon := InventoryItem.new()
	icon.item = item
	add_child(icon)
	return icon
