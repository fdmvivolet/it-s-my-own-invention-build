/// @description Обработка кликов по кнопкам в UI

// Если никакое окно не открыто, нам нечего делать.
if (current_ui_state == UIState.HIDDEN) {
    exit;
}

// Мы реагируем на НАЖАТИЕ. Так как input_system_process() в game_manager
// уже отключен, это нажатие не будет "простреливать" в мир.
if (device_mouse_check_button_pressed(0, mb_left)) {
    
    var _touch_x = device_mouse_x_to_gui(0);
    var _touch_y = device_mouse_y_to_gui(0);
    
	// --- Логика для Окна МАГАЗИНА ---
	if (current_ui_state == UIState.SHOP_WINDOW) {
	        var _gui_w = display_get_gui_width();
	        var _gui_h = display_get_gui_height();
	        var _win_x = (_gui_w - 800) / 2;
	        var _win_y = (_gui_h - 1000) / 2;

	        // Проверка кнопки "Купить"
	        if (point_in_rectangle(_touch_x, _touch_y, _win_x + 550, _win_y + 250, _win_x + 750, _win_y + 350)) {
	            // Публикуем событие, которое услышит game_manager
	            var _purchase_data = {
	                asset_type: "savings_account",
	                tile_id: current_context_id // Мы сохранили ID ячейки при открытии
	            };
	            EventBusBroadcast("PurchaseAssetRequested", _purchase_data);
            
	            // Закрываем магазин после покупки
	            current_ui_state = UIState.HIDDEN;
	            obj_game_manager.game_state = GameState.GAMEPLAY;
	        }

	        // Проверка кнопки "Закрыть"
	        if (point_in_rectangle(_touch_x, _touch_y, _win_x + 300, _win_y + 850, _win_x + 500, _win_y + 950)) {
	            current_ui_state = UIState.HIDDEN;
	            obj_game_manager.game_state = GameState.GAMEPLAY;
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
                _asset_to_upgrade.perform_upgrade();
            }
        }		
        
        var _btn_close_x = _win_x + _win_width / 2;
        var _btn_close_y = _win_y + 850;
        
        // Проверяем, попал ли клик в область кнопки "Закрыть"
        if (point_in_rectangle(_touch_x, _touch_y, _btn_close_x - 200, _btn_close_y - 50, _btn_close_x + 200, _btn_close_y + 50)) {
            // Закрываем окно
            current_ui_state = UIState.HIDDEN;
            // Возвращаем игру в активное состояние
            obj_game_manager.game_state = GameState.GAMEPLAY;
        }
    }
}