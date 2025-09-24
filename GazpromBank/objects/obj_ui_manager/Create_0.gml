// --- obj_ui_manager: Create Event (ИСПРАВЛЕННАЯ ВЕРСЯ) ---
/// @description Инициализация UI менеджера, состояний и подписок на события.
#macro WINDOW_CLOSE_ANIMATION	global.Animation.play(obj_ui_manager, "window_scale", 0.95, 0.1, ac_onetozerocubic, function() { current_ui_state = UIState.HIDDEN; obj_game_manager.game_state = GameState.GAMEPLAY; obj_sound_manager.play_sfx("ui_click_low"); obj_ui_manager.window_scale = 0.8; })
#macro TUTORIAL_CLOSE_ANIMATION	global.Animation.play(obj_ui_manager, "window_scale", 1, 0.2, ac_close_tutorial, function() { current_ui_state = UIState.HIDDEN; obj_game_manager.game_state = GameState.GAMEPLAY; obj_sound_manager.play_sfx("ui_click_low"); obj_ui_manager.window_scale = 1; EventBusBroadcast("TooltipAcknowledged", {}); })
// --- 1. Переменные состояния UI ---
current_ui_state = UIState.HIDDEN;
current_context_id = noone;

tab_bar_buttons = [];
settings_button = [];
quests_window_buttons = [];

tooltip_message_to_show = "";

window_scale = 0.8; // Текущий масштаб окна (от 0.0 до 1.0)
window_alpha = 1; // Текущая прозрачность окна (от 0.0 до 1.0)

hud_coins_target_x = 0;
hud_coins_target_y = 0;

function create_tab_bar_buttons(){

	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();

	// --- Настройки геометрии (из вашего кода) ---
	var _button_size = 96;
	var _bar_render_height = 256; 

	// --- Данные кнопок ---
	/*var _button_data = [
	    { id: "home",         label: "Дом",       color: c_green,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
	    { id: "shop",         label: "Магазин",     color: c_aqua,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
	    { id: "quests",       label: "Задания",     color: c_yellow,	callback: function() { EventBusBroadcast("RequestQuestsWindow", {});	   } },
	    { id: "achievements", label: "Достижения",  color: c_fuchsia,	callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
	    { id: "help",         label: "Подсказка",   color: c_silver,	callback: function() { show_debug_message("Нажата кнопка: " + self.label); } }
	];*/

	var _button_data = [
	    { id: "shop",         label: "Магазин",     color: c_aqua,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
		{ id: "achievements", label: "Достижения",  color: c_fuchsia,	callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
		{ id: "home",         label: "Дом",       color: c_green,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
		{ id: "quests",       label: "Задания",     color: c_yellow,	callback: function() { EventBusBroadcast("RequestQuestsWindow", {});	   } }, 
		{ id: "help",         label: "Подсказка",   color: c_silver,	callback: function() { show_debug_message("Нажата кнопка: " + self.label); } }
	];

	var _button_count = array_length(_button_data);

	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; // Сделаем чуть заметнее
	var _button_scale_pressed = 0.9;

	// --- Создаем кнопки в цикле, используя ВАШУ логику расчета координат ---
	for (var i = 0; i < _button_count; i++) {
	    var _data = _button_data[i];
    
	    // Вычисляем X и Y точно как в вашем примере:
		//var _place_x = _gui_width * ((i + 1) * (1 / 6) * (3 / (i + 1)));
	    var _place_x = _gui_width * ((i + 1) * (1 / 6));
		
		var _center = _gui_width * 1/2
		
		if i == 2 {_place_x = _center}
	
		else if i < 2 {_place_x = _center * ((i + 1) * (1 / 3))}
		else {_place_x = (_center * (i + 1) * (1 / 3));}
	    
		var _place_y = _gui_height - (_bar_render_height / 2);
    
	    array_push(tab_bar_buttons, {
	        id: _data.id,
	        label: _data.label,
	        x_pos: _place_x, // ПРАВИЛЬНЫЙ X
	        y_pos: _place_y, // ПРАВИЛЬНЫЙ Y
	        width: _button_size,
	        height: _button_size,
	        color: _data.color,
	        state: ButtonState.IDLE,
	        callback: _data.callback,
			scale_idle: _button_scale_idle,
			scale_hover: _button_scale_hover,
			scale_pressed: _button_scale_pressed,
			current_scale: _button_scale_idle // Начинаем с обычного размера
	    });
	
		//show_debug_message(_data.label + " " + string(_place_x) + " " + string(_place_y))
	}
}

function create_settings_button(){
	
	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();
	var _bar_render_height = 250 + 100;
	var _gap_x = 75
	var _gap_y = 25
	
	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; // Сделаем чуть заметнее
	var _button_scale_pressed = 0.9;	
	
	var _callback = function () {show_debug_message(show_debug_message("Нажата кнопка: Настройки"))} 
	
	array_push(settings_button, {
	    id: "settings",
	    label: "Настройки",

		
	    width: sprite_get_width(spr_ico_settings),
	    height: sprite_get_height(spr_ico_settings),
		
	    x_pos: _gui_width  - sprite_get_width(spr_ico_settings)/2, // ПРАВИЛЬНЫЙ X
	    y_pos: _bar_render_height  - sprite_get_height(spr_ico_settings)/2, // ПРАВИЛЬНЫЙ Y		
		
	    state: ButtonState.IDLE,
	    callback: _callback,
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});	
	
}

alarm[0] = 1