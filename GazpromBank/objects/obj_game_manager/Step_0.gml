switch (game_state) {
    case GameState.GAMEPLAY:
        input_system_process();
        break;
    case GameState.SHOP_OPEN:
        // Мир заморожен для ввода
		//show_debug_message("ahahahahha")
        break;
}


// os_is_paused() вернет true, если игра СВЕРНУТА, поэтому мы инвертируем (!).
var _is_currently_focused = !os_is_paused();

// 2. Сравниваем текущее состояние с состоянием из прошлого кадра.
// Если в прошлом кадре игра БЫЛА активна, а в этом перестала...
if (was_focused == true && _is_currently_focused == false) {
    // ...это означает, что игра ТОЛЬКО ЧТО потеряла фокус.
    // Это идеальный момент для сохранения!
    show_debug_message("Application lost focus. Saving game...");
    save_game();
}

// 3. Обновляем состояние для следующего кадра.
// Это КРАЙНЕ ВАЖНО, чтобы сохранение не происходило каждый кадр,
// пока игра свернута.
was_focused = _is_currently_focused;