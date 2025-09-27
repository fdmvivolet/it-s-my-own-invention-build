/// @description Обработка кликов по кнопкам в UI


// Если никакое окно не открыто, нам нечего делать.
if (current_ui_state == UIState.TUTORIAL_CLOUD) {
	
    if (device_mouse_check_button_pressed(0, mb_left)) {

		
		var _text_string = string_join_ext("", tooltip_array_to_show, 0, tooltip_array_size)
		
		
		
		if _text_string != tooltip_message_to_show //&& is_skippable
		{
			if is_skippable{
			array_delete(obj_animation_manager.active_tweens, 0, array_length(obj_animation_manager.active_tweens)) //какая-то проблемная хуйня!!!
			tooltip_array_size = array_length(tooltip_array_to_show)
			}
		}else
		{
			
			tooltip_array_size = 0
			tooltip_array_to_show = []
			TUTORIAL_CLOSE_ANIMATION
		}

    }
    exit;
}

//var _clicked_on_tab_bar = process_buttons_input(tab_bar_buttons);
//var _clicked_on_settings = process_buttons_input(settings_button);

if (current_ui_state == UIState.HIDDEN) {
	var _clicked_on_tab_bar = process_buttons_input(tab_bar_buttons);
	var _clicked_on_settings = process_buttons_input(settings_button);	
    exit;
}

switch(current_ui_state)
{
	case UIState.QUESTS_WINDOW:
		var _clicked_on_quit = process_buttons_input(quit_button);
		if !_clicked_on_quit {create_quit_button("big")}
		
		var _clicked_on_quest = process_buttons_input(quests_window_buttons);
		if !_clicked_on_quest {create_quests_button()}
		exit
		break;
		
	case UIState.SHOP_WINDOW:
		
		_clicked_on_quit = process_buttons_input(quit_button);
		if !_clicked_on_quit {create_quit_button("big")}	
		
		var _clicked_on_shop = process_buttons_input(shop_buttons);
		if !_clicked_on_shop {create_shop_buttons()}		
	
		break;
		
	case UIState.ASSET_WINDOW:
	
		_clicked_on_quit = process_buttons_input(quit_button);
		if !_clicked_on_quit {create_quit_button("small")}	
		
		var _clicked_on_asset = process_buttons_input(asset_button)
		if !_clicked_on_asset {create_asset_button()}
		
		break;
		
	case UIState.SETTINGS:
		_clicked_on_quit = process_buttons_input(quit_button);
		if !_clicked_on_quit {create_quit_button("small")}	
		
		_clicked_on_settings = process_buttons_input(settings_buttons)
		if !_clicked_on_settings {create_settings_buttons()}
		
		break;
		
	case UIState.LEVEL_UP_WINDOW:	
		_clicked_on_quit = process_buttons_input(lvl_up_buttons);
		if !_clicked_on_quit {create_level_up_button()}
		break;
		
	case UIState.CTA_WINDOW:
	
		var _clicked_on_cta = process_buttons_input(cta_buttons);
		if !_clicked_on_cta {create_cta_buttons()}	
		break;
}

















/*
// Мы реагируем на НАЖАТИЕ. Так как input_system_process() в game_manager
// уже отключен, это нажатие не будет "простреливать" в мир.
if (device_mouse_check_button_pressed(0, mb_left)) {
    
    var _touch_x = device_mouse_x_to_gui(0);
    var _touch_y = device_mouse_y_to_gui(0);
    /*
	// --- Логика для Окна МАГАЗИНА ---
	if (current_ui_state == UIState.SHOP_WINDOW) {
	        var _gui_w = display_get_gui_width();
	        var _gui_h = display_get_gui_height();
	        var _win_x = (_gui_w - 800) / 2;
	        var _win_y = (_gui_h - 1000) / 2;

        // --- НОВАЯ ЛОГИКА ПРОВЕРКИ КНОПОК "КУПИТЬ" В ЦИКЛЕ ---
        var _asset_ids = variable_struct_get_names(global.game_config.assets);
        var _current_y = _win_y + 250;
        var _item_gap = 150;
        
        for (var i = 0; i < array_length(_asset_ids); i++) {
            var _asset_id = _asset_ids[i];
            var _asset_config = global.game_config.assets[$ _asset_id];
            
            // Проверяем, что товар РАЗБЛОКИРОВАН, прежде чем проверять клик
            if (global.game_data.player_level >= _asset_config.required_level) {
                
                var _btn_x = _win_x + 650;
                var _btn_y = _current_y;
                
                if (point_in_rectangle(_touch_x, _touch_y, _btn_x - 100, _btn_y - 50, _btn_x + 100, _btn_y + 50)) {
                    // Все проверки пройдены, отправляем запрос
                    var _purchase_data = {
                        asset_type: _asset_id, // Используем динамический ID
                        tile_id: current_context_id
                    };

                    
                    // Закрываем магазин и выходим из цикла/события
                    current_ui_state = UIState.HIDDEN;
                    obj_game_manager.game_state = GameState.GAMEPLAY;
					EventBusBroadcast("PurchaseAssetRequested", _purchase_data);
                    
					exit;
                }
            }
            
            _current_y += _item_gap; // Смещаемся к следующей кнопке
        }

	    // Проверка кнопки "Закрыть"
	    if (point_in_rectangle(_touch_x, _touch_y, _win_x + 300, _win_y + 850, _win_x + 500, _win_y + 950)) {
			WINDOW_CLOSE_ANIMATION/*
			global.Animation.play(obj_ui_manager, "window_scale", 0.95, 0.1, ac_onetozerocubic, function() {
					current_ui_state = UIState.HIDDEN;
			        obj_game_manager.game_state = GameState.GAMEPLAY;
					obj_sound_manager.play_sfx("ui_click_low");
					obj_ui_manager.window_scale = 0.8;
			});
			
	    }
	}	
	
    // --- Логика для Окна Актива ---
    if (current_ui_state == UIState.ASSET_WINDOW) {
        
        // Координаты кнопки "Закрыть"
        var _gui_w = display_get_gui_width();
        var _gui_h = display_get_gui_height();
        var _win_width = 800;
        var _win_height = 1000;
        var _win_x = (_gui_w - _win_width) / 2;
        var _win_y = (_gui_h - _win_height) / 2;
		
        var _btn_upgrade_x = _win_x + 800 / 2;
        var _btn_upgrade_y = _win_y + 700;
        
        // --- НОВАЯ ПРОВЕРКА КНОПКИ "УЛУЧШИТЬ" ---
        if (point_in_rectangle(_touch_x, _touch_y, _btn_upgrade_x - 200, _btn_upgrade_y - 50, _btn_upgrade_x + 200, _btn_upgrade_y + 50)) {
            
            // Получаем ID актива, для которого открыто окно
            var _asset_to_upgrade = current_context_id;
            
            // Проверяем, что он все еще существует
            if (instance_exists(_asset_to_upgrade)) {
                // Вызываем его собственную функцию улучшения
                //_asset_to_upgrade.perform_upgrade();
            }
        }		
        
        var _btn_close_x = _win_x + _win_width / 2;
        var _btn_close_y = _win_y + 850;
        
        // Проверяем, попал ли клик в область кнопки "Закрыть"
        if (point_in_rectangle(_touch_x, _touch_y, _btn_close_x - 200, _btn_close_y - 50, _btn_close_x + 200, _btn_close_y + 50)) {
            //WINDOW_CLOSE_ANIMATION
			//current_ui_state = UIState.HIDDEN;
            //obj_game_manager.game_state = GameState.GAMEPLAY;
			//obj_sound_manager.play_sfx("ui_click_low");
        }
    }
	if (current_ui_state == UIState.QUESTS_WINDOW) {
		
        // Получаем координаты окна, чтобы рассчитать положение кнопки
        var _gui_w = display_get_gui_width();
        var _gui_h = display_get_gui_height();
	    var _win_width = _gui_w* 0.9;
	    var _win_height = _gui_h * 0.6;
	    var _win_x = (_gui_w - _win_width) / 2;
	    var _win_y = (_gui_h - _win_height) / 2;
        
		
        // --- 1. Проверка кнопок "Получить" ---
        var _all_quest_ids = variable_struct_get_names(global.game_config.quests);
        var _current_y = 250; // Начальная Y позиция для первого задания
    
	    var _list_start_y = _win_y + 120; // Начальная позиция Y для первого задания
		var _card_height = 200; // Высота одной "карточки" задания        
	
        for (var i = 0; i < array_length(_all_quest_ids); i++) {
            var _quest_id = _all_quest_ids[i];
            var _quest_progress = global.game_data.quest_progress[$ _quest_id];
            
            // Проверяем клик только для активных кнопок
            if (_quest_progress.completed && !_quest_progress.claimed) {
				var _card_y = _list_start_y + (i * _card_height);
                var _btn_claim_x = _win_x + _win_width / 2;
                var _btn_claim_y = _card_y + 140;
                
                if (point_in_rectangle(_touch_x, _touch_y, _btn_claim_x - 100, _btn_claim_y - 40, _btn_claim_x + 100, _btn_claim_y + 40)) {
                    //EventBusBroadcast("ClaimQuestRewardRequested", { quest_id: _quest_id });
                    exit; 
                }
            }
            _current_y += 150; 
        }		
		
		
        // Координаты кнопки "Закрыть" (должны совпадать с теми, что в draw_quests_window)
        var _btn_close_x = _win_x + _win_width / 2;
        var _btn_close_y = _win_y + 900;
        
        // Проверяем, попал ли клик в область кнопки "Закрыть"
        if (point_in_rectangle(_touch_x, _touch_y, _btn_close_x - 150, _btn_close_y - 50, _btn_close_x + 150, _btn_close_y + 50)) {
            //WINDOW_CLOSE_ANIMATION
			// Закрываем окно
            //current_ui_state = UIState.HIDDEN;
            //obj_game_manager.game_state = GameState.GAMEPLAY;
			//obj_sound_manager.play_sfx("ui_click_low");
        }
			
    }
	
	// --- НОВЫЙ БЛОК: Логика для Окна Повышения Уровня ---
    if (current_ui_state == UIState.LEVEL_UP_WINDOW) {
        var _gui_w = display_get_gui_width();
        var _gui_h = display_get_gui_height();
        var _win_width = 800;
        var _win_height = 600;
        var _win_x = (_gui_w - _win_width) / 2;
        var _win_y = (_gui_h - _win_height) / 2;
        
        // Координаты кнопки "Продолжить"
        var _btn_x = _win_x + _win_width / 2;
        var _btn_y = _win_y + _win_height - 80;
        
        // Проверяем клик по кнопке
        if (point_in_rectangle(_touch_x, _touch_y, _btn_x - 150, _btn_y - 40, _btn_x + 150, _btn_y + 40)) {
            // Стандартная процедура закрытия
			WINDOW_CLOSE_ANIMATION
            //current_ui_state = UIState.HIDDEN;
            //obj_game_manager.game_state = GameState.GAMEPLAY;
			//obj_sound_manager.play_sfx("ui_click_low");
         
        }
    }	

}

