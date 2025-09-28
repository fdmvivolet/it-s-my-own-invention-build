enum GameState {
    LOADING,    // Инициализация и загрузка игры
    GAMEPLAY,   // Основной игровой процесс
    SHOP_OPEN,  // Открыто окно магазина
    PAUSED,     // Пауза (если понадобится)
}

enum EVENT_NAMES{
	SEND_MESSAGE,
	DEACTIVATE_RECIEVER
}

enum UIState {
    HIDDEN,           // Никакие окна не открыты
    SHOP_WINDOW,      // Открыто окно Магазина
    ASSET_WINDOW,     // Открыто окно Актива (для улучшения)
	QUESTS_WINDOW,
	TUTORIAL_CLOUD,
	LEVEL_UP_WINDOW,
	CTA_WINDOW,
	SETTINGS,
	CHOICES_CLOUD,
}

enum ButtonState {
    IDLE,     // Покой
    PRESSED   // Нажата
}