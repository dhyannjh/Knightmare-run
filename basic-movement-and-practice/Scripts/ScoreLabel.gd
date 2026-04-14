extends Label

func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)

func _on_score_changed(score):
	self.text = "Score: " + str(score)

'''
func _process(delta: float) -> void:
	self.text = str(Global.score)
'''
