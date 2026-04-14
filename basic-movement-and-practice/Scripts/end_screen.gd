extends Control

@onready var quit_button: Button = $quitButton2
@onready var win_audio: AudioStreamPlayer2D = $winAuidio

func _ready() -> void:
	visible = false
	quit_button.disabled = true
	Global.level_complete.connect(on_level_finish)

func on_level_finish():
	visible = true
	quit_button.disabled = false
	win_audio.play()
