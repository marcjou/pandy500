extends Node

var high_score: float = 99999999.9
var format_highscore: String = ""
var track: String = ""
var data: Dictionary

func save():
	if FileAccess.file_exists("user://save.cfg"):
		var cfgFile = FileAccess.open("user://save.cfg", FileAccess.READ)
		var content = cfgFile.get_as_text()
		cfgFile.close()
		if content != "":
			var parsed = JSON.parse_string(content)
			if typeof(parsed) == TYPE_DICTIONARY:
				data = parsed
	
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	
	
	data[str(track)] = { 
		"HighScore": high_score,
		"FormatHighscore": format_highscore
	}
	cfgFile.store_line(JSON.stringify(data))
	cfgFile.close()
	
func load():
	if not FileAccess.file_exists("user://save.cfg"):
		save()
		return
	var cfgFile = FileAccess.open("user://save.cfg", FileAccess.READ)
	
	var data = JSON.parse_string(cfgFile.get_as_text())
	
	if typeof(data) == TYPE_DICTIONARY:
		if not data.has(str(track)):
			save()
			return
		var datum = data.get(str(track), "")
		high_score = datum.get("HighScore", 0)
		format_highscore = datum.get("FormatHighscore", "")
	print(high_score)
