# Author: Sheshire | MIT Licensed.
extends Entity
class_name Enemy


# Signals
signal enemy_spotted(target:Entity)
signal enemy_lost(target:Entity)

# enums
enum STATE {roam, idle, hunt, attack, flee}

# Constants

# Nodes References
@export var points: Node2D ## a node with nodes as location markers as child
@onready var navigator := $NavigationAgent2D
@onready var weapon_handler := $WeaponHandler
# Exported Variables
@export var weapon: Weapon:
	set(new):
		weapon = new
		attack_reach = Global.UNIT / 2 +  weapon.get_range()

# Properties
var state := STATE.idle:
	set(new):
		var old_state = state
		state = new
		match old_state:
			STATE.attack:
				weapon_handler.auto = false
		match new:
			STATE.roam:
				_nav_to_random()
			STATE.hunt:
				_nav_to_target()
			STATE.attack:
				weapon_handler.auto = true

var enemies_nearby: Array[Entity] = []
var enemies_visible: Array[Entity] = []
var current_target: Entity
var attack_reach := 0.0

# Public Functions


# Logic

func _ready() -> void:
	super()
	#weapon_handler.weapon = weapon
	state = state #to update the state

	navigator.target_reached.connect(_nav_to_random)
	enemy_spotted.connect(_on_enemy_spotted)
	enemy_lost.connect(_on_enemy_lost)


func _process(_delta: float) -> void:
	match state:
		STATE.idle:
			if randf() <= 0.1:
				state = STATE.roam
		STATE.hunt:
			if is_in_attack_reach():
				state = STATE.attack


func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	for i in enemies_visible:
		if !_can_see_target(i):
			enemies_visible.erase(i)
			enemy_lost.emit(i)

	for i in enemies_nearby:
		if not i in enemies_visible and _can_see_target(i):
			enemies_visible.append(i)
			enemy_spotted.emit(i)

	_nav_to_target()

	match state:
		STATE.roam, STATE.hunt:
			direction = global_position.direction_to(navigator.get_next_path_position())
		STATE.attack:
			weapon_handler.rotation = global_position.angle_to_point(current_target.global_position)
			# we want to use a calucalted vector based on distance to the target and to other allies
			direction = global_position.direction_to(current_target.global_position)
			if !weapon_handler.is_attacking:
				direction *= global_position.distance_to(current_target.global_position) - attack_reach
			direction = direction.normalized()

	velocity = direction * Global.UNIT * speed
	move_and_slide()


func _on_vision_body_entered(body: Node2D) -> void:
	if body is Entity and body != self:
		enemies_nearby.append(body)


func _on_vision_body_exited(body: Node2D) -> void:
	if body is Entity:
		enemies_nearby.erase(body)
		enemies_visible.erase(body)
		if body == current_target:
			current_target = null
			state = STATE.idle

func _on_navigation_agent_2d_navigation_finished() -> void:
	match state:
		STATE.roam:
			_nav_to_random()
		STATE.hunt:
			state = STATE.roam


func _on_enemy_spotted(enemy: Entity) -> void:
	if !current_target:
		current_target = enemy

	state = STATE.hunt


func _on_enemy_lost(enemy: Entity) -> void:
	if current_target == enemy:
		current_target = enemies_visible[0] if enemies_visible else null

	if enemies_visible.is_empty():
		state = STATE.roam #todo extra state to move to the last known point?

# ==================================
# Private Section
# ==================================

func _nav_to_random() -> void:
	var point: Node = points.get_child(randi_range(0, points.get_child_count() -1))

	navigator.target_position = point.global_position


func _nav_to_target() -> void:
	if !current_target:
		return

	var target_position = current_target.global_position

	target_position += target_position.direction_to(global_position)

	navigator.target_position = target_position


func _can_see_target(target: CollisionObject2D) -> bool:
	var space_state := get_viewport().world_2d.direct_space_state
	var para := PhysicsRayQueryParameters2D.new()

	para.collision_mask = 3
	para.from = global_position
	para.to = target.global_position

	var collision = space_state.intersect_ray(para)
	if collision and collision.collider == target:
		return true
	return false

func is_in_attack_reach() -> bool:
	return global_position.distance_to(current_target.global_position) < attack_reach
