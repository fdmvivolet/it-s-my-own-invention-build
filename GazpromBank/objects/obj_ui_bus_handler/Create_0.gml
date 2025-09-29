/// @description Слушает UI-запросы и отложенно передает их UI-менеджеру.
#macro WINDOW_OPEN_ANIMATION obj_ui_manager.window_scale = 0.8; global.Animation.play(obj_ui_manager, "window_scale", 1.0, 0.2, ac_open_window) obj_sound_manager.play_sfx("ui_click_high") //0.2 sec
#macro TUTORIAL_OPEN_ANIMATION obj_ui_manager.window_scale = 0.8;   global.Animation.play(obj_ui_manager, "window_scale", 1.0, 0.4, ac_open_window, function () {obj_ui_manager.is_skippable = true}) //0.2 sec
#macro DELETE_TUTORIAL_ORDER array_delete(obj_ui_bus_handler.tutorial_queue, 0 , array_length(obj_ui_bus_handler.tutorial_queue)); obj_ui_manager.current_ui_state = UIState.HIDDEN
// --- 2. ОБЪЯВЛЕНИЕ функций-обработчиков событий (Callbacks) ---
// Мы должны сначала объявить функции, и только потом их использовать.

//var ui_id = obj_ui_manager.id

message_queue = [];
tutorial_queue = [];


function on_request_shop_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Магазина для ячейки " + string(_event_data.tile_id));
	
	
	//obj_ui_manager.current_ui_state = UIState.HIDDEN;
	//obj_game_manager.game_state = GameState.GAMEPLAY;	
	//TUTORIAL_OPEN_ANIMATION
	WINDOW_OPEN_ANIMATION
	with(obj_ui_manager){
		alarm[1] = 1	
	}
    //global.Animation.play(obj_ui_manager, "window_scale", 1.0, 0.2, ac_open_window);
    //global.Animation.play(obj_ui_manager, "window_alpha", 1.0, 1, ac_ease_out);	
	
	obj_ui_manager.current_ui_state = UIState.SHOP_WINDOW;
    obj_ui_manager.current_context_id = _event_data.tile_id;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_asset_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Актива для " + string(_event_data.asset_id));
	

    

    obj_ui_manager.current_context_id = _event_data.asset_id;
	
	create_asset_button()
	WINDOW_OPEN_ANIMATION	
	
	obj_ui_manager.current_ui_state = UIState.ASSET_WINDOW;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_bonuses_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Магазина Бонусов")
	create_bonuses_buttons()
	WINDOW_OPEN_ANIMATION	
	obj_ui_manager.current_ui_state = UIState.BONUSES_WINDOW;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_achievements_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Достижений")
	WINDOW_OPEN_ANIMATION	
	obj_ui_manager.current_ui_state = UIState.ACHIEVEMENTS_WINDOW;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_knowledge_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Базы Знаний")
	WINDOW_OPEN_ANIMATION	
	obj_ui_manager.current_ui_state = UIState.KNOWLEDGE_WINDOW;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}
// В obj_ui_manager, где объявлены другие методы-обработчики

function on_request_quests_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Заданий");
	create_quests_button()
	WINDOW_OPEN_ANIMATION
	
    // Переключаем состояния, как и для других окон
	obj_quest_manager.quest_window_visited = true
    obj_ui_manager.current_ui_state = UIState.QUESTS_WINDOW;
    obj_ui_manager.current_context_id = noone; // Контекст не нужен
    obj_game_manager.game_state = GameState.SHOP_OPEN; // Или SHOP_OPEN, как вам удобнее
}

function on_request_settings_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Настроек");
	create_settings_buttons()
	WINDOW_OPEN_ANIMATION
	
    // Переключаем состояния, как и для других окон
    obj_ui_manager.current_ui_state = UIState.SETTINGS;
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
        
		
		if is_struct(_next_step_message){
			
			if variable_struct_exists(_next_step_message, "cta"){
				show_debug_message("UI Bus Handler: Запуск CTA")
				obj_ui_manager.current_ui_state = UIState.HIDDEN; 
				obj_game_manager.game_state = GameState.GAMEPLAY; 
				obj_ui_manager.window_alpha = 0
				obj_ui_manager.window_scale = 0.8
				obj_ui_manager.is_skippable = false			
				on_show_cta_requested({ asset_key: _next_step_message.cta})
				//EventBusBroadcast("ShowCTARequested", { asset_key: });
				exit
			}
			if variable_struct_exists(_next_step_message, "choice"){
				//obj_ui_manager.current_ui_state = UIState.HIDDEN; 
				//obj_game_manager.game_state = GameState.GAMEPLAY; 
				//obj_ui_manager.window_alpha = 0
				//obj_ui_manager.window_scale = 0.8
				obj_ui_manager.is_skippable = false	
				
				show_choices_requested({ asset_key : _next_step_message.choice})
				show_debug_message("UI Bus Handler: Запуск выбора ответов");	
				exit
				
			}else{show_debug_message("UI Bus Handler: Неизвестная структура")}
		}
		
		show_debug_message("UI Bus Handler: Показ шага обучения: '" + _next_step_message + "'");
        
		
		
		array_delete(obj_ui_manager.tooltip_array_to_show, 0, array_length(obj_ui_manager.tooltip_array_to_show))
			
        obj_ui_manager.current_ui_state = UIState.TUTORIAL_CLOUD;
        
		draw_set_font(fnt_main_bold_cloud)
		_next_step_message = string_wrap(_next_step_message, sprite_get_width(spr_text_background)/4 + 300)
		draw_set_font(fnt_main_normal)
		
		obj_ui_manager.tooltip_message_to_show = _next_step_message;
		
		for (var i = 1; i <= string_length(_next_step_message); i++) {
		    // Получаем символ на текущей позиции `i`
		    var _char = string_char_at(_next_step_message, i);
    
		    // Добавляем этот символ в конец нашего массива
		    array_push(obj_ui_manager.tooltip_array_to_show, _char);
		}		
		
		obj_ui_manager.tooltip_array_size = 0
		
		var _array_size = array_length(obj_ui_manager.tooltip_array_to_show)
		var _total_duration = _array_size/30
		
		
	    global.Animation.play(
	        obj_ui_manager.id,                         // Цель: этот самый экземпляр контроллера
	        "tooltip_array_size",       // Анимируемая переменная
	        _array_size,                // Конечное значение
	        _total_duration,            // Длительность
	        ac_linear,                  // Кривая анимации
	        function() {
	            show_debug_message("Dialogue Controller: Анимация текста завершена.");
	        },
	    );		       
		obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир	
    }else
	{
		obj_ui_manager.current_ui_state = UIState.HIDDEN; 
		obj_game_manager.game_state = GameState.GAMEPLAY; 
		obj_ui_manager.window_alpha = 0
		obj_ui_manager.window_scale = 0.8
		obj_ui_manager.is_skippable = false
		//show_debug_message(obj_ui_manager.current_ui_state)
	}
}

// МЕТОД №2: Метод-триггер, который ЗАПУСКАЕТ целый сценарий
function on_tutorial_triggered(data) {
    var _tutorial_id = data.tutorial_id;
    
	var bus_id = obj_ui_bus_handler.id
	
    // Проверяем, есть ли такой сценарий в конфиге
    if (variable_struct_exists(global.game_config.tutorials, _tutorial_id)) {
        
        // Копируем ВЕСЬ массив реплик из конфига в нашу внутреннюю очередь
		//if audio_group_is_loaded(sfx_group) {obj_sound_manager.play_sfx("purchase");} 
		obj_sound_manager.play_sfx("open_tutorial")
		TUTORIAL_OPEN_ANIMATION
		
		//obj_ui_manager.window_scale = 1
		//global.Animation.play(obj_ui_manager, "window_alpha", 1.0, 2, ac_open_window)
        //bus_id.tutorial_queue = array_clone(global.game_config.tutorials[$ _tutorial_id]);
		var _source_array = global.game_config.tutorials[$ _tutorial_id];
		//bus_id.tutorial_queue = _source_array
		array_copy(bus_id.tutorial_queue, 0, _source_array, 0, array_length(_source_array));
		show_debug_message("UI Bus Handler: Загружен сценарий '" + _tutorial_id + "' с " + string(array_length(bus_id.tutorial_queue)) + " шагами.");
        

		//global.Animation.play(obj_ui_manager, "window_alpha", 1, 1, ac_linear, function() {obj_ui_bus_handler.show_next_tutorial_step()})
		//obj_ui_manager.window_scale = 1
		//obj_ui_manager.window_alpha = 0				
		//global.Animation.play(obj_ui_manager, "window_alpha", 1, 1, ac_linear)			
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
        show_debug_message("UI Bus Handler: UI занят, показ окна Level Up отложен (не-а).");
		obj_ui_manager.current_ui_state = UIState.HIDDEN
        //return; 
    }
	obj_ui_manager.window_scale = 0.8; 
	global.Animation.play(obj_ui_manager, "window_scale", 1.0, 0.2, ac_open_window) 
	obj_sound_manager.play_sfx("level_up")
    //WINDOW_OPEN_ANIMATION
    // Отдаем команду UI Manager'у
    obj_ui_manager.current_context_id = data; // Сохраняем все данные (уровень и анлоки)
    obj_ui_manager.current_ui_state = UIState.LEVEL_UP_WINDOW;
	create_level_up_button()
    obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир
}

/// @description Обрабатывает запрос на показ CTA-окна. Вызывается по подписке EventBus.
/// @param {struct} data Пакет данных, отправленный с событием. Ожидаем { asset_key: "..." }.
function on_show_cta_requested(data) {
    // ШАГ 1: ПРОВЕРКА БЕЗОПАСНОСТИ
    // Это самая важная часть. Мы должны убедиться, что UI сейчас свободен.
    // CTA имеет низкий приоритет. Если на экране уже есть магазин или окно улучшения,
    // мы не должны показывать поверх еще одно окно, чтобы не раздражать игрока.
	obj_ui_manager.current_ui_state = UIState.HIDDEN
    if (obj_ui_manager.current_ui_state != UIState.HIDDEN) {
        // Выводим сообщение в консоль, чтобы понимать, почему окно не появилось.
        show_debug_message("UI занят (текущее состояние: " + string(obj_ui_manager.current_ui_state) + "). Запрос CTA проигнорирован.");
        return; // Немедленно выходим из функции. Ничего не делаем.
    }

    // ШАГ 2: ПОЛУЧЕНИЕ ДАННЫХ
    // Извлекаем ключ ассета (например, "deposit") из полученных данных.
    var _asset_key = data.asset_key;

    // На всякий случай проверяем, что для этого ключа есть тексты в конфиге.
    if (!variable_struct_exists(global.game_config.cta_windows, _asset_key)) {
        show_debug_message("ОШИБКА: Попытка показать CTA для '" + _asset_key + "', но для него нет записи в global.game_config.cta_windows.");
        return;
    }
    
    // Получаем всю структуру с текстами (title, body, question и т.д.) из нашего конфига.
    var _cta_content = global.game_config.cta_windows[$ _asset_key];

    // ШАГ 3: ПЕРЕДАЧА КОМАНД
    // Мы убедились, что все безопасно и все данные на месте. Теперь отдаем приказы.
	obj_ui_manager.current_context_data = _cta_content;
	create_cta_buttons()
	WINDOW_OPEN_ANIMATION
    // 1. Передаем все тексты в o_ui_manager. Он будет использовать их для отрисовки.
    
	//obj_ui_manager.current_context_url = _cta_content.context_url

    // 2. Даем команду o_ui_manager'у переключить свое состояние на отрисовку нашего нового окна.
    // (Пока что это вызовет ошибку, т.к. мы еще не добавили CTA_WINDOW в enum, сделаем это на след. шаге)
    obj_ui_manager.current_ui_state = UIState.CTA_WINDOW;

    // 3. Даем команду o_game_manager'у заблокировать игровой мир.
    // Состояние SHOP_OPEN идеально подходит, так как оно уже блокирует клики по ассетам и ячейкам.
    obj_game_manager.game_state = GameState.SHOP_OPEN;

    // Отладочное сообщение
    show_debug_message("Команды на показ CTA для '" + _asset_key + "' успешно переданы.");
}

/// @description Обрабатывает запрос на показ Облака Выборов-окна. Вызывается по подписке EventBus.
/// @param {struct} data Пакет данных, отправленный с событием. Ожидаем { asset_key: "..." }.
function show_choices_requested(data) {	
	show_debug_message(data)
	obj_ui_manager.current_ui_state = UIState.HIDDEN
    if (obj_ui_manager.current_ui_state != UIState.HIDDEN) {
        show_debug_message("UI занят (текущее состояние: " + string(obj_ui_manager.current_ui_state) + "). Запрос Облака Выборов проигнорирован.");
        return; 
    }
    var _asset_key = data.asset_key;
    if (!variable_struct_exists(global.game_config.choices, _asset_key)) {
        show_debug_message("ОШИБКА: Попытка показать Облака Выборов для '" + _asset_key + "', но для него нет записи в global.game_config.choices.");
        return;
    }
    var _choices_content = global.game_config.choices[$ _asset_key];	
	obj_ui_manager.current_context_data = _choices_content;	
	//create_cta_buttons()
	create_choices_buttons()
	obj_ui_manager.current_ui_state = UIState.CHOICES_CLOUD;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
    show_debug_message("Команды на показ Облака Выборов для '" + _asset_key + "' успешно переданы.");
}

EventBusSubscribe("RequestShopWindow", id, on_request_shop_window);
EventBusSubscribe("RequestAssetWindow", id, on_request_asset_window);
EventBusSubscribe("RequestQuestsWindow", id, on_request_quests_window);
EventBusSubscribe("RequestSettingsWindow", id, on_request_settings_window);
EventBusSubscribe("RequestBonusesWindow", id, on_request_bonuses_window);
EventBusSubscribe("RequestAchievementsWindow", id, on_request_achievements_window);
EventBusSubscribe("RequestKnowledgeWindow", id, on_request_knowledge_window);

EventBusSubscribe("PlayerLeveledUp", id, on_player_leveled_up);


var tutorials = struct_get_names(global.game_config.tutorials)
for (var i = 0; i < array_length(tutorials); i++)
{
	var _name = tutorials[i]
	EventBusSubscribe(_name, id, on_tutorial_triggered);	
}





EventBusSubscribe("TooltipAcknowledged", id, on_tooltip_acknowledged);

EventBusSubscribe("ShowCTARequested", id, on_show_cta_requested);

show_debug_message("UI Bus Handler: Подписка на триггеры обучения...");

//EventBusSubscribe("TutorialTriggered", id, on_tutorial_triggered);
//EventBusSubscribe("FirstAssetUpgrade", id, on_tutorial_triggered);
//EventBusSubscribe("FraudCall", id, on_tutorial_triggered);
//EventBusSubscribe("FraudCallAftermathSuccess", id, on_tutorial_triggered);
//EventBusSubscribe("FraudCallAftermathFail", id, on_tutorial_triggered);
//EventBusSubscribe("FraudCallDismissed", id, on_tutorial_triggered)

