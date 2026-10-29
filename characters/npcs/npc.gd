class_name NPC extends CharacterBody3D

@export var animation_player : AnimationPlayer

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
