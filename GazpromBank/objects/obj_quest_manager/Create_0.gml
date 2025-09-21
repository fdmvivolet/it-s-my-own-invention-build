show_debug_message("Quest Manager: Инициализация...");



/// @param event_name    Имя произошедшего события (e.g., "IncomeCollected")
/// @param data          Структура с данными, переданными с событием (может быть пустой)
function on_game_event(data) {
    
    // Проверяем, что данные вообще пришли и в них есть event_name
    if (!is_struct(data) || !variable_struct_exists(data, "event_name")) {
        show_debug_message("Quest Manager: Получено событие без имени!");
        return; // Выходим, если данные некорректны
    }
    
    var event_name = data.event_name; // ИЗВЛЕКАЕМ ИМЯ ИЗ ДАННЫХ
	
    show_debug_message("Quest Manager: Получено событие '" + event_name + "'");

    // --- 1. Найти все задания, которые реагируют на это событие ---
    var _all_quest_ids = variable_struct_get_names(global.game_config.quests);
    
    for (var i = 0; i < array_length(_all_quest_ids); i++) {
        var _quest_id = _all_quest_ids[i];
        
        // Получаем "чертеж" задания и его текущий прогресс
        var _quest_config = global.game_config.quests[$ _quest_id];
        var _quest_progress = global.game_data.quest_progress[$ _quest_id];
        
        // --- 2. Проверить, то ли это событие и не выполнено ли задание ---
        // Если имя события совпадает и награда за задание еще не получена
        if (_quest_config.event_name == event_name && !_quest_progress.claimed) {
            
            // Задание найдено, обновляем его прогресс
            show_debug_message("Quest Manager: Обновляется задание '" + _quest_id + "'");

            // --- 3. Обновить прогресс в зависимости от типа задания ---
            
            // Для заданий типа "собери N раз" или "купи N раз" мы просто увеличиваем счетчик.
            // Для заданий "достигни уровня X" логика будет другой.
            
            // Пока реализуем простую инкрементную логику
            _quest_progress.progress++;
            
            // --- 4. Проверить, выполнено ли задание ---
            if (_quest_progress.progress >= _quest_config.target_value) {
                
                // Устанавливаем прогресс точно в целевое значение, чтобы не было "6/5"
                _quest_progress.progress = _quest_config.target_value;
                
                // Если задание еще не было отмечено как выполненное
                if (!_quest_progress.completed) {
                    _quest_progress.completed = true;
                    show_debug_message("Quest Manager: Задание '" + _quest_id + "' ВЫПОЛНЕНО!");
                    
                    // Здесь в будущем можно будет показать игроку уведомление
                }
            }
        }
    }
}


// --- 1. Синхронизация прогресса с конфигом (код без изменений, он корректен) ---
var _all_quest_ids = variable_struct_get_names(global.game_config.quests);

for (var i = 0; i < array_length(_all_quest_ids); i++) {
    var _quest_id = _all_quest_ids[i];
    
    if (!variable_struct_exists(global.game_data.quest_progress, _quest_id)) {
        show_debug_message("Quest Manager: Создана новая запись для задания '" + _quest_id + "'");
        global.game_data.quest_progress[$ _quest_id] = {
            progress: 0,
            completed: false,
            claimed: false
        };
    }
}

// --- 2. Подписка на игровые события (ПЕРЕПИСАННАЯ, ПРАВИЛЬНАЯ ЛОГИКА) ---
// Временный массив, чтобы собрать ВСЕ имена событий, включая дубликаты
var _all_events = [];

// Пробегаемся по всем заданиям, чтобы собрать имена событий
for (var i = 0; i < array_length(_all_quest_ids); i++) {
    var _quest_id = _all_quest_ids[i];
    var _quest_config = global.game_config.quests[$ _quest_id];
    
    array_push(_all_events, _quest_config.event_name);
}

// Теперь убираем дубликаты из массива _all_events
// Для этого используем простую и эффективную технику с промежуточной структурой
var _unique_events_struct = {};
for (var i = 0; i < array_length(_all_events); i++) {
    _unique_events_struct[$ _all_events[i]] = true;
}
// Получаем ключи структуры - это и будут наши уникальные имена событий
var _unique_events = variable_struct_get_names(_unique_events_struct);


// Теперь, когда у нас есть массив уникальных событий, подписываемся на них
for (var i = 0; i < array_length(_unique_events); i++) {
    var _event_name = _unique_events[i];
    
    show_debug_message("Quest Manager: Подписка на событие '" + _event_name + "'");
    
    // Подписываемся на событие, указывая, что при его возникновении
    // нужно вызвать наш метод on_game_event
    EventBusSubscribe(_event_name, id, on_game_event);
}

show_debug_message("Quest Manager: Инициализация завершена.");

// --- obj_quest_manager: User Method "on_game_event" ---

