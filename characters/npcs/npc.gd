class_name NPC extends CharacterBody3D

@export var animation_player : AnimationPlayer
@export var animation_blend_time = 0.5

@onready var vision_manager: VisionManager = $VisionManager
@onready var ai_character_mover: AICharacterMover = $AICharacterMover
@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

enum STATES { IDLE, FOLLOW }
var cur_state = STATES.IDLE

func _ready():
	set_idle()
	

func set_idle():
	print("set idle")
	animation_player.play("idle", animation_blend_time)
	cur_state = STATES.IDLE
	
	
func set_follow():
	cur_state = STATES.FOLLOW
	
 
func _process(delta: float):
	match cur_state:
		STATES.IDLE:
			process_idle_state(delta)
		STATES.FOLLOW:
			process_stride_state(delta)
			
			
func process_idle_state(delta: float):
	if vision_manager.can_see_player():
		set_follow()
		return
	
	ai_character_mover.stop_moving()
	
		
func process_stride_state(delta: float):
	if !vision_manager.can_see_player():
		set_idle()
		return
		
	ai_character_mover.start_moving(player.global_position)
	if !ai_character_mover.is_moving() and animation_player.assigned_animation == "stride":
		animation_player.play("idle", animation_blend_time)
	elif ai_character_mover.is_moving() and animation_player.assigned_animation != "stride":
		animation_player.play("stride", animation_blend_time)
