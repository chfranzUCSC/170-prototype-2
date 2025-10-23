extends RigidBody2D


var is_controlled: = false;
var start_position: Vector2

func start_lift():
	is_controlled = true
	gravity_scale = 0.0

func stop_lift():
	is_controlled = false
	gravity_scale = 1.0

func _ready():
	start_position = self.global_position



func control_item_velo(new_velo):
	apply_force(new_velo)
