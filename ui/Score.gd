extends Label

func update_score(points_scored: int) -> void:
	var score = int(text)
	score += points_scored
	text = str(score)