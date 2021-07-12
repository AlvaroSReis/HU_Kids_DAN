extends Node2D

onready var transition = $SceneTransition
onready var scoreShow = $GameElements/Score
onready var scoreShow2 = $GameElements/Score2
onready var scoreShow3 = $GameElements/Score3
onready var player = $GameElements/KinematicBody2D/Player
onready var touchButton = $TouchScreenButton
onready var backButton = $GameElements/BackButton/TheBackButton
onready var musicMain = GameAudio.get_node("Music/MusicMainMenu")
onready var musicGame = GameAudio.get_node("Music/MusicGame")
onready var playerChar = load(String("res://Sprites/Player_") + String(Globals.curPlayer) + ".png")
onready var hp_bar = $Bars/TextureProgress
onready var en_bar = $Bars/TextureProgress2
onready var happy_bar = $Bars/TextureProgress3

#var time = 0
var event = 0
var rngSelector = 0
var rnGenerator = RandomNumberGenerator.new()
var event_flag = 0

func _ready():
	
	backButton.connect("button_down", self, "_on_BackButton_button_down")
	backButton.connect("button_up", self, "_on_BackButton_button_up")
	#player.texture = playerChar
	
	#Hp bar
	hp_bar.max_value = Globals.hp
	hp_bar.value = Globals.hp
	en_bar.max_value = Globals.energy
	en_bar.value = Globals.energy
	happy_bar.max_value = Globals.happy
	happy_bar.value = Globals.happy
	
	#pet events
	player.texture = playerChar
	player.scale = Vector2(0.60, 0.60)
	Globals.messagesShowing = false
	# Stopping the Main Menu music and starting the GAME tracks
	musicMain.stop()
	musicGame.play()
	# Will have to be saved into a file save system and send to google play services (Save Games)


func _process(_delta):
	scoreShow.text = String(Globals.hp)
	hp_bar.value = Globals.hp
	scoreShow2.text = String(Globals.energy)
	en_bar.value = Globals.energy
	scoreShow3.text = String(Globals.happy)
	happy_bar.value = Globals.happy
	event = rnGenerator.randi_range(1, 250)

	if event == 1:
		event_flag = rnGenerator.randi_range(1,5)
		if Globals.energy >= 11:
			Globals.energy -= 1
	if event == 2:
		rngSelector = rnGenerator.randi_range(1,5)
		if Globals.hp >= 11:
			Globals.hp -= rngSelector
	if event == 3:
		rngSelector = rnGenerator.randi_range(1,5)
		if Globals.happy >= 11:
			Globals.happy -= rngSelector
	if event >= 4:
		pass

# The function that triggers the style change

func button_is_pushed(target, style):
	var button_style = get_node(target)
	var style_pushed = load(style)
	button_style.set('custom_styles/panel', style_pushed)

# Backbutton
func _on_BackButton_button_down():
	pass

func _on_BackButton_button_up():
	$GameElements/BackButton.backAction()
	Globals.playing = false
	var a_player = transition.fade_in()
	yield(a_player, "animation_finished")
	SceneManager.goto_scene("res://Scenes/Main.tscn")

func _on_TouchScreenButton_pressed():
	#time = 0
	if Globals.hp <= 10:
		Globals.hp = 100
	elif Globals.energy <= 10:
		Globals.energy = 100
	elif Globals.happy <= 10:
		Globals.happy = 100


