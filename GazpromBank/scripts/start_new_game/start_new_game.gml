// --- Script: persistence_system.gml ---

// Определяем имя нашего файла сохранения в одном месте для удобства
#macro SAVE_FILENAME "capital_farm.sav"

/// @function start_new_game()
/// @description Устанавливает начальные данные для новой игры.
function start_new_game() {
    show_debug_message("SYSTEM: Сохранение не найдено. Создание новой игры.");
    
    global.game_data = {
        player_level: 1,
        total_earnings: 0, //вместо xp
        player_coins: 125,
		unlocked_tile_count: 1,
        last_save_timestamp: 0,
        // Создаем пустой массив для хранения данных об активах на 10 ячейках
        assets_on_tiles: array_create(10, noone), 
        achievements_unlocked: [],
		quest_progress: {}, // Просто создаем пустую структуру (struct)
		triggered_one_time_events: [] 
    };
}


/// @function save_game()
/// @description Сохраняет глобальную структуру данных через буфер.
function save_game() {
    if (!variable_global_exists("game_data")) {
        show_debug_message("ОШИБКА: Попытка сохранить игру до инициализации global.game_data.");
        return;
    }

    // 1. СИНХРОНИЗАЦИЯ: Собираем актуальные данные из игрового мира в global.game_data
    save_world_to_data();

    // 2. Обновляем временную метку
	global.game_data.last_save_timestamp = date_current_datetime();
    
    // 3. Конвертируем все наши данные в строку JSON
    var _json_string = json_stringify(global.game_data);
    
    // 4. Записываем JSON-строку в буфер
    var _buffer = buffer_create(string_byte_length(_json_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _json_string);
    
    // 5. Сохраняем буфер. В HTML5 это автоматически сохранится в localStorage
    buffer_save(_buffer, SAVE_FILENAME);
    
    // 6. Очищаем память, удаляя буфер
    buffer_delete(_buffer);
    
    show_debug_message("ИГРА СОХРАНЕННА с использованием буфера.");
}


/// @function load_game()
/// @description Загружает данные через буфер или начинает новую игру.
function load_game() {
    // 1. Проверяем, существует ли файл сохранения.
    if (!file_exists(SAVE_FILENAME)) {
        start_new_game(); // Если нет - начинаем новую игру
        return;
    }
    
    // 2. Загружаем файл в буфер
    var _buffer = buffer_load(SAVE_FILENAME);
    
    // 3. Читаем из буфера сохраненную JSON-строку
    var _json_string = buffer_read(_buffer, buffer_string);
    
    // 4. Очищаем память
    buffer_delete(_buffer);
    
    // 5. Парсим JSON-строку обратно в нашу глобальную структуру
    global.game_data = json_parse(_json_string);
    
    show_debug_message("ИГРА ЗАГРУЖЕНА с использованием буфера.");
}