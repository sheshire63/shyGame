# Author: Sheshire | MIT Licensed.
extends Node
class_name DialogEntry


# Signals

# enums

# Constants

# Node References

# Exported Variables
@export_multiline var text := ""
@export var condition := "" #todo can we use gdscript code here?
@export var onetime := false

# Properties
var expression := Expression.new()
var data

# Public Functions
func test_condition(body: Node) -> bool:
	if !condition:
		return true
	return expression.execute(Global.variables.values(), body)


# Logic
func _ready() -> void:
	var err = expression.parse(condition, Global.variables.keys())
	assert(err == OK)



# ==================================
# Private Section
# ==================================


