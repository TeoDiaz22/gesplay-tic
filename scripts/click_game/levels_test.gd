extends Node2D

@onready var star_points = $StarPoints
@onready var sound_controller = $SoundControllerClick

var success_count = 0
var success_to_win = 0
var mistakes_count = 0
var final_points: float = 0
var points_by_food: float
var points_by_animal: float

signal game_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	init_dragabble_objects()
	set_points()

func init_dragabble_objects():
	var dragabbles_list = get_tree().get_nodes_in_group('draggable')
	success_to_win = get_tree().get_nodes_in_group('dropable').size()
	for draggable in dragabbles_list:
		draggable.success.connect(_on_draggable_object_success)
		draggable.mistake.connect(_on_draggable_object_mistake)
		draggable.food_point.connect(_on_draggable_object_food)

func set_points():
	var points: float = 3.0 / (success_to_win * 2.0)
	print("points by: ",points)
	points_by_food = points
	points_by_animal = points

func _on_draggable_object_food():
	increase_food_point()
	sound_controller.play_fx(SoundClickSources.sounds_fx.POINT)

func _on_draggable_object_success():
	increase_success()
	increase_animal_point()
	check_success()
	
func _on_draggable_object_mistake():
	increase_mistakes()
	sound_controller.play_fx(SoundClickSources.sounds_fx.MISTAKE)
	
func increase_food_point():
	final_points += points_by_food
	set_star_points()
	
func increase_animal_point():
	final_points += points_by_animal 
	set_star_points()
	
func increase_success():
	success_count += 1
	print("Succes count: ", success_count)

func check_success():
	if success_count >= success_to_win:
		sound_controller.play_fx(SoundClickSources.sounds_fx.LEVEL_COMPLETE)
		var timer = Timer.new()
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()
	else:
		sound_controller.play_fx(SoundClickSources.sounds_fx.SUCESS)

func _on_timer_timeout():
		game_finished.emit()

func increase_mistakes():
	mistakes_count += 1
	print("Mistakes count: ", mistakes_count)
	
func set_star_points():
	star_points.set_stars_image(final_points)
