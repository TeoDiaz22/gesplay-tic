extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Control/Panel/LineEdit.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
