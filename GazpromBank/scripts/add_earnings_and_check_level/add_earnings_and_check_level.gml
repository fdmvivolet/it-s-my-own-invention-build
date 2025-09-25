// --- ОБНОВЛЕННЫЙ МЕТОД: Управление доходом, уровнями и наградами ---

/// @function           add_earnings_and_check_level(amount)
/// @param {real}       amount  Количество заработанных монет.
function add_earnings_and_check_level(amount) {
    
    if (amount <= 0) return;
    
    show_debug_message("Game Manager: Начислено " + string(amount) + " монет.");
    
    // --- 1. Начисляем доход ---
    global.game_data.player_coins += amount;
    global.game_data.total_earnings += amount;
    
    
    // --- 2. Проверяем повышение уровня (в цикле) ---
    var _leveled_up = false;
    var _original_level = global.game_data.player_level; // Запоминаем стартовый уровень
    
    while (true) {
        var _current_level = global.game_data.player_level;
        var _thresholds = global.game_config.level_thresholds;
        
		
        if (_current_level >= array_length(_thresholds) - 1) {
            
			break; // Достигнут максимальный уровень
        }
        
        var _xp_needed = _thresholds[_current_level];
        
        if (global.game_data.total_earnings >= _xp_needed) {
			
			var tile_max_num = 9
			global.game_data.unlocked_tile_count++;
			global.game_data.unlocked_tile_count = clamp(global.game_data.unlocked_tile_count, 1, tile_max_num) // для хакатона огран
			
            global.game_data.player_level++;
            _leveled_up = true;
            show_debug_message("Game Manager: УРОВЕНЬ ПОВЫШЕН! Новый уровень: " + string(global.game_data.player_level));
        } else {
            break; // Опыта не хватает, выходим
        }
    }
    
    
    // --- 3. Если уровень был повышен, собираем награды и отправляем событие ---
    if (_leveled_up) {
        
        // --- НОВЫЙ БЛОК: СБОР СПИСКА НАГРАД ---
        var _all_unlock_messages = []; // Массив, куда мы соберем все сообщения о наградах
        
        // Пробегаемся по всем уровням, которые игрок ТОЛЬКО ЧТО получил
        // (от старого+1 до нового включительно)
        for (var lvl = _original_level + 1; lvl <= global.game_data.player_level; lvl++) {
            var _level_key = "level_" + string(lvl); // Ключ в конфиге - это строка
            
            // Проверяем, есть ли вообще награда за этот уровень в нашем "справочнике"
            if (variable_struct_exists(global.game_config.rewards_per_level, _level_key)) {
                
                var _reward_info = global.game_config.rewards_per_level[$ _level_key];
                // Добавляем красивое сообщение о разблокировке в наш список
                array_push(_all_unlock_messages, _reward_info.unlock_message);
            }
        }
        
        // --- ОБНОВЛЕННАЯ СТРУКТУРА СОБЫТИЯ ---
        // Теперь мы передаем не только новый уровень, но и список наград
        var _event_data = {
            new_level: global.game_data.player_level,
            unlocks: _all_unlock_messages,
			event_name: "PlayerLeveledUp"
        };
        EventBusBroadcast("PlayerLeveledUp", _event_data);
    }
}
