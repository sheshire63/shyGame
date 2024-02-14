# Author: Sheshire | MIT Licensed.
extends Area2D
class_name InteractArea


# Signals

# enums

# Constants

# Node References

# Exported Variables

# Properties
var static_targets: Array[StaticObject] = []
var entity_targets: Array[Entity] = []

var last_index := 0:
	set(new):
		var total = static_targets.size() + entity_targets.size()
		if total == 0:
			last_index = 0
			return
		last_index = new % total


# Public Functions

func get_target():
	if static_targets.is_empty() and entity_targets.is_empty():
		return null
	var index = last_index
	last_index += 1
	if entity_targets.size() > index:
		return entity_targets[index]
	index -= entity_targets.size()
	if static_targets.size() > index:
		return static_targets[index]



# Logic

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_interact"):
		var target = get_target()
		if target:
			target.use()


func _on_body_entered(body: Node2D) -> void:
	last_index = 0
	if body is StaticObject:
		static_targets.append(body)
	elif body is Entity:
		entity_targets.append(body)


func _on_body_exited(body: Node2D) -> void:
	last_index = 0
	if body is StaticObject:
		static_targets.erase(body)
	elif body is Entity:
		entity_targets.append(body)



# ==================================
# Private Section
# ==================================


