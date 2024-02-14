# Author: Sheshire | MIT Licensed.
extends Node
class_name StateMachine


# Signals

# enums

# Constants

# Nodes References

# Exported Variables
@export var state: State:
	set(new):
		if state:
			state.process_mode = Node.PROCESS_MODE_DISABLED
			state._state_exited()
		state = new
		state._state_entered()
		state.process_mode = Node.PROCESS_MODE_INHERIT


# Properties


# Public Functions


# Logic



# ==================================
# Private Section
# ==================================


