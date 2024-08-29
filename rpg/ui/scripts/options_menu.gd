extends Node

@export var settings_save : SettingsSave
@export var default_save : SettingsSave
@export var save_path : String = "user://settings.ini"

@export_group("display settings")
@export var resolution_dropdown : OptionButton
@export var window_dropdown : OptionButton
@export var fpscap_dropdown : OptionButton

@export_group("quality settings")
@export var anti_aliasing_dropdown : OptionButton
@export var textures_swapper : texture_swap
@export var textures_dropdown : OptionButton

@export_group("audio settings")
@export var master_slider : HSlider
@export var master_label : Label
@export var music_slider : HSlider
@export var music_label : Label
@export var voice_slider : HSlider
@export var voice_label : Label
@export var effects_slider : HSlider
@export var effects_label : Label

func _ready():
	load_settings()

#region display settings
func set_resolution(index):
	settings_save.resolution = index
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(4096,2160))
		1:
			DisplayServer.window_set_size(Vector2i(2560,1440))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		3:
			DisplayServer.window_set_size(Vector2i(1280,720))
		4:
			DisplayServer.window_set_size(Vector2i(960, 540))
	
	#save the settings
	save_settings()

func set_window(index):
	settings_save.window = index
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	#save the settings
	save_settings()

func set_fps_cap(index):
	settings_save.fps_cap = index
	
	match index:
		0:
			Engine.max_fps = 0
		1:
			Engine.max_fps = 144
		2:
			Engine.max_fps = 120
		3:
			Engine.max_fps = 60
		4:
			Engine.max_fps = 30
	
	#save the settings
	save_settings()
#endregion

#region quality settings

func set_AA(index):
	settings_save.anti_aliasing = index
	
	match index:
		0:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", "off")
		1:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", "2x (Average)")
		2:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", 2)
		3:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", 3)
	#save the settings
	save_settings()

func set_textures(index):
	settings_save.texture_quality = index
	
	#loops through all the materials in a list
	for mat in textures_swapper.materials:
		#gets their texture
		#(setting it like this is NOT needed but its nicer to read)
		var text = mat.textures[index]
		
		#sets the texture
		mat.material.albedo_texture = text
	
	save_settings()
#endregion

#region audio settings

func set_master_audio(val : float):
	#save the master vol
	
	settings_save.master = val
	
	#set the master bus volume
	AudioServer.set_bus_volume_db(0, val)
	
	#set the master label text
	master_label.text = "Master Volume (" + str(val + 80) + "):"
	
	#save the settings
	save_settings()

func set_music_audio(val : float):
	#save the music vol
	settings_save.music = val
	
	#set the music bus volume
	AudioServer.set_bus_volume_db(1, val)
	 
	#set the musics label text
	music_label.text = "Music Volume (" + str(val + 80) + "):"
	
	#save the settings
	save_settings()

func set_voice_audio(val : float):
	#save the voice vol
	settings_save.voice = val
	
	#set the voice bus volume
	AudioServer.set_bus_volume_db(2, val)
	
	#set the voice label text
	voice_label.text = "Voice Volume (" + str(val + 80) + "):"
	
	#save the settings
	save_settings()

func set_effects_audio(val : float):
	#save the effects vol
	
	settings_save.effects = val
	
	#set the effects bus volume
	AudioServer.set_bus_volume_db(3, val)
	
	#set the effects label text
	effects_label.text = "Effects Volume (" + str(val + 80) + "):"
	
	#save the settings
	save_settings()

#endregion

func save_settings():
	#creates the save path
	var save_file = ConfigFile.new()
	
	save_file.set_value("graphics_display", "resolution", settings_save.resolution)
	save_file.set_value("graphics_display", "window_mode", settings_save.window)
	save_file.set_value("graphics_display", "fps_cap", settings_save.fps_cap)
	
	save_file.set_value("graphics_quality", "anti-aliasing", settings_save.anti_aliasing)
	save_file.set_value("graphics_quality", "texture_quality", settings_save.texture_quality)
	
	save_file.set_value("audio", "master", settings_save.master)
	save_file.set_value("audio", "music", settings_save.music)
	save_file.set_value("audio", "voice", settings_save.voice)
	save_file.set_value("audio", "effects", settings_save.effects)
	
	#if an error happens while saving it prints it
	# otherwise it just saves
	var save_error = save_file.save(save_path)
	if save_error:
		print("an error has accured while saving: " + save_error)

func load_settings():
	var save_file = ConfigFile.new()
	var load_error = save_file.load(save_path)
	
	if load_error:
		return
	
	#loads resolution settings
	settings_save.resolution = save_file.get_value("graphics_display", "resolution", default_save.resolution)
	resolution_dropdown.select(settings_save.resolution)
	set_resolution(settings_save.resolution)
	
	#loads window settings
	settings_save.window = save_file.get_value("graphics_display", "window_mode", default_save.window)
	window_dropdown.select(settings_save.window)
	set_window(settings_save.window)
	
	#loads fps settings
	settings_save.fps_cap = save_file.get_value("graphics_display", "fps_cap", default_save.fps_cap)
	fpscap_dropdown.select(settings_save.fps_cap)
	set_fps_cap(settings_save.fps_cap)
	
	
	#loads AA settings
	settings_save.anti_aliasing = save_file.get_value("graphics_quality", "anti-aliasing", default_save.anti_aliasing)
	anti_aliasing_dropdown.select(settings_save.anti_aliasing)
	set_AA(settings_save.anti_aliasing)
	
	#loads texture settings
	settings_save.texture_quality = save_file.get_value("graphics_quality", "texture_quality", default_save.texture_quality)
	textures_dropdown.select(settings_save.texture_quality)
	set_textures(settings_save.texture_quality)
	
	
	#loads master volume settings
	settings_save.master = save_file.get_value("audio", "master", default_save.master)
	master_slider.value = settings_save.master
	set_master_audio(settings_save.master)
	
	#loads music volume settings
	settings_save.music = save_file.get_value("audio", "music", default_save.music)
	music_slider.value = settings_save.music
	set_music_audio(settings_save.music)
	
	#loads voice volume settings
	settings_save.voice = save_file.get_value("audio", "voice", default_save.voice)
	voice_slider.value = settings_save.voice
	set_voice_audio(settings_save.voice)
	
	#loads effects volume settings
	settings_save.effects = save_file.get_value("audio", "effects", default_save.effects)
	effects_slider.value = settings_save.effects
	set_voice_audio(settings_save.effects)
