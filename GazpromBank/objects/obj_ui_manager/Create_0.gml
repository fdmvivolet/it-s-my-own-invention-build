// --- obj_ui_manager: Create Event (ИСПРАВЛЕННАЯ ВЕРСЯ) ---
/// @description Инициализация UI менеджера, состояний и подписок на события.

// --- 1. Переменные состояния UI ---
current_ui_state = UIState.HIDDEN;
current_context_id = noone;

tab_bar_buttons = [];
quests_window_buttons = [];

tooltip_message_to_show = "";


hud_coins_target_x = 0;
hud_coins_target_y = 0;

function create_tab_bar_buttons(array){
	array = []

	var _gui_width = display_get_gui_width();
	var _gui_height = display_get_gui_height();

	// --- Настройки геометрии (из вашего кода) ---
	var _button_size = 96;
	var _bar_render_height = 256; 

	// --- Данные кнопок ---
	var _button_data = [
	    { id: "farm",         label: "Ферма",       color: c_green,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
	    { id: "shop",         label: "Магазин",     color: c_aqua,		callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
	    { id: "quests",       label: "Задания",     color: c_yellow,	callback: function() { EventBusBroadcast("RequestQuestsWindow", {});	   } },
	    { id: "achievements", label: "Достижения",  color: c_fuchsia,	callback: function() { show_debug_message("Нажата кнопка: " + self.label); } },
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
	    var _place_x = _gui_width * ((i + 1) * (1 / 6));
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

alarm[0] = 1