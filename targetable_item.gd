extends RigidBody2D

signal item_selected(item)

var is_controlled: = false;
var initial_position: Vector2
var initial_rotation: float

func start_lift():
	is_controlled = true
	gravity_scale = 0.0

func stop_lift():
	is_controlled = false
	gravity_scale = 1.0

func _ready():
	initial_position = self.global_position
	initial_rotation = self.global_rotation


func reset_item():
	self.position = initial_position
	self.rotation = initial_rotation
	



func control_item_velo(new_velo):
	apply_force(new_velo)
	

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		item_selected.emit(self)
