extends Control

class_name LevelButton

@export var locked=true
@export var level_name="Nivel 1"
@export var level=1
@export var stars=0
@export var texturePath="res://assets/cursor_game/levels/icons/level_1.png"

@onready var label:Label=$button/Text
@onready var button:TextureButton=$button
var levels=[
	preload("res://scenes/menu/pages/cursor/cursor_levels.tscn"),
	preload("res://scenes/menu/pages/cursor/levels/level_1.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$locked.visible=locked
	label.text=level_name
	$stars.set_stars(stars)
	change_texture(texturePath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	MenuManager.load_packed_scene(levels[level])

func change_texture(res):
	var image = Image.new()
	image.load_from_file(res)
	var imageTexture = ImageTexture.create_from_image(image)
	button.texture_normal=load(res)
