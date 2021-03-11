extends Node

func save(highscore: int) -> void:
	var file: File = File.new()
	var err: int = file.open("user://highscore.sav", File.WRITE)
	if err:
		print_debug("Error open file")
	file.store_var(highscore)
	file.close()

func get_highscore() -> int:
	var file: File = File.new()
	if not file.file_exists("user://highscore.sav"):
		return 0
	var err: int = file.open("user://highscore.sav", File.READ)
	if err:
		print_debug("Error open file")
	var highscore: int = file.get_var() as int
	if highscore:
		return highscore
	else:
		return 0
