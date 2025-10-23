extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_controlled = false
var start_position: Vector2


var wallet_size: Vector2

func _ready():
	start_position = self.global_position

func _physics_process(_delta):
	if is_controlled:
		gravity_scale = 0.0
	else:
		gravity_scale = 1.0
	is_controlled = false
	
	



func control_item_velo(new_velo):
	apply_force(new_velo)
	is_controlled = true
