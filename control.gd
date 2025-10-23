extends Control

@export var chosen_item: RigidBody2D

var is_dragging = false
var mouse_motion_delta = Vector2.ZERO

var original_position: Vector2

func _ready():
	set_process(true)
	original_position = self.position
	
	var items = get_tree().get_nodes_in_group("controllable_items")
	
	for item in items:
		if item.has_signal("item_selected"):
			# Connect the item's "item_selected" signal
			# to our new "on_item_selected" function
			item.item_selected.connect(on_item_selected)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.is_pressed()
		
		if is_dragging:
			if chosen_item and chosen_item.has_method("start_lift"):
				chosen_item.start_lift()
		
		if not is_dragging:
			if chosen_item and chosen_item.has_method("stop_lift"):
				chosen_item.stop_lift()
			self.position = original_position
		
	if event is InputEventMouseMotion and is_dragging:
		self.position += event.relative
		mouse_motion_delta += event.relative

func on_item_selected(item_that_was_clicked):
	if chosen_item and chosen_item.has_method("stop_lift"):
		chosen_item.stop_lift()

	chosen_item = item_that_was_clicked
	
	if is_dragging and chosen_item.has_method("start_lift"):
		chosen_item.start_lift()

func _process(delta):
	if is_dragging and chosen_item:
		#var target_velocity = (self.position - original_position) * 0.7
		if mouse_motion_delta != Vector2.ZERO:
			var target_velocity = mouse_motion_delta / delta
			chosen_item.control_item_velo(target_velocity)
		else:
			chosen_item.control_item_velo(Vector2.ZERO)
			
	mouse_motion_delta = Vector2.ZERO
