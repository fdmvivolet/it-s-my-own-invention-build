function draw_quests_window() {
    // --- 1. ОТРИСОВКА ФОНА И ОКНА (без изменений) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
    var _sprite_back_index = spr_big_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	       
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
	draw_set_font(fnt_main_bold)
    draw_text(_gui_w/2, _gui_h/2 - (_win_height / 2 * 0.90), "ЗАДАНИЯ");
	draw_set_font(fnt_main_normal)
    
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2

    var _quest_ids = variable_struct_get_names(global.game_config.quests);
    
	var _sprite_card_index = spr_card_background
	
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale //200 * window_scale; 
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale
	
    // --- 3. ОТРИСОВКА КАЖДОГО ЗАДАНИЯ В ЦИКЛЕ ---
    for (var i = 0; i < array_length(_quest_ids); i++) {
        var _quest_id = _quest_ids[i];
        
        // Получаем данные из конфига и прогресса
        var _config = global.game_config.quests[$ _quest_id];
        var _progress = global.game_data.quest_progress[$ _quest_id];
        
        // Рассчитываем позицию текущей карточки
        var _card_y = _list_start_y + (i * _card_height * 0.65);
        
        
		draw_sprite_ext(_sprite_card_index, -1, _win_x, _card_y, 
		1/2*window_scale, 1/2*window_scale, 0, c_white, 1)
		
        // --- Отрисовка контента карточки ---
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        
        draw_text(_win_x, _card_y - 25, _config.description);
        
        var _progress_text = string(_progress.progress) + " / " + string(_config.target_value);
        
		draw_text(_win_x, _card_y + 35, _progress_text);
        
        // --- Кнопка "Получить" (визуальная часть) ---
		var _sprite_button_index = spr_quest_not_done
		var _sprite_button_width = sprite_get_width(_sprite_button_index) / 2
		var _sprite_button_height = sprite_get_height(_sprite_button_index) / 2
		
        var _button_x = _win_x + _card_width / 4 - _sprite_button_width/2;
        var _button_y = _card_y;
        
		//draw_sprite_ext(_sprite_button_index, -1, _button_x, _button_y, 1/2, 1/2, 0, c_white, 1)
		
    }
	
	for (var i = 0; i < array_length(quests_window_buttons); i++) {
		
		var _button = quests_window_buttons[i];
		
		var _place_x  = _button.x_pos
		var _place_y = _button.y_pos
		
		var _current_scale = _button.current_scale * window_scale;
		
		draw_sprite_ext(_button.sprite_index, -1, _button.x_pos, _button.y_pos, 
		_button.current_scale * 1/2 * window_scale, _button.current_scale * 1/2 * window_scale, 0, c_white, 1)
	}
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

function create_quests_button(){
	obj_ui_manager.quests_window_buttons = [];
	
	var window_scale = obj_ui_manager.window_scale
	    // --- 1. ОТРИСОВКА ФОНА И ОКНА (без изменений) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
    var _sprite_back_index = spr_big_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	       
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2

    var _quest_ids = variable_struct_get_names(global.game_config.quests);
    
	var _sprite_card_index = spr_card_background
	
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale //200 * window_scale; 
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale
	
    // --- 3. ОТРИСОВКА КАЖДОГО ЗАДАНИЯ В ЦИКЛЕ ---
    for (var i = 0; i < array_length(_quest_ids); i++) {
        var _quest_id = _quest_ids[i];
        
        // Получаем данные из конфига и прогресса
        var _config = global.game_config.quests[$ _quest_id];
        var _progress = global.game_data.quest_progress[$ _quest_id];
        
        // Рассчитываем позицию текущей карточки
        var _card_y = _list_start_y + (i * _card_height * 0.65);
        
        // --- Кнопка "Получить" (визуальная часть) ---
		var _sprite_button_index = spr_quest_not_done
		
        if (_progress.claimed) {
           _sprite_button_index = spr_quest_claimed;
        } else if (_progress.completed) {
            _sprite_button_index = spr_quest_not_claimed;
        } else {
            _sprite_button_index = spr_quest_not_done;
        }
		
		var _sprite_button_width = sprite_get_width(_sprite_button_index) / 2
		var _sprite_button_height = sprite_get_height(_sprite_button_index) / 2
		
        var _button_x = _win_x + _card_width / 4 - _sprite_button_width/2;
        var _button_y = _card_y;
        
		//draw_sprite_ext(_sprite_button_index, -1, _button_x, _button_y, 1/2, 1/2, 0, c_white, 1)
		
		var _button_scale_idle = 1.0;
		var _button_scale_hover = 1.0; // Сделаем чуть заметнее
		var _button_scale_pressed = 0.95;		
		
		function create_quest_callback(_quest_id) {
		    return function() {
		        EventBusBroadcast("ClaimQuestRewardRequested", { quest_id: _quest_id });
		    }
		}
		
		
		array_push(obj_ui_manager.quests_window_buttons, {
	        x_pos: _button_x, 
	        y_pos: _button_y, 
	        width: _sprite_button_width,
	        height: _sprite_button_height,
			sprite_index: _sprite_button_index,
	        state: ButtonState.IDLE,
	        callback: method(
				        // 1. Контекст: создаем новую структуру с одним полем 'quest_id'.
				        // Это "заморозит" текущее значение _quest_id.
				        { quest_id: _quest_id }, 
        
				        // 2. Функция: эта функция будет выполнена в контексте структуры выше.
				        // 'self' будет указывать на эту структуру.
				        function() {
				            EventBusBroadcast("ClaimQuestRewardRequested", { quest_id: self.quest_id });
							create_quests_button()
				        }
				    ),
			scale_idle: _button_scale_idle,
			scale_hover: _button_scale_hover,
			scale_pressed: _button_scale_pressed,
			current_scale: _button_scale_idle // Начинаем с обычного размера
	    });
		
    }
	
}

/*
function draw_quests_window() {
    // --- 1. ОТРИСОВКА ФОНА И ОКНА (без изменений) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
    
    var _win_width = 800  * window_scale;
    var _win_height = 1000 * window_scale;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    draw_set_color(c_dkgray);
    draw_rectangle(_win_x , _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_win_x + _win_width / 2, _win_y + 40, "Задания");
    
    // --- 2. ПОДГОТОВКА К ОТРИСОВКЕ СПИСКА ---
    var _quest_ids = variable_struct_get_names(global.game_config.quests);
    var _list_start_y = _win_y + 120 * window_scale; // Начальная позиция Y для первого задания
    var _card_height = 200 * window_scale; // Высота одной "карточки" задания
    
    // --- 3. ОТРИСОВКА КАЖДОГО ЗАДАНИЯ В ЦИКЛЕ ---
    for (var i = 0; i < array_length(_quest_ids); i++) {
        var _quest_id = _quest_ids[i];
        
        // Получаем данные из конфига и прогресса
        var _config = global.game_config.quests[$ _quest_id];
        var _progress = global.game_data.quest_progress[$ _quest_id];
        
        // Рассчитываем позицию текущей карточки
        var _card_y = _list_start_y + (i * _card_height);
        
        // Рисуем фон для карточки (чуть светлее фона окна)
        draw_set_color(c_gray);
        draw_rectangle(_win_x + 20, _card_y, _win_x + _win_width - 20, _card_y + _card_height - 10, false);
        
        // --- Отрисовка контента карточки ---
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        // Описание задания
        draw_text(_win_x + 40, _card_y + 20, _config.description);
        
        // Прогресс в виде текста
        var _progress_text = string(_progress.progress) + " / " + string(_config.target_value);
        draw_set_halign(fa_right);
        draw_text(_win_x + _win_width - 40, _card_y + 20, _progress_text);
        
        // Награда
        // (пока просто текстом, без иконок)
        draw_set_halign(fa_left);
        var _reward_text = "Награда: ";
        if (_config.reward_coins > 0) _reward_text += string(_config.reward_coins) + " монет ";
        if (_config.reward_diamonds > 0) _reward_text += string(_config.reward_diamonds) + " алмазов";
        draw_text(_win_x + 40, _card_y + 70, _reward_text);
        
        // --- Кнопка "Получить" (визуальная часть) ---
        var _button_x = _win_x + _win_width / 2;
        var _button_y = _card_y  + 150 * window_scale;
        var _button_w = 150 * window_scale;
        var _button_h = 40;
        
        var _button_text = "";
        var _button_color = c_red; // Цвет по умолчанию (неактивна)
        
        if (_progress.claimed) {
            _button_text = "Выполнено";
            _button_color = c_dkgray;
        } else if (_progress.completed) {
            _button_text = "Получить!";
            _button_color = c_green; // Активна!
        } else {
            _button_text = "В процессе";
            _button_color = c_red;
        }
        
        draw_set_color(_button_color);
        draw_rectangle(_button_x - _button_w * window_scale , _button_y - _button_h * window_scale, _button_x + _button_w * window_scale, _button_y + _button_h * window_scale, false);
        
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_button_x, _button_y, _button_text);
    }
    
    // (Здесь в будущем будет кнопка "Закрыть")
    
    // --- НОВЫЙ КОД: 3. ОТРИСОВКА КНОПКИ "ЗАКРЫТЬ" ---
    var _btn_close_x = _win_x + _win_width / 2;
    var _btn_close_y = _win_y + 900 * window_scale; // Расположим ее внизу, как в магазине
    
    draw_set_color(c_red);
    draw_rectangle(_btn_close_x - 150 * window_scale, _btn_close_y - 50 * window_scale, _btn_close_x + 150 * window_scale, _btn_close_y + 50 * window_scale, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_btn_close_x, _btn_close_y, "Закрыть");	
	
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}