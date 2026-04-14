extends Node

var score = 0
signal score_changed
signal player_died
signal respawn
signal level_complete

var spawn_x = -55
var spawn_y = -2

func _ready() -> void:
	score = 0

func add_score(amount):
	score += amount
	score_changed.emit(score)
