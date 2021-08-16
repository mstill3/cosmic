extends Control


var text: String = ""
var files = ["ENGINE.DAT", "MISSION.DAT", "AUTOPILOT.DAT", "SAFETY_LOCK.DAT"]
var admin = false

var engine_file_content = "This contains the core instructions to having a fully operational engine in the ship"
var mission_file_content = "We need to stop the meteroid before it destroys Earth"
var autopilot_file_content = "This contains the core instructions to operating a fulling functioning autopilot system to ensure saftey of all crew abord"
var safety_lock_file_content = "This constains the core instructions for protecting the ship from making poor decisions that would endanger the lives of the crew"
var admin_file_content = "You can now use the command SUDO in front of other commands to force the ship to take actions"

signal disconnect
signal fire_laser

func _ready() -> void:
	visible = false
	text = ""
	admin = false

func _input(event: InputEvent) -> void:
	text = text.strip_edges(true, false)
	if event is InputEventKey:
		if event.pressed == false:
			var key_name = OS.get_scancode_string(event.scancode)
			if key_name == "BackSpace":
				text.erase(text.length() - 1, 1)
			elif key_name == "Space":
				text += " "
			elif key_name == "Left" or key_name == "Right" or key_name == "Up" or key_name == "Down" or key_name == "Command" or key_name == "Shift" or key_name == "Tab" or key_name == "Control" or key_name == "Alt" or key_name == "Comma":
				pass
			elif key_name == "Period":
				text += "."
			elif key_name == "Minus":
				text += "_"
			elif key_name == "Enter":
				respond()
				text = ""
			elif key_name == "Escape":
				text = "EXIT"
				respond()
				text = ""
			else:
				text += key_name

#			print(text)
			$UserText.text = text

func respond() -> void:
	text = text.strip_edges(true, true)
	var msg = ""
	print(text)
	if text == "HELP":
		msg = "EXIT - Dismiss terminal\nCAT - Read file\nLS - View files\nRM - Delete file\nCLEAR - Clears terminal output\nFIRE_LASER - Shoots laser at closest threat"
	elif text == "EXIT":
		if visible:
			emit_signal("disconnect")
		visible = false
		get_tree().paused = false
	elif text == "CLEAR":
		msg = ""
	elif text == "LS":
		msg = array_to_string(files, "   ")
	elif text == "CAT ENGINE.DAT" and files.has("ENGINE.DAT"):
		msg = engine_file_content
	elif text == "CAT ENGINE.DAT" and not files.has("ENGINE.DAT"):
		msg = "ENGINE.DAT file does not exist"
	elif text == "CAT MISSION.DAT" and files.has("MISSION.DAT"):
		msg = mission_file_content
	elif text == "CAT MISSION.DAT" and not files.has("MISSION.DAT"):
		msg = "MISSION.DAT file does not exist"
	elif text == "CAT AUTOPILOT.DAT" and files.has("AUTOPILOT.DAT"):
		msg = autopilot_file_content
	elif text == "CAT AUTOPILOT.DAT" and not files.has("AUTOPILOT.DAT"):
		msg = "AUTOPILOT.DAT file does not exist"
	elif text == "CAT SAFETY_LOCK.DAT" and files.has("SAFETY_LOCK.DAT"):
		msg = safety_lock_file_content
	elif text == "CAT SAFETY_LOCK.DAT" and not files.has("SAFETY_LOCK.DAT"):
		msg = "SAFETY_LOCK.DAT file does not exist"
	elif text == "CAT ADMIN.DAT" and files.has("ADMIN.DAT"):
		msg = admin_file_content
	elif text == "CAT ADMIN.DAT" and not files.has("ADMIN.DAT"):
		msg = "Unknown Input"
		
	elif text == "RM ENGINE.DAT" and files.has("ENGINE.DAT"):
		msg = "ENGINE.DAT file has been deleted"
		files.erase("ENGINE.DAT")
	elif text == "RM ENGINE.DAT" and not files.has("ENGINE.DAT"):
		msg = "ENGINE.DAT file does not exist"
	elif text == "RM MISSION.DAT" and files.has("MISSION.DAT"):
		msg = "MISSION.DAT file has been deleted"
		files.erase("MISSION.DAT")
	elif text == "RM MISSION.DAT" and not files.has("MISSION.DAT"):
		msg = "MISSION.DAT file does not exist"
	elif text == "RM AUTOPILOT.DAT" and files.has("AUTOPILOT.DAT"):
		msg = "AUTOPILOT.DAT file has been deleted"
		files.erase("MISSION.DAT")
	elif text == "RM AUTOPILOT.DAT" and not files.has("AUTOPILOT.DAT"):
		msg = "AUTOPILOT.DAT file does not exist"
	elif text == "RM SAFETY_LOCK.DAT" and files.has("SAFETY_LOCK.DAT"):
		msg = "SAFETY_LOCK.DAT file has been deleted\nNew file has been added"
		files.erase("SAFETY_LOCK.DAT")
		files.append("ADMIN.DAT")
		admin = true
	elif text == "RM SAFETY_LOCK.DAT" and not files.has("SAFETY_LOCK.DAT"):
		msg = "SAFETY_LOCK.DAT file does not exist"
	elif text == "RM ADMIN.DAT" and files.has("ADMIN.DAT"):
		msg = "ADMIN.DAT file has been deleted"
		files.erase("ADMIN.DAT")
	elif text == "RM ADMIN.DAT" and not files.has("ADMIN.DAT"):
		msg = "Unknown Input"
	
	elif text == "FIRE_LASER":
		msg = "You do not have the privileges to override a saftey mesasure. The amount of remaining fuel to return the ship back home would not be enough if this operation is taken"
	elif text == "SUDO FIRE_LASER" and not admin:
		msg = "You do not have the privileges to override a saftey mesasure. The amount of remaining fuel to return the ship back home would not be enough if this operation is taken"
	elif text == "SUDO FIRE_LASER" and admin:
		msg = "I sure hope you know what you are doing.\nThe laser has been started"
		emit_signal("fire_laser")
	else:
		msg = "Unknown Input"
		
	$PCText.text = msg


func array_to_string(arr: Array, spacing: String) -> String:
	var out = ""
	for i in range(0, arr.size()):
		out += arr[i] + spacing
	return out
