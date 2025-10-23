extends Control

@export var chosen_item: RigidBody2D

var is_dragging = false
var mouse_motion_delta = Vector2.ZERO

var original_position: Vector2

func _ready():
	set_process(true)
	original_position = self.position

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.is_pressed()
		
		if not is_dragging:
			self.position = original_position
		
	if event is InputEventMouseMotion and is_dragging:
		self.position += event.relative
		
		mouse_motion_delta += event.relative

func _process(delta):
	if is_dragging and chosen_item:
		if mouse_motion_delta != Vector2.ZERO:
			var target_velocity = mouse_motion_delta / delta
			
			chosen_item.control_item_velo(target_velocity)
		else:
			chosen_item.control_item_velo(Vector2.ZERO)
			
	mouse_motion_delta = Vector2.ZERO
