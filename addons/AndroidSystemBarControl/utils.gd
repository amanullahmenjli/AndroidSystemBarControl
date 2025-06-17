class_name Utils extends RefCounted


static func insets_to_dict(insets: JavaObject) -> Dictionary:
	var dict: Dictionary = {"left": 0, "top": 0, "right": 0, "bottom": 0}

	var insets_str = insets.toString()

	var regex = RegEx.new()
	regex.compile(r"(\w+)=(\d+)")

	for match in regex.search_all(insets_str):
		var key = match.get_string(1)
		var value = int(match.get_string(2))
		dict[key] = value

	return dict
