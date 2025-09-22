enum GameState {
    LOADING,    // Инициализация и загрузка игры
    GAMEPLAY,   // Основной игровой процесс
    SHOP_OPEN,  // Открыто окно магазина
    PAUSED,     // Пауза (если понадобится)
	//TUTORIAL
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
	TUTORIAL_CLOUD
}

enum ButtonState {
    IDLE,     // Покой
    HOVER,    // Наведение
    PRESSED   // Нажата
}