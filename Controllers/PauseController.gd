extends Node

var pauseMenu

func _ready():
	self._initialization()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self._inputsHandler()
	
func _initialization():
	pauseMenu = get_node("PauseMenu")
	var resumeButton = get_node("PauseMenu/ResumeButton")
	resumeButton.pressed.connect(self._onResumeButtonPressed) #event needs to be connected that way because resumeButton is in another node
		
func _inputsHandler():
	self._handlePauseInput()

func _handlePauseInput():	
	if(Input.is_action_just_pressed("pause")):
		if(Main.getCurrentGameMode() == Main.GAME_MODE.IN_LEVEL_LOST || Main.getCurrentGameMode() == Main.GAME_MODE.IN_LEVEL_WIN):
			return
		
		var paused = get_node("/root").get_child(0).get_tree().paused
		pauseMenu.visible = !paused
		get_node("/root").get_child(0).get_tree().paused = !paused
		Main.setInLevelPauseGameMode(paused)

func _onResumeButtonPressed():
	get_node("/root").get_child(0).get_tree().paused = false
	pauseMenu.visible = false
