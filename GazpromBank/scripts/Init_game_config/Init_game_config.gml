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
            timer_seconds: 1,	    // Время созревания Ур. 1: 5 минут (60*5)
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
			description: "Достигнуть 3 уровня",
	        target_value: 2,               // Цель - достигнуть 5-го уровня (3 - 1 = 2)
	        reward_coins: 50,
	        reward_diamonds: 0
	    }
    
	};
	
	// --- НОВЫЙ РАЗДЕЛ: Сценарии обучения ---
	global.game_config.tutorials = {
    
	    FirstAssetPurchase: [ // Ключ - это ID нашего сценария
	        "Привет! Добро пожаловать в \"Уголок благополучия\". Я буду тебе помогать развивать свои финансы!",
	        "Для начала давай попробуем поставить наш игровой \"Накопительный счет\"."
	        // В будущем сюда можно будет добавить объекты: { type: "cta_window", ... }
	    ],
		FirstAssetUpgrade: [
			"Ты быстро развиваешься! Теперь давай я помогу тебе увеличить доход с \"Накопительного счета\"!",
			"Для этого тебе собрать доход с сейфа, затем нажать по нему еще раз и \"реинвестировать\"."
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
	    10000,   // [8] -> 9
		15000
	];	
	
	
	global.game_config.rewards_per_level = {
	    // Ключи теперь - осмысленные строки.
	    level_2: { 
	        unlock_message: "Разблокирована новая ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },
	    level_3: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },		
	    level_4: { 
	        unlock_message: "Разблокирован новый актив: Вклад!",
	        unlocks: [{ type: "asset", id: "savings_account" }]
	    },
	    level_5: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },
	    level_6: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },	
	    level_7: {
	        unlock_message: "Разблокирован новый актив: Облигация!",
	        unlocks: [{ type: "asset", id: "bond" }]
	    },
	    level_8: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },
	    level_9: {
	        unlock_message: "Разблокирована еще одна ячейка!",
	        unlocks: [{ type: "tile", count: 1 }]
	    },			
	};
	
	global.game_config.cta_windows = {
			
			savings_account: {
				title: string_upper("Хорошее начало!"),
                body: "Ваш игровой 'Накопительный счет' работает так же, как наш Накопительный счет 'Ежедневный процент'.",
                question: "Хотите узнать больше?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/accounts/daily-percentage/"
			},
		
		    deposit: {
                title: "Отлично!",
                body: "Ваш игровой 'Вклад' работает так же, как наш Накопительный счет 'Ежедневный процент'.",
                question: "Хотите узнать больше?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/personal/increase/deposits/detail/7582023/"
            },
            bond: {
                title: "Шаг вперед!",
                body: "Игровая 'Облигация' - это упрощенная версия реальных ОФЗ, которые можно купить через 'Газпромбанк Инвестиции'.",
                question: "Рассказать подробнее?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/personal/page/bond/"
            }
	}
	
    show_debug_message("CONFIG: Игровой баланс инициализирован.");
	
	

}