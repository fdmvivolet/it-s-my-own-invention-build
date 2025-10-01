#macro ZWSP chr(0x200B) 

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
            timer_seconds: 8,	    // Время созревания Ур. 1: 5 минут (60*5)
			required_level: 1,
			sprite: spr_ico_coin,
			levels: {
			    _1: { upgrade_cost: 100, income: 50 },
			    _2: { upgrade_cost: 125, income: 75 },
			    _3: { upgrade_cost: 150, income: 100 },
			    _4: { upgrade_cost: 200, income: 125 },
			    _5: { upgrade_cost: 250, income: 150 },
			    _6: { upgrade_cost: 0, income: 0 },
			    _7: { upgrade_cost: 375, income: 200 },
			    _8: { upgrade_cost: 450, income: 225 },
			    _9: { upgrade_cost: 550, income: 250 },
			    _10: { upgrade_cost: 0, income: 275 }
			    }
        },		
        
        // "Вклад" (Сейф) - стартовый актив
        deposit: {
            name: "Вклад",
            cost: 300,              // Стоимость покупки (1 ур.): 100 монет
            base_income: 150,        // Базовый доход (1 ур.): 10 монет
            timer_seconds: 18,      // Время созревания (1 ур.): 10 минут = 600 секунд
			required_level: 4,
			sprite: spr_ico_dollar,
		    levels: {
			    _1: { upgrade_cost: 300, income: 150 },
			    _2: { upgrade_cost: 350, income: 200 },
			    _3: { upgrade_cost: 400, income: 250 },
			    _4: { upgrade_cost: 500, income: 300 },
			    _5: { upgrade_cost: 600, income: 400 },
			    _6: { upgrade_cost: 0, income: 0 },
			    //_7: { upgrade_cost: 0,	 income: 450 }
		    }			
			
        },
        
        // "Облигация" (Свиток) - продвинутый актив
        bond: {
            name: "Облигация",
            cost: 750,              // Стоимость покупки (1 ур.): 500 монет
            base_income: 350,       // Базовый доход (1 ур.): 120 монет
            timer_seconds: 25,    // Время созревания (1 ур.): 4 часа = 14400 секунд
			required_level: 7,
			sprite: spr_ico_bond,
			levels: {
				_1: { upgrade_cost: 750,	income: 350 },
				_2: { upgrade_cost: 900,	income: 450 },
				_3: { upgrade_cost: 1100,	income: 550 },
				_4: { upgrade_cost: 1350,	income: 650 },
				_5: { upgrade_cost: 1500,	income: 750 },
				_6: { upgrade_cost: 0,		income: 0}
			}			
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
	
	global.game_config.achievements = {
	    collect_income_daily: {
	        type: "ingame",
	        event_name: "BuyAllArea", 
			description: "Застроить все ячейки",
	        target_value: 1,               
	        reward_diamonds: 0
	    },
	    upgrade_assets: {
	        type: "ingame",
	        event_name: "UpgradeAsset10Level",
			description: "Улучшить Актив до Ур.10",
	        target_value: 1,
	        reward_diamonds: 0
	    },
	    open_deposit: {
	        type: "outgame",
	        event_name: "PlayerOpenDeposit", 
			description: "Открыть Вклад",
	        target_value: 1,               
	        reward_diamonds: 5
	    }
    
	};	
	
	global.game_config.bonuses = {
		diamonds:{
			name: "Алмазы",
			description: "Позволяют покупать бонусы",
			cost: "100К",
			reward: 1,
			icon: spr_ico_diamond
		},
		gazprom_discount:{
			name: "Промокод",
			description: "Скидка 15% на 3 заказа в Ленте",
			cost: "5",
			reward: 1,
			icon: spr_ico_gaz
		},
		gazprom_cashback:{
			name: "Кэшбек",
			description: "До 50% кэшбэк в Пятёрочке",
			cost: "10",
			reward: 1,
			icon: spr_ico_gaz
		}
	}

	
	// --- НОВЫЙ РАЗДЕЛ: Сценарии обучения ---
	global.game_config.tutorials = {
    
	FirstAssetPurchase: [ //start dialog done
	    "Привет! Добро пожаловать в \"Уголок благополучия\". Я буду тебе помогать развивать свои финансы!",
	    "Для начала давай попробуем поставить наш игровой \"Накопительный счет\"."
	],
	FirstAssetUpgrade: [ //150 monet (150 - cost update) done
		"Ты быстро развиваешься! Теперь давай я помогу тебе увеличить доход с \"Накопительного счета\"!",
		"Собери доход со своего сейфа и нажми на него еще раз, затем просто реинвестируй в свой счет!"//"ЛЯЛЯЛЯЛЯ", {cta : "savings_account"},
	],
		
    FirstDepositPurchase: [ //done
        "Поздравляю с первым Вкладом! Он надежен и стабилен.",
		{cta : "deposit"},
    ],		

    TasksReminder: [ //5 lvl if player dont know || done
        "Кстати, не забывай заглядывать в \"Задания\"!",
        "Там всегда есть цели с приятными бонусами."
    ],
	
    AchievementsReminder: [ // task to achiev
        "Отлично, первое задание выполнено! Заходи в \"задания\" каждый день, чтобы получать награды",
        "А если хочешь ставить себе цели на долгий срок, заглядывай в \"Достижения\"."
    ],	
	
	FraudCall: [ //fraudcall on 1000+ coins || done
		{ choice: "FraudCall_Step1_Choice" }, 
        "Здравствуйте. Специалист отдела безопасности банка..." + ZWSP,
        { choice: "FraudCall_Step2_Choice" },
        "Нет времени объяснять, ситуация критическая! Чтобы защитить ваши средства, я должен немедленно их перевести на специальный защищенный счет." + ZWSP,
		"Для подтверждения операции мне нужен код, который мы вам только что выслали. Диктуйте!" + ZWSP,
        { choice: "FraudCall_Step3_Choice" }
	],
	
    FraudCallDismissed: [ // НОВЫЙ СЦЕНАРИЙ || done 
        "Возможно это был мошенник... Всегда нужно быть осторожным с незнакомыми звонками!",
    ],	
	
    FraudCallAftermathFail: [ // После "Звонка", если игрок ошибся || done
        "Ох, неприятно... Но ты попался на мошенника. Запомни: НИКОГДА не сообщай НИКОМУ коды безопасности!",
		{cta : "insurance"}
    ],	

    FraudCallAftermathSuccess: [ // После "Звонка", если игрок был прав || done
        "Браво! Ты моментально раскусил мошенника. Твоя бдительность — лучшая защита для твоих средств! Вот тебе небольшой подарок от меня",
		{cta : "insurance"}
    ],		
		

    FirstBondPurchase: [ //done
        "Ты вышел на новый уровень! Облигации — это уже серьезно. Теперь твой капитал будет расти еще быстрее.",
		{cta : "bond"},
    ],
	
    FirstBigIncome: [ //500 monet || done
        "Вот это доход! Ты видишь, как твои первые вложения",
        "начинают приносить серьезные плоды. Так держать!"
    ],
    FirstFieldFull: [ //done
        "Вот это да! Ты заполнил все доступное пространство.",
        "Теперь ты — настоящий управляющий!"
    ],
    FirstMajorUpgrade: [//done
        "Отличная работа! Твой актив достиг 5-го уровня.",
        "Ты мастерски освоил реинвестирование!"
    ]	
		
	};	

	global.game_config.choices = {
		FraudCall_Step1_Choice: {
		        type: "GREEN_RED_CHOICE",
		        title: "Служба Безопасности Банка",
		        options: [
				{ text: "Сбросить.",						action: "FraudCallDismissed" },
				{ text: "Ответить.",						action : "CONTINUE"}
		        ]
		    },
		    FraudCall_Step2_Choice: {
		        type: "DIALOGUE_CHOICE",
				title: "Служба Безопасности Банка",
		        options: [
		            { text: "Что случилось?",				action: "CONTINUE" },
		            { text: "Вы точно из банка?",			action: "CONTINUE" }
		        ]
		    },
		    FraudCall_Step3_Choice: {
		        type: "GREEN_RED_CHOICE",
		        title: "Служба Безопасности Банка",		        
				options: [
		            { text: "Да, код 778-192...",		action: "FraudCallAftermathFail"},
		            { text: "Я кладу трубку...",			action: "FraudCallAftermathSuccess"}
		        ]
		    }		
	}
	
	global.game_config.level_thresholds = [
	    // Чтобы перейти с 0-го уровня (не используется) на 1-й
	    0,      // [0]
	    // Чтобы перейти с 1-го уровня на 2-й, нужно заработать 200
	    150,    // [1]
	    400,    // [2]
	    2000,    // [3]
	    3500,   // [4] -> 5
	    5000,   // [5] -> 6
	    7500,   // [6] -> 7
	    10000,   // [7] -> 8
	    15000,   // [8] -> 9
		99999
		//15000
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
				title: string_upper("Легкое начало!"),
                body: "Ваш игровой \"Накопительный счет\" работает так же, как наш Накопительный счет \"Ежедневный процент\".",
                question: "Хотите узнать больше?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/accounts/daily-percentage/",
				sprite: spr_ico_coin
			},
		
		    deposit: {
                title: "НАДЕЖНЫЕ СБЕРЕЖЕНИЯ!",
                body: "Если вы хотите надежно хранить сбережения, то можете ознакомиться с Вкладом \"Новые деньги\".",
                question: "Хотите узнать больше?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/personal/increase/deposits/detail/7582023/",
				sprite: spr_ico_dollar
            },
            bond: {
                title: "ПРОСТЫЕ ИНВЕСТИЦИИ!",
                body: "Игровая \"Облигация\" - это упрощенная версия реальных ОФЗ, которые можно купить через \"Газпромбанк Инвестиции\".",
                question: "Рассказать подробнее?",
                confirm_text: "Узнать больше",
                decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/personal/page/bond/",
				sprite: spr_ico_bond
            },
			insurance: {
				title: string_upper("Защита от мошенников!"),	
				body: "Ваши реальные карты и счета тоже нуждаются в защите. Подключите страховку и будьте спокойны за свои деньги.",
				question: "",
				confirm_text: "Узнать о защите",
				decline_text: "Не сейчас",
				context_url: "https://www.gazprombank.ru/personal/page/card-protection/",
			}
	}
	
    show_debug_message("CONFIG: Игровой баланс инициализирован.");
	
	

}