extends Node2D
# Исполнитель ЧЕРЕПАШИЧ by Mikhail Bratus https://www.youtube.com/@GODOTru

@export var enable_speech: bool = true ## разрешить говорилку
@export var SPEED = 75.0 ## скорость движения вперед
@export var TURNING_SPEED = 1.6 ## скорость поворота
signal say_this(text)
enum {GO_FORWARD, JUMP_FORWARD, TURN, JUMP_TO, COLOR}
const colors = {
	"белый" = Color.WHITE,
	"красный" = Color.RED,
	"зеленый" = Color.GREEN,
	"зелёный" = Color.LIME_GREEN,
	"синий" = Color.BLUE,
	"желтый" = Color.YELLOW,
	"жёлтый" = Color.LIGHT_YELLOW,
	"черный" = Color.BLACK,
	"чёрный" = Color.DARK_GRAY,
	"white" = Color.WHITE,
	"red" = Color.RED,
	"green" = Color.GREEN,
	"blue" = Color.BLUE,
	"yellow" = Color.YELLOW,
	"black" = Color.BLACK,
}
var screen_size: Vector2
var curr_angle: float ## желаемый угол поворота
var curr_color
var curr_command
var arr_of_lines = [] ## массив с командами
var length_to_go := 0.0 ## сколько осталось пройти вперед
var voices
var voice_id

func _ready():
	screen_size = get_viewport_rect().size
	length_to_go = 0.0
	skew = 0.0
	curr_angle = rotation
	curr_color = Color.WHITE
	arr_of_lines = []
	curr_command = null
	if enable_speech:
		voices = DisplayServer.tts_get_voices_for_language("ru")
		if voices.size() < 1:
			voices = DisplayServer.tts_get_voices()
		assert(voices)
		voice_id = voices[0]
	
func _process(delta):
	$LabelCommand.rotation = -rotation # чтобы не вращалась с черепахой
	position.x = wrapf(position.x, 0, screen_size.x) # зациклить экран по горизонтали
	position.y = wrapf(position.y, 0, screen_size.y) # зациклить экран по вертикали
	if enable_speech and DisplayServer.tts_is_speaking():
		return
	if curr_command:
		match curr_command.command:
			GO_FORWARD:
				skew = sin(length_to_go/7.0)/10
				#print("- GO FORWARD ", curr_command.length_to_go)
				if length_to_go > 0.0:
					position = position + Vector2.from_angle(rotation) * SPEED * delta
					length_to_go -= SPEED * delta
					if length_to_go < 0.0:
						position = position + Vector2.from_angle(rotation) * length_to_go
						length_to_go = 0.0
						
					var dot = ColorRect.new()
					dot.size = Vector2(3, 3)
					dot.color = curr_color
					dot.position = position
					get_parent().add_child(dot)
					if length_to_go == 0.0:
						curr_command = null
				return
			JUMP_FORWARD:
				skew = 0			
				position = position + Vector2.from_angle(rotation) * length_to_go
				length_to_go = 0.0						
				curr_command = null
				return				
			TURN:
				if rotation < curr_angle:
					rotation += TURNING_SPEED * delta
					if rotation >= curr_angle:
						rotation = curr_angle
						curr_command = null		
				elif rotation > curr_angle:
					rotation -= TURNING_SPEED * delta
					if rotation <= curr_angle:
						rotation = curr_angle
						curr_command = null	
				else:
					curr_command = null
			COLOR, JUMP_TO, JUMP_FORWARD:
				curr_command = null
		return				
	if arr_of_lines.size() < 1:
		return
	curr_command = arr_of_lines[0] # взять следующую команду
	$LabelCommand.add_theme_color_override("font_color", Color.WHITE)
	match curr_command.command:
		GO_FORWARD:
			if typeof(curr_command.length_to_go) == TYPE_FLOAT or typeof(curr_command.length_to_go) == TYPE_INT:
				if curr_command.length_to_go <= 0:
					say_this.emit("Идти вперед можно только на положительное число точек!")
				else:
					say_this.emit("Вперёд " + str(curr_command.length_to_go))
				length_to_go = abs(curr_command.length_to_go)
			else:
				say_this.emit("Параметр функции вперёд может быть только числом!")
		JUMP_FORWARD:
			if typeof(curr_command.length_to_go) == TYPE_FLOAT or typeof(curr_command.length_to_go) == TYPE_INT:
				say_this.emit("Прыгай " + str(curr_command.length_to_go))
				length_to_go = curr_command.length_to_go
			else:
				say_this.emit("Параметр функции вперёд может быть только числом!")
		TURN:
			skew = 0
			if typeof(curr_command.rotation) == TYPE_FLOAT or typeof(curr_command.rotation) == TYPE_INT:
				if curr_command.rotation > 0:
					say_this.emit("Направо " + str(rad_to_deg(curr_command.rotation)))
				else:
					say_this.emit("Налево " + str(abs(rad_to_deg(curr_command.rotation))))
				curr_angle = rotation + curr_command.rotation
			else:
				say_this.emit("Параметр функции поворота может быть только числом!")				
		JUMP_TO:
			skew = 0
			if (typeof(curr_command.x) == TYPE_FLOAT or typeof(curr_command.x) == TYPE_INT) and (typeof(curr_command.y) == TYPE_FLOAT or typeof(curr_command.y) == TYPE_INT):
				say_this.emit("Прыгай " + str(curr_command.x) + " " + str(curr_command.y))
				position.x = curr_command.x
				position.y = curr_command.y
			else:
				say_this.emit("Оба параметра функции прыжка должны быть числами!")
		COLOR:
			skew = 0
			if (curr_command.col in colors or curr_command.col == "случайный"):
				say_this.emit("Цвет " + curr_command.col)
				if curr_command.col in colors:
					curr_color = colors[curr_command.col]
				else:
					curr_color = colors[ colors.keys()[ randi() % colors.size() ] ] 
			else:
				say_this.emit("Параметр функции цвета должен быть строкой и быть из списка разрешенных цветов!")
			$LabelCommand.add_theme_color_override("font_color", curr_color)
	arr_of_lines.remove_at(0)	
	return

func _on_say_this(text):
	$LabelCommand.text = text
	if enable_speech:
		DisplayServer.tts_speak(text, voice_id, 50 , 1, 1.75)

# Все функции нашего Черепашича
## Черепаха идёт вперед на n точек
func go_forward(n):
	print("go_forward(" + str(n) + ")")
	arr_of_lines.append({ command = GO_FORWARD, length_to_go = n })
## Черепаха прыгает вперед на n точек
func jump_forward(n):
	print("jump_forward(" + str(n) + ")")
	arr_of_lines.append({ command = JUMP_FORWARD, length_to_go = n })
## Черепаха поворачивает направо на n градусов
func turn_right(r):
	print("turn_right(" + str(r) + ")")
	arr_of_lines.append({ command = TURN, rotation = deg_to_rad(r) })
## Черепаха поворачивает налево на n градусов	
func turn_left(r):
	print("turn_left(" + str(r) + ")")
	arr_of_lines.append({ command = TURN, rotation = -deg_to_rad(r) })
## Черепаха прыгает на координаты x, y
func jump_to(x, y):
	print("jump_to(" + str(x) + ", " + str(y) + ")")
	arr_of_lines.append({ command = JUMP_TO, x = x, y = y })
## Черепаха выбирает цвет из списка. Можно использовать строку "случайный"
func set_color(col):
	print("set_color(" + col + ")")
	arr_of_lines.append({ command = COLOR, col = col })

###########################################################################

func рисуй_четверть_бутона(лепесток):
	var угол = 30
	go_forward(лепесток)
	jump_forward(-лепесток)
	turn_right(угол)
	go_forward(лепесток)
	jump_forward(-лепесток)
	turn_right(угол)
	go_forward(лепесток)
	jump_forward(-лепесток)
	turn_right(угол)	

func рисуй_бутон(лепесток):
	рисуй_четверть_бутона(лепесток)
	рисуй_четверть_бутона(лепесток)
	рисуй_четверть_бутона(лепесток)
	рисуй_четверть_бутона(лепесток)

func рисуй_стебель_и_листья(рост, листья):
	set_color("зеленый")
	turn_left(90)
	go_forward(рост / 2)
	turn_left(45)
	go_forward(листья)
	jump_forward(-листья)
	turn_right(90)
	go_forward(листья)
	jump_forward(-листья)
	turn_left(45)
	go_forward(рост / 2)

func рисуй_цветок(цвет, рост, лепестки, листья):
	рисуй_стебель_и_листья(рост, листья)
	set_color(цвет)
	рисуй_бутон(лепестки)
	#вернемся на землю и восстановим угол поворота (вправо)
	jump_forward(-рост)
	turn_right(90)
	
func start():
	jump_to(130, 500) #прыг в левый нижний угол поля
	
	рисуй_цветок("красный", 250, 90, 50)	
	jump_forward(200) #отступ между цветами	
	рисуй_цветок("желтый", 200, 50, 20)		
	jump_forward(200) #отступ между цветами
	рисуй_цветок("синий", 120, 20, 30)	

	
	
###########################################################################
