class_name NPC extends CharacterBody3D

@export var animation_player : AnimationPlayer
@export var animation_blend_time = 1.0

@onready var vision_manager: VisionManager = $VisionManager
@onready var character_mover: CharacterMover = $CharacterMover
@onready var player = get_tree().get_first_node_in_group("player")

enum STATES { IDLE, STRIDE }
var cur_state = STATES.IDLE

func _ready():
	set_idle()

func set_idle():
	animation_player.play("idle", animation_blend_time)
	cur_state = STATES.IDLE
	
func set_stride():
	animation_player.play("stride", animation_blend_time)
	cur_state = STATES.STRIDE
 
func _process(delta: float):
	match cur_state:
		STATES.IDLE:
			process_idle_state(delta)
		STATES.STRIDE:
			process_stride_state(delta)
			
func process_idle_state(delta: float):
	if vision_manager.can_see_player():
		set_stride()
		
func process_stride_state(delta: float):
	if !vision_manager.can_see_player():
		set_idle()
		
	#var target_pos = player.global_position + Vector3.UP * 1.6
	#var dir_to_target = global_position.direction_to(target_pos)
	#character_mover.set_move_dir(dir_to_target)
