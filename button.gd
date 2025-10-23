extends Button




func _on_pressed() -> void:
	get_tree().call_group("resettable_items", "reset_item")
