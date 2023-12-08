extends Node2D

onready var problem_text = get_node("Label")

onready var click = get_node("AudioStreamPlayer")
onready var music = get_node("music")

onready var option_one_text = get_node("option_1/text_for_option_1")
onready var option_two_text = get_node("option_2/text_for_option_2")

onready var button_one = get_node("option_1")
onready var button_two = get_node("option_2")

onready var guilt = get_node("enter_guilty")
onready var part = get_node("Particles2D")
onready var notes = get_node("open_notes")

var amount = 0.004

var current_room = "start"
var past_room = null
var checker = false
var let_text_flow = false
var opened = false
var tr = false

func _ready():
	button_two.visible = false
	reset()
	
func reset():
	let_text_flow = false
	checker = false
	problem_text.percent_visible = 0.0
	yield(get_tree().create_timer(1.0), "timeout")
	let_text_flow = true
	amount = 0.004
func _physics_process(delta):
	if opened == true:
		notes.rect_position = lerp(notes.rect_position, Vector2(392,-24), 0.2)
	else:
		notes.rect_position = lerp(notes.rect_position, Vector2(936,-24), 0.2)
	
	if checker == true:
		problem_text.percent_visible += amount
		
		guilt.rect_position = lerp(guilt.rect_position, Vector2(320,512),0.2)
	elif checker == false:
		guilt.rect_position = lerp(guilt.rect_position, Vector2(320,680),0.2)
	
	if let_text_flow == true:
		problem_text.percent_visible += amount
		button_one.rect_position = lerp(button_one.rect_position, Vector2(128,430),0.2)
		button_two.rect_position = lerp(button_two.rect_position, Vector2(576,430),0.2)
	else:
		button_one.rect_position = lerp(button_one.rect_position, Vector2(128,704),0.2)
		button_two.rect_position = lerp(button_two.rect_position, Vector2(576,704),0.2)


func _on_quit_pressed():
	get_tree().quit()


func _on_option_1_pressed():
	reset()
	click.playing = true
	if tr == false:
		yield(get_tree().create_timer(1), "timeout")
		button_two.visible = true
		tr = true
		
		
	past_room = current_room
	#start of the game
	if past_room == "start":
		current_room = "Investigate"
		problem_text.text = "blood trailed from the alleyway into where the dead man lay \n his body had noticable marks on it, scars? \n maybe hit by a car, or maybe beaten with a bat \n Malcom had loved to play baseball \n the building next to the alleyway was a bar"
		option_one_text.text = "obtain a list of last nights patrons"
		option_two_text.text = "Look for a murder weapon"

	if past_room == "look for weapon":
		current_room = "call it in"
		problem_text.text = "Malcom walks back to his police car and phones it to the HQ, they ask him to investigate local activies in the area. after leaving the call, malcom checks online, finding that the bar next door had an event going the night before. he sends 4 attendees/employees to the HQ as suspects."
		option_one_text.text = "investigate the suspects at HQ"
		option_two_text.text = "Drive home and take a nap"
	
	if past_room == "Investigate":
		current_room = "list"
		problem_text.text = "Malcom walks back to his police car \n he looks up if there was an event yesterday at the bar. there was a small one, with only 3 attendees, 5 counting employees. he sends the 4 suspects to the police office. \n malcom rubs his head, he slept poorly, the ambulances will arive soon"
		option_one_text.text = "investigate the suspects at HQ"
		option_two_text.text = "Drive home and take a nap"
		
	if past_room == "wait for amb":
		current_room = "heading back"
		problem_text.text = "as Malcom heads back to his car, an officer aproaches him with a look of worry \n Officer: uhm, sir, you should know that there was an event yesterday at the bar next door that went out late, i just talked with the owner and he said you were in attendance? Malcom's headache worsened"
		option_one_text.text = "Get in the car"
		option_two_text.text = "Get in the car"		
		
	if past_room == "heading back" or past_room == "nap time":
		current_room = "leaving"
		problem_text.text = "Malcom needs not bother himself with this. there's so little time, he must go to the Police HQ to figure out who killed the old man. he waves the cop off and gets in his car, driving off before the officer can get another word out. Malcom arives at HQ to find the suspects waiting to be interogated"
		option_one_text.text = "investigate the first suspect"
		option_two_text.text = "investigate the second suspect"

	if past_room == "list" or past_room == "call it in":
		current_room = "suspects"
		problem_text.text = "after ariving at the police HQ, Malcom walks to the interigation room, to have a talk with the suspects. 2 of suspects have been already exscused, a time of death was identified and alibies were provided \n the remaining two suspects are Jenkins, a felow detective, and Ralph, a chronic drunk"
		option_one_text.text = "Interogate Jenkins First"
		option_two_text.text = "Interogate Ralph First"
		
	if past_room == "suspects" or past_room == "leaving" or past_room == "nap time early":
		current_room = "Jenkins"
		problem_text.text = "As Malcom enters the room to sit down, Jenkins is waiting, a grizzled vet detained. \n Malcom: Suprised to see you here Jenkins, i didn't know you drank \n Jenkins: Same, I Drove away from that old mans body, couldn't have hit em, dont know why you suspect me honestly. you looking for a promotion rookie?"
		option_one_text.text = "Accuse Jenkins "
		option_two_text.text = "Interogate Ralph"	
		
	if past_room == "Jenkins":
		current_room = "Accuse Jenkins"
		problem_text.text = "Malcom slams his fist on the table \n Malcom: you did it! i know you did!, why dont you confess and make this easier for all of us. \n Jenkins: look kid, i know your just looking for your first big catch, but its not always there you know. Malcom stands and walks out of the interogation room, sweat covering his hands"
		option_one_text.text = "???"
		option_two_text.text = "???"
		
	if past_room == "Ralph":
		current_room = "Accuse Ralph"
		problem_text.text = "Malcom slams his fist on the table \n Malcom: you did it! i know you did!, why dont you confess and make this easier for all of us. \n Ralph: Wait, what did i doo? can you saay that agaiiinn? You were so muuch nicer yesterdaaay y'now. Malcom stands and walks out of the interogation room, sweat covering his hands"
		option_one_text.text = "???"
		option_two_text.text = "???"
		
	if past_room == "Accuse Jenkins" or past_room == "Accuse Ralph":
		current_room = "decision"
		problem_text.text = "The File was intresting, the members of the jury had to make a descision on who the murder was, they were tied, and it came down to one person to chose, Bennet had never felt such preassure, but he thought, and finally gave his answer, the Judge returned to the stand where the suspects waited, \n Judge: the members of this jury have come to a descision, the killer of the old man is"
		yield(get_tree().create_timer(1.000001), "timeout")
		let_text_flow = false
		checker = true
		
	if past_room == "view":
		current_room = "watch"
		problem_text.text = "oppsy"
		option_one_text.text = "yip"
		option_two_text.text = "nip"
		
	if past_room == "malcom ending" or past_room == "ralph ending" or past_room == "jenkins ending" or past_room == "worst ending":
		current_room = "start"
		problem_text.text = "Malcom had seldom seen a scene so puzzling \n yet here was one on a silver platter \n an old man, poor, off the gird \n no one even knew his name, but he was killed \n and the killer must be found, Malcom promised.\n and so he must figure out where to start"
		option_one_text.text = "Investigate the body"
		option_two_text.text = "Obtain the footage of his death"

		
	"""
	if past_room == "":
		current_room = ""
		problem_text.text = ""
		option_one_text.text = ""
		option_two_text.text = ""
	"""
		
func _on_option_2_pressed():
	reset()
	click.playing = true
	past_room = current_room

		
	if past_room == "Investigate":
		current_room = "look for weapon"
		problem_text.text = "Malcom scopes the surrounding area, checking behind the dumpster, underneath the trashcan, any where and everywhere in that alleyway \n just as he thought it was a lost cause, he finds a bloodied bat in the last garbage bag he checked"
		option_one_text.text = "Call and report it in"
		option_two_text.text = "Wait for the ambulances to arrive"
		
	if past_room == "look for weapon":
		current_room = "wait for amb"
		problem_text.text = "Malcom has a seat and remains in his car, as he waits he thinks of the night before, he has a pounding headache. \n just then, the ambulance and multiple other police cars arrive to secure the area. \n Malcom lingers long enough to find out an estimate for the time of death, very late last night."
		option_one_text.text = "Head back to the police HQ"
		option_two_text.text = "Go home and take a nap"

	if past_room == "wait for amb":
		current_room = "nap time"
		problem_text.text = "as Malcom heads back to his car, an officer aproaches him with a look of worry \n Officer: uhm, sir, you should know that there was an event yesterday at the bar next door that went out late, i just talked with the owner and he said you were in attendance? Malcom's headache worsened"
		option_one_text.text = "Get in the car"
		option_two_text.text = "Get in the car"

	if past_room == "nap time":
		current_room = "leaving"
		problem_text.text = "Malcom needs not bother himself with this.there's so little time, he must go to the Police HQ to figure out who killed the old man. he waves the cop off and gets in his car, driving off before the officer can get another word out. Malcom arives at HQ to find the suspects waiting to be interogated"
		option_one_text.text = "investigate the first suspect"
		option_two_text.text = "investigate the second suspect"
	
	if past_room == "call it in":
		current_room = "nap time early"
		problem_text.text = "Malcom slaps himself, he needs to focus, he drives to HQ. Malcom walks into the interogation room, to have a talk with the suspects. 2 of suspects have been already exscused, a time of death was identified and alibies were provided \n the remaining two suspects are Jenkins, a felow detective, and Ralph, a chronic drunk"
		option_one_text.text = "Interogate Jenkins First"
		option_two_text.text = "Interogate Ralph First"
		
	if past_room == "list":
		current_room = "nap time early"
		problem_text.text = "Malcom slaps himself, he needs to focus, he drives to HQ. Malcom walks into the interogation room, to have a talk with the suspects. 2 of suspects have been already exscused, a time of death was identified and alibies were provided \n the remaining two suspects are Jenkins, a felow detective, and Ralph, a chronic drunk"
		option_one_text.text = "Interogate Jenkins First"
		option_two_text.text = "Interogate Ralph First"
		
	if past_room == "Suspects" or past_room == "Leaving" or past_room == "nap time early" or past_room == "Jenkins":
		current_room = "Ralph"
		problem_text.text = "As Malcom opens the door, the Drunk everyone's met, Ralph, greets him \n Ralph:Hey dude, what do you whant? \n he was somehow sober, his speech was slurred from so much alcohol intake.\n Ralph: Wait... you kinda look famille- he stopped talking, staring at nothing, Malcom shook him, but he seemed unintrested in talking"
		option_one_text.text = "Accuse Ralph"
		option_two_text.text = "Interogate Jenkins"
		
	if past_room == "Ralph":
		current_room = "Jenkins"
		problem_text.text = "As Malcom enters the room to sit down, Jenkins is waiting, a grizzled vet detained. \n Malcom: Suprised to see you here Jenkins, i didn't know you drank \n Jenkins: Same, I Drove away from that old mans body, couldn't have hit em, dont know why you suspect me honestly. you looking for a promotion rookie?"
		option_one_text.text = "Accuse Jenkins "
		option_two_text.text = "Interogate Ralph"	
		
	if past_room == "Accuse Jenkins" or past_room == "Accuse Ralph":
		current_room = "decision"
		problem_text.text = "The File was intresting, the members of the jury had to make a descision on who the murder was, they were tied, and it came down to one person to chose, Bennet had never felt such preassure, but he thought, and finally gave his answer, the Judge returned to the stand where the suspects waited, \n Judge: the members of this jury have come to a descision, the killer of the old man is"
		yield(get_tree().create_timer(1.000001), "timeout")
		let_text_flow = false
		checker = true
		



func _on_LineEdit_text_entered(new_text):
	click.playing = true
	
	if new_text == "malcom":
		reset()
		current_room = "malcom ending"
		problem_text.text = "It was a suprise, the detecive on the case being the murder? \n but it all lined up, a pounding headache, ommision of the full suspect list, the bloodied bat, a similar model that he was known to own. \n wether it was a drunken fury or simple malice he had killed the old man \n and couldent even remeber it. \n Ending 4 out of 4"
		option_one_text.text = "Try Again"
		option_two_text.text = "quit"
	elif new_text == "ralph":
		reset()
		current_room = "ralph ending"
		problem_text.text = "Ralph the Drunk was convicted,few cared for him and the news brushed it off as a simple murder case, his lack of an alibi and his profusal to cooperate left him as the only sensible suspect remaining, but was he guilty? no, he was not, the real killer is still out there, who could he be? \n Ending 2 out of 4"
		option_one_text.text = "Try Again"
		option_two_text.text = "quit"
	elif new_text == "jenkins":
		reset()
		current_room = "jenkins ending"
		problem_text.text = "Jenkins was respected, his conviction was a suprise to everyone in the county, he had been a beloved community member for so long, no one knew how he could kill the old man, and jenkins fought hard agaisnt what he saw as injustice, but was he guilty? no, he was not, the real killer is still out there, who could he be? \n Ending 3 out of 4"
		option_one_text.text = "Try Again"
		option_two_text.text = "quit"
	else:
		reset()
		current_room = "worst ending"
		problem_text.text = "The Jury was indicisive and could not come to a clean conclusion, the trial was thus pushed back for months, after nearly a year of a dragged out trial, Ralph was convicted guilty and locked up, but was he guilty? no, he was not, the real killer is still out there, who could he be? \n Ending 1 out of 4"
		option_one_text.text = "Try Again"
		option_two_text.text = "quit"


func _on_open_notes_pressed():
	click.playing = true
	if opened == false:
		opened = true
	else:
		opened = false
		

func _on_music_finished():
	music.playing = true
