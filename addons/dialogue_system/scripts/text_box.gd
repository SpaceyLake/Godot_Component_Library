extends RichTextLabel
class_name DialogueBox


func change_text(say:String, keys:Array):
	for key:String in keys:
		var pos = say.find(key)
		if pos != -1:
			say.insert(pos+key.length(), "[/color]")
			say.insert(pos, "[color=blue]")
	
	text = say
