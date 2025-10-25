extends Control

@export var chosen_item: RigidBody2D

var is_dragging = false
var mouse_motion_delta = Vector2.ZERO

var original_position: Vector2

func _ready():
	set_process(true)
	
	original_position = self.position
	
	var items = get_tree().get_nodes_in_group("controllable_items")
	
	# connect item selection signal to change_target function
	for i in items:
		if i.has_signal("item_selected"):
			i.item_selected.connect(change_target)

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

func change_target(item):
	if (chosen_item != item) and chosen_item.has_method("stop_lift"):
		chosen_item.stop_lift()
		if chosen_item.has_method("hide_highlight"):
			chosen_item.hide_highlight()

	chosen_item = item
	
	if chosen_item.has_method("show_highlight"):
			chosen_item.show_highlight()
	
	if is_dragging and chosen_item.has_method("start_lift"):
		chosen_item.start_lift()
		
		
		

func _process(delta):
	if is_dragging and chosen_item:
		var target_velocity = mouse_motion_delta / delta
		chosen_item.control_item_velo(target_velocity)
			
	mouse_motion_delta = Vector2.ZERO
