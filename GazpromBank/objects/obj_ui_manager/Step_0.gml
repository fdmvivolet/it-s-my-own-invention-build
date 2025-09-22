/// @description Обработка кликов по кнопкам в UI


// Если никакое окно не открыто, нам нечего делать.
if (current_ui_state == UIState.TUTORIAL_CLOUD) {
    if (device_mouse_check_button_pressed(0, mb_left)) {
        var _touch_x = device_mouse_x_to_gui(0);
        var _touch_y = device_mouse_y_to_gui(0);
        var radius = 80
        // Рассчитываем координаты облака (они должны совпадать с draw_npc_tooltip)
        var _npc_x = 150;
        var _npc_y = display_get_gui_height() - 350;
	    var _tooltip_x1 = _npc_x + 100;
	    var _tooltip_y1 = _npc_y - (radius + 20); // Верхний край
	    var _tooltip_x2 = display_get_gui_width() - 100;
	    var _tooltip_y2 = _npc_y + radius; // Нижний край, теперь облако центрировано по Y
        
        if (point_in_rectangle(_touch_x, _touch_y, _tooltip_x1, _tooltip_y1, _tooltip_x2, _tooltip_y2)) {
            // Закрываем подсказку
            current_ui_state = UIState.HIDDEN;
            obj_game_manager.game_state = GameState.GAMEPLAY;
            
            // Сообщаем, что UI освободился
            //EventBusBroadcast("UIWindowClosed", {});
			EventBusBroadcast("TooltipAcknowledged", {});
        }
    }
    // Выходим, чтобы не обрабатывать другие окна под подсказкой
    exit;
}

process_tab_bar_input();

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
	            // Закрываем магазин после покупки
	            current_ui_state = UIState.HIDDEN;
	            obj_game_manager.game_state = GameState.GAMEPLAY;
				
				EventBusBroadcast("PurchaseAssetRequested", _purchase_data);
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
	if (current_ui_state == UIState.QUESTS_WINDOW) {
        // Получаем координаты окна, чтобы рассчитать положение кнопки
        var _gui_w = display_get_gui_width();
        var _gui_h = display_get_gui_height();
        var _win_width = 800;
        var _win_height = 1000;
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
                    // Транслируем событие в шину, а не вызываем менеджер напрямую
                    EventBusBroadcast("ClaimQuestRewardRequested", { quest_id: _quest_id });
                    
                    // Выходим из этого блока `if`, чтобы не проверять другие кнопки после успешного клика
                    // и не провалиться в проверку кнопки "Закрыть".
                    exit; 
                }
            }
            _current_y += 150; // Смещаемся вниз для следующего задания
        }		
		
		
        // Координаты кнопки "Закрыть" (должны совпадать с теми, что в draw_quests_window)
        var _btn_close_x = _win_x + _win_width / 2;
        var _btn_close_y = _win_y + 900;
        
        // Проверяем, попал ли клик в область кнопки "Закрыть"
        if (point_in_rectangle(_touch_x, _touch_y, _btn_close_x - 150, _btn_close_y - 50, _btn_close_x + 150, _btn_close_y + 50)) {
            // Закрываем окно
			
            current_ui_state = UIState.HIDDEN;
            // Возвращаем игру в активное состояние
            obj_game_manager.game_state = GameState.GAMEPLAY;
			//trigger_one_time_event("TutorialTriggered", { tutorial_id: "FirstAssetPurchase" });
        }
			
    }
}

