/// @function draw_asset_window()
/// @description Отрисовывает модальное окно с информацией об активе.
function draw_asset_window() {
    
    // --- 1. ПОЛУЧАЕМ ДАННЫЕ ---
    // current_context_id хранит ID актива, для которого открыто окно.
    var _asset_id = obj_ui_manager.current_context_id;
    //var _asset_config = global.game_config.assets[$ _asset_id];
	//show_message(_asset_id)
    // Проверка на случай, если актив был удален, пока окно открыто
    if (!instance_exists(_asset_id)) {
        // Просто закрываем окно
        obj_ui_manager.current_ui_state = UIState.HIDDEN; //НИХУА НЕ РАБОТЕТ :(
        obj_game_manager.game_state = GameState.GAMEPLAY;
        return;
    }
    
    // Считываем все нужные данные с актива
    var _asset_name = _asset_id.name//object_get_name(_asset_id.object_index); // Покажет "obj_savings_account"
    var _asset_level = _asset_id.level;
    var _asset_income = _asset_id.base_income;
    var _time_left = ceil(_asset_id.timer_current);
	var _upgrade_cost = _asset_id.upgrade_cost;
	
    // --- 2. ОТРИСОВКА ФОНА И ОКНА ---
    // Получаем размеры UI-холста
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2
    
    // --- 3. ОТРИСОВКА ТЕКСТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Название (убираем "obj_" для красоты)
	draw_set_font(fnt_main_bold)
    draw_text(_win_x, _win_y - _win_height / 2 * 0.8, string_upper(_asset_name));
    draw_set_font(fnt_main_normal_big)
	
	//var coin_per_hour = 60 / _asset_config.timer_seconds * _asset_config.base_income * 60
    // Информация
	_time_left = _time_left == -1 ? " готов!" : _time_left
	
	var coin_per_hour = int64(60 / _asset_id.base_timer_seconds * _asset_id.base_income * 60)
	
	
	
    draw_text(_win_x, _win_y - _win_height / 2 * 0.3, "Уровень: " + string(_asset_level));
    draw_text(_win_x, _win_y - _win_height / 2 * 0.1,  "Доход за один сбор: " + string(_asset_income));
    draw_text(_win_x, _win_y + _win_height / 2 * 0.1,  "Доход в час: " + string(coin_per_hour));
	
	var _sec = _time_left == " готов!" ? "" : " сек."
	
	draw_text(_win_x, _win_y + _win_height / 2 * 0.3, "Готов через: " + string(_time_left) + _sec);
    

	
	var _can_afford = global.game_data.player_coins >= _upgrade_cost;
	
	var _sprite_ind = _can_afford ? spr_accept_cta : spr_no_accept_cta // Тернарный оператор для выбора цвета

	var _scale = 1
	if asset_button != [] {
	_sprite_ind = asset_button[0].sprite_index
	_win_x = asset_button[0].x_pos
	_win_y = asset_button[0].y_pos
	_scale = asset_button[0].current_scale
	}

	draw_sprite_ext(_sprite_ind, -1, _win_x, _win_y, 1/2*_scale, 1/2*_scale, 0, c_white, 1)
	draw_set_font(fnt_main_bold)
	draw_set_color(c_black);
	draw_text(_win_x, _win_y, "Реинвестировать (" + string(_upgrade_cost) + ")");
    draw_set_font(fnt_main_normal_big)
    
    // Сбрасываем выравнивание
    draw_set_halign(fa_left);
}

function create_asset_button() {
	
	obj_ui_manager.asset_button = []
	
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * obj_ui_manager.window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * obj_ui_manager.window_scale;
	
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2
	
	if !instance_exists(obj_ui_manager.current_context_id) {exit}
	
	var _upgrade_cost = obj_ui_manager.current_context_id.upgrade_cost;
	var _can_afford = global.game_data.player_coins >= _upgrade_cost;
	var _sprite_ind = _can_afford ? spr_accept_cta : spr_no_accept_cta // Тернарный оператор для выбора цвета

	draw_sprite_ext(_sprite_ind, -1, _win_x, _win_y + _win_height / 2 * 0.65, 1/2, 1/2, 0, c_white, 1)
	
	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; // Сделаем чуть заметнее
	var _button_scale_pressed = 0.95;		
	
    // Получаем ID актива, для которого открыто окно
    var _asset_to_upgrade = obj_ui_manager.current_context_id;	
	
	array_push(obj_ui_manager.asset_button, {
	    x_pos: _win_x, 
	    y_pos: _win_y + _win_height / 2 * 0.65, 
		sprite_index: _sprite_ind,
	    state: ButtonState.IDLE,
	    callback: method(
				    // 1. Контекст: создаем новую структуру с одним полем 'quest_id'.
				    // Это "заморозит" текущее значение _quest_id.
				    { asset_to_upgrade: _asset_to_upgrade }, 
        
				    // 2. Функция: эта функция будет выполнена в контексте структуры выше.
				    // 'self' будет указывать на эту структуру.
				    function() {
						    if (instance_exists(asset_to_upgrade)) {
						        asset_to_upgrade.perform_upgrade();
						    }	
				    }
				),
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});	

    
}

/*
/// @function draw_asset_window()
/// @description Отрисовывает модальное окно с информацией об активе.
function draw_asset_window() {
    
    // --- 1. ПОЛУЧАЕМ ДАННЫЕ ---
    // current_context_id хранит ID актива, для которого открыто окно.
    var _asset_id = obj_ui_manager.current_context_id;
    
	
    // Проверка на случай, если актив был удален, пока окно открыто
    if (!instance_exists(_asset_id)) {
        // Просто закрываем окно
        obj_ui_manager.current_ui_state = UIState.HIDDEN; //НИХУА НЕ РАБОТЕТ :(
        obj_game_manager.game_state = GameState.GAMEPLAY;
        return;
    }
    
    // Считываем все нужные данные с актива
    var _asset_name = object_get_name(_asset_id.object_index); // Покажет "obj_savings_account"
    var _asset_level = _asset_id.level;
    var _asset_income = _asset_id.base_income;
    var _time_left = ceil(_asset_id.timer_current);
	var _upgrade_cost = _asset_id.upgrade_cost;
	
    // --- 2. ОТРИСОВКА ФОНА И ОКНА ---
    // Получаем размеры UI-холста
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Рисуем сам фон окна (пока что простой серый прямоугольник)
    var _win_width = 800 * window_scale;
    var _win_height = 1000 * window_scale;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    draw_set_color(c_dkgray);
    draw_rectangle(_win_x, _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    // --- 3. ОТРИСОВКА ТЕКСТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Название (убираем "obj_" для красоты)
    draw_text(_win_x + _win_width / 2, _win_y + 100, string_replace(_asset_name, "obj_", ""));
    
    // Информация
    draw_text(_win_x + _win_width / 2, _win_y + 300, "Уровень: " + string(_asset_level));
    draw_text(_win_x + _win_width / 2, _win_y + 400, "Доход: " + string(_asset_income));
    draw_text(_win_x + _win_width / 2, _win_y + 500, "Готов через: " + string(_time_left) + " сек.");
    
    // --- 4. ОТРИСОВКА КНОПОК (ПОКА ЗАГЛУШКИ) ---
    // Кнопка "Улучшить"
    var _btn_upgrade_x = _win_x + _win_width / 2;
    var _btn_upgrade_y = _win_y + 700 * window_scale;
	
	var _can_afford = global.game_data.player_coins >= _upgrade_cost;
	draw_set_color(_can_afford ? c_green : c_gray); // Тернарный оператор для выбора цвета

	draw_rectangle(_btn_upgrade_x - 200 * window_scale, _btn_upgrade_y - 50, _btn_upgrade_x + 200 * window_scale, _btn_upgrade_y + 50, false);
	draw_set_color(c_white);
	draw_text(_btn_upgrade_x, _btn_upgrade_y, "Реинвестировать (" + string(_upgrade_cost) + ")");
    
    // Кнопка "Закрыть"
    var _btn_close_x = _win_x + _win_width / 2;
    var _btn_close_y = _win_y + 850 * window_scale;
    draw_set_color(c_red);
    draw_rectangle(_btn_close_x - 200 * window_scale, _btn_close_y - 50 * window_scale, _btn_close_x + 200 * window_scale, _btn_close_y + 50 * window_scale, false);
    draw_set_color(c_white);
    draw_text(_btn_close_x, _btn_close_y, "Закрыть");
    
    // Сбрасываем выравнивание
    draw_set_halign(fa_left);
}




/*
function draw_shop_window() {

    
    // Фон окна
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _win_width = 800 * window_scale;
    var _win_height = 1000 * window_scale;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
	
    // --- 2. ОТРИСОВКА КОНТЕНТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
	
	
	draw_set_alpha(1.0 * window_alpha)
    // Заголовок
    draw_text(_win_x + _win_width / 2, _win_y + 100, "Магазин");
    
	
    // Кнопка "Закрыть" (временно внизу)
    draw_set_color(c_red);
    draw_rectangle(_win_x + _win_width/2 - 100 * window_scale, _win_y + 850 * window_scale, _win_x + _win_width/2 + 100 * window_scale, _win_y + 950 * window_scale, false);
    draw_set_color(c_white);
    draw_text(_win_x + _win_width/2 , _win_y + 900 * window_scale, "Закрыть");
	
	
    /////////////////////////////////////////////////////////////////////////
    var _asset_ids = variable_struct_get_names(global.game_config.assets);
    var _current_y = _win_y + 250; // Начальная Y позиция для первого товара
    var _item_gap = 150; // Расстояние между товарами
    
    for (var i = 0; i < array_length(_asset_ids); i++) {
        var _asset_id = _asset_ids[i];
        var _asset_config = global.game_config.assets[$ _asset_id];
        
        // --- Рисуем название товара ---
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(_win_x + 50, _current_y, _asset_config.name);
        
        // --- Проверяем, доступен ли товар по уровню ---
        var _is_unlocked = (global.game_data.player_level >= _asset_config.required_level);
        
        // --- Рисуем кнопку "Купить" / "Заблокировано" ---
        var _btn_x = _win_x + 650 * window_scale;
        var _btn_y = _current_y;
        
        if (_is_unlocked) {
            // Товар доступен
            draw_set_color(c_green);
            draw_rectangle(_btn_x - 100, _btn_y - 50, _btn_x + 100, _btn_y + 50, false);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, "Купить (" + string(_asset_config.cost) + ")");
        } else {
            // Товар заблокирован
            draw_set_color(c_red);
            draw_rectangle(_btn_x - 100, _btn_y - 50, _btn_x + 100, _btn_y + 50, false);
            draw_set_color(c_ltgray);
            draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, "С Ур. " + string(_asset_config.required_level));
        }
        
        // Смещаемся вниз для следующего товара
        _current_y += _item_gap;
    }	
	/////////////////////////////////////////////////////////////////////////
	
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);	
	draw_set_alpha(1.0);
	
	
}

