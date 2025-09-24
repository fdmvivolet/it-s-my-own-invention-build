// --- Script: init_game_config ---

/// @function init_game_config()
/// @description Инициализирует глобальную структуру с настройками игрового баланса.
function init_game_config() {
    
    // Создаем главную структуру для хранения всех настроек
    global.game_config = {};
    
    // --- НАСТРОЙКИ ИГРОВЫХ АКТИВОВ ---
    // Здесь мы описываем параметры для каждого типа актива,
    // основываясь на Геймдизайн-документе (Часть 3.2).
    
    global.game_config.assets = {
		
		
        // Стартовый актив: Накопительный счет
        savings_account: {
            name: "Накопительный счет",
            cost: 100,              // Стоимость покупки Ур. 1
            base_income: 50,        // Базовый доход Ур. 1
            timer_seconds: 5,	    // Время созревания Ур. 1: 5 минут (60*5)
			required_level: 1
        },		
        
        // "Вклад" (Сейф) - стартовый актив
        deposit: {
            name: "Вклад",
            cost: 100,              // Стоимость покупки (1 ур.): 100 монет
            base_income: 10,        // Базовый доход (1 ур.): 10 монет
            timer_seconds: 600,      // Время созревания (1 ур.): 10 минут = 600 секунд
			required_level: 4
        },
        
        // "Облигация" (Свиток) - продвинутый актив
        bond: {
            name: "Облигация",
            cost: 500,              // Стоимость покупки (1 ур.): 500 монет
            base_income: 120,       // Базовый доход (1 ур.): 120 монет
            timer_seconds: 14400,    // Время созревания (1 ур.): 4 часа = 14400 секунд
			required_level: 7,
        }
        
        // В будущем, для добавления "Акции", мы просто добавим сюда новый блок:
        // stock: { ... }
    };
    
    // --- НАСТРОЙКИ ПРОГРЕССИИ ИГРОКА ---
    // (Пока можно оставить пустым, но структура уже будет готова)
    global.game_config.player_progression = {
        // Здесь будут кривые опыта, награды за уровни и т.д.
    };
    
	// В вашем скрипте, где инициализируется global.game_config

	// --- Конфигурация Заданий ---
	global.game_config.quests = {
    
	    // Задание 1: Сбор дохода (ежедневное)
	    collect_income_daily: {
	        type: "daily",
	        event_name: "IncomeCollected", // Название события в EventBus
			description: "Собрать доход",
	        target_value: 5,               // Цель
	        reward_coins: 150,
	        reward_diamonds: 0
	    },
    
	    // Задание 2: Покупка актива (ежедневное)
	    buy_asset_daily: {
	        type: "daily",
	        event_name: "AssetPurchased",
			description: "Купить 1 актив",
	        target_value: 1,
	        reward_coins: 50,
	        reward_diamonds: 0
	    },
    
	    // Задание 3: Достижение уровня (еженедельное, с премиальной наградой)
	    reach_level_weekly: {
	        type: "weekly",
	        event_name: "PlayerLeveledUp", // Будем отслеживать, когда игрок повышает уровень
			description: "Достигнуть 5 уровня",
	        target_value: 5,               // Цель - достигнуть 5-го уровня
	        reward_coins: 0,
	        reward_diamonds: 1
	    }
    
	};
	
	// --- НОВЫЙ РАЗДЕЛ: Сценарии обучения ---
	global.game_config.tutorials = {
    
	    FirstAssetPurchase: [ // Ключ - это ID нашего сценария
	        "Отлично! Вы разместили свой первый 'Вклад'. Теперь он работает на вас!",
	        "Кстати, не забывайте заходить в игру, чтобы собрать доход, когда он созреет."
	        // В будущем сюда можно будет добавить объекты: { type: "cta_window", ... }
	    ]
	};	
	
	global.game_config.level_thresholds = [
	    // Чтобы перейти с 0-го уровня (не используется) на 1-й
	    0,      // [0]
	    // Чтобы перейти с 1-го уровня на 2-й, нужно заработать 200
	    100,    // [1]
	    400,    // [2]
	    800,    // [3]
	    1500,   // [4] -> 5
	    2600,   // [5] -> 6
	    4200,   // [6] -> 7
	    6800,   // [7] -> 8
	    10000   // [8] -> 9
	];	
	
	
	global.game_config.rewards_per_level = {
	    // Ключи теперь - осмысленные строки.
    
	    level_2: { 
	        unlock_message: "Разблокирована новая ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },
	    level_3: { 
	        unlock_message: "Разблокирован новый актив: Вклад!",
	        unlocks: [{ type: "asset", id: "savings_account" }]
	    },
	    level_4: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },
	    level_7: {
	        unlock_message: "Разблокирован новый актив: Облигация!",
	        unlocks: [{ type: "asset", id: "bond" }]
	    }
	};
	
    show_debug_message("CONFIG: Игровой баланс инициализирован.");
}