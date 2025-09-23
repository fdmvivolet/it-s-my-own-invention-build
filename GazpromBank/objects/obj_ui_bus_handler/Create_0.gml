/// @description Слушает UI-запросы и отложенно передает их UI-менеджеру.

// --- 2. ОБЪЯВЛЕНИЕ функций-обработчиков событий (Callbacks) ---
// Мы должны сначала объявить функции, и только потом их использовать.

//var ui_id = obj_ui_manager.id

message_queue = [];
tutorial_queue = [];


function on_request_shop_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Магазина для ячейки " + string(_event_data.tile_id));
	obj_ui_manager.current_ui_state = UIState.SHOP_WINDOW;
    obj_ui_manager.current_context_id = _event_data.tile_id;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_asset_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Актива для " + string(_event_data.asset_id));
    obj_ui_manager.current_ui_state = UIState.ASSET_WINDOW;
    obj_ui_manager.current_context_id = _event_data.asset_id;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

// В obj_ui_manager, где объявлены другие методы-обработчики

function on_request_quests_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Заданий");

    // Переключаем состояния, как и для других окон
    obj_ui_manager.current_ui_state = UIState.QUESTS_WINDOW;
    obj_ui_manager.current_context_id = noone; // Контекст не нужен
    obj_game_manager.game_state = GameState.SHOP_OPEN; // Или SHOP_OPEN, как вам удобнее
}

// МЕТОД №1: Главный метод, который ПОКАЗЫВАЕТ СЛЕДУЮЩИЙ ШАГ
function show_next_tutorial_step() {
	var bus_id = obj_ui_bus_handler.id
    // Проверяем два условия: есть ли что-то в очереди И свободен ли UI
    if (array_length(bus_id.tutorial_queue) > 0 && obj_ui_manager.current_ui_state == UIState.HIDDEN) {
        
        // Берем следующий шаг (самую первую реплику) из очереди
        var _next_step_message = bus_id.tutorial_queue[0];
        array_delete(bus_id.tutorial_queue, 0, 1); // И сразу удаляем ее из очереди
        
        show_debug_message("UI Bus Handler: Показ шага обучения: '" + _next_step_message + "'");
        
        // Отдаем команду UI Manager'у
        obj_ui_manager.current_ui_state = UIState.TUTORIAL_CLOUD;
        obj_ui_manager.tooltip_message_to_show = _next_step_message;
        obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир
    }
}

// МЕТОД №2: Метод-триггер, который ЗАПУСКАЕТ целый сценарий
function on_tutorial_triggered(data) {
    var _tutorial_id = data.tutorial_id;
    
	var bus_id = obj_ui_bus_handler.id
	
    // Проверяем, есть ли такой сценарий в конфиге
    if (variable_struct_exists(global.game_config.tutorials, _tutorial_id)) {
        
        // Копируем ВЕСЬ массив реплик из конфига в нашу внутреннюю очередь

        //bus_id.tutorial_queue = array_clone(global.game_config.tutorials[$ _tutorial_id]);
		var _source_array = global.game_config.tutorials[$ _tutorial_id];
		//bus_id.tutorial_queue = _source_array
		array_copy(bus_id.tutorial_queue, 0, _source_array, 0, array_length(_source_array));
		show_debug_message("UI Bus Handler: Загружен сценарий '" + _tutorial_id + "' с " + string(array_length(bus_id.tutorial_queue)) + " шагами.");
        
        // Сразу же пытаемся показать ПЕРВЫЙ шаг
        bus_id.show_next_tutorial_step();
    }
}

// МЕТОД №3: Метод, который срабатывает, когда игрок закрывает одно облачко
function on_tooltip_acknowledged(data) {
    show_debug_message("UI Bus Handler: Шаг обучения подтвержден. Попытка показать следующий.");
    // Просто пытаемся показать СЛЕДУЮЩИЙ шаг из очереди
    obj_ui_bus_handler.show_next_tutorial_step();
}


function on_player_leveled_up(data) {
    show_debug_message("UI Bus Handler: Получено событие PlayerLeveledUp. Новый уровень: " + string(data.new_level));
    
    // Проверяем, свободен ли UI. Если нет, ждем, пока закроются другие окна.
    // (Логика очереди здесь не нужна, т.к. level up - важное событие,
    // которое должно прервать все, но для консистентности лучше проверить).
    if (obj_ui_manager.current_ui_state != UIState.HIDDEN) {
        // В идеале, левел ап не должен происходить, пока открыты окна,
        // но эта проверка - хорошая защита. Пока просто выйдем.
        show_debug_message("UI Bus Handler: UI занят, показ окна Level Up отложен (пока проигнорирован).");
        return; 
    }
    
    // Отдаем команду UI Manager'у
    obj_ui_manager.current_context_id = data; // Сохраняем все данные (уровень и анлоки)
    obj_ui_manager.current_ui_state = UIState.LEVEL_UP_WINDOW;
    obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир
}


EventBusSubscribe("RequestShopWindow", id, on_request_shop_window);
EventBusSubscribe("RequestAssetWindow", id, on_request_asset_window);
EventBusSubscribe("RequestQuestsWindow", id, on_request_quests_window);

EventBusSubscribe("PlayerLeveledUp", id, on_player_leveled_up);
EventBusSubscribe("TutorialTriggered", id, on_tutorial_triggered);
EventBusSubscribe("TooltipAcknowledged", id, on_tooltip_acknowledged);

show_debug_message("UI Bus Handler: Подписка на триггеры обучения...");

