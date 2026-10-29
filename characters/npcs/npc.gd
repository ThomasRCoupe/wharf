class_name NPC extends CharacterBody3D

@export var animation_player : AnimationPlayer
@onready var vision_manager: VisionManager = $VisionManager

enum STATES { IDLE, STRIDE }
var cur_state = STATES.IDLE

func _ready():
	set_idle()

func set_idle():
	animation_player.play("idle")
	cur_state = STATES.IDLE
	
func set_stride():
	animation_player.play("stride")
	cur_state = STATES.STRIDE
 
func _process(delta: float):
	match cur_state:
		STATES.IDLE:
			process_idle_state(delta)
			
func process_idle_state(delta: float):
	print(vision_manager.can_see_player())
