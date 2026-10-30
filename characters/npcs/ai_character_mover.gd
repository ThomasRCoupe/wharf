class_name AICharacterMover extends CharacterMover 

@export var turn_speed = 200.0
@export var stop_distance = 1.5
@export var start_distance = 2.5

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var is_following = false


func start_moving(target_pos: Vector3):
	navigation_agent_3d.target_position = target_pos
	is_following = true


func stop_moving():
	is_following = false
	set_move_dir(Vector3.ZERO)
	
	
func getTargetPos(): 
	return navigation_agent_3d.target_position


func _physics_process(delta: float):
	super(delta)
	
	var target_dir = to_flat_dir(getTargetPos() - global_position)
	var distance_to_target = (getTargetPos() - global_position).length()
	
	if distance_to_target < stop_distance:
		stop_moving()
	
	## Movement
	if is_following and distance_to_target > start_distance:
		var next_move_dir = to_flat_dir(navigation_agent_3d.get_next_path_position() - global_position)
		set_move_dir(next_move_dir)
		target_dir = next_move_dir
	
	# Facing Direction
	var fwd = -character_body.global_transform.basis.z
	var right = character_body.global_transform.basis.x
	var angle_diff = fwd.angle_to(target_dir)
	var turn_dir = 1
	if right.dot(target_dir) > 0:
		turn_dir = -1
		
	var turn_amount = delta * deg_to_rad(turn_speed)
	if turn_amount > angle_diff:
		turn_amount = angle_diff
	
	character_body.global_rotation.y += turn_amount * turn_dir
