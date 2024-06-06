extends Control

var following=false
var dragPoint = Vector2()

signal dragged_panel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			following=not following
			dragPoint=get_local_mouse_position()
			dragged_panel.emit(following,dragPoint)
