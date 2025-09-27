/// @description Инициализация переменных состояния диалога.
/// Этот объект является синглтоном (создается один раз).
/*
show_debug_message("Dialogue Controller: Инициализация синглтона...");

// --- Переменные состояния текста ---
words_array = [];
full_text_wrapped = "";
visible_word_index = 0;
is_skipped = false;

// --- НОВЫЕ ПЕРЕМЕННЫЕ СОСТОЯНИЯ ---

// Флаг, который показывает, активен ли диалог в данный момент.
// Step Event будет работать только если is_active = true.
is_active = false;

// Флаг, который показывает, завершена ли анимация появления текста.
is_animation_complete = true;

/// @function           init(text_string, wrap_width)
/// @description        Настраивает и ЗАПУСКАЕТ контроллер для новой сессии диалога.
function init(text_string, wrap_width) {
    
    show_debug_message("Dialogue Controller: ЗАПУСК. Текст -> " + text_string);
    
    // --- 1. Сброс состояния и подготовка текста ---
    is_active = true;
    is_animation_complete = false;
    is_skipped = false;
    visible_word_index = 0;
    
    words_array = string_split(text_string, " ");
    full_text_wrapped = string_wrap(text_string, wrap_width);
    
    // --- 2. Остановка любой предыдущей анимации ---
    // ВАЖНО: Убедитесь, что у вас есть или будет функция Animation.stop()
    // Это предотвратит конфликты, если новый диалог запущен до завершения старого.
    // Animation.stop(id, "visible_word_index");
    
    // --- 3. Запуск новой анимации ---
    var _word_count = array_length(words_array);
    // Если в строке нет слов (пустая строка), просто завершаем.
    if (_word_count == 0) {
        is_animation_complete = true;
        return;
    }
    
    var _speed_per_word = 0.05; // Настраиваемая скорость
    var _total_duration = _word_count * _speed_per_word;
    
	show_debug_message("Animation Params: Words=" + string(_word_count) + ", Duration=" + string(_total_duration));	
	
    global.Animation.play(
        id,                         // Цель: этот самый экземпляр контроллера
        "visible_word_index",       // Анимируемая переменная
        _word_count,                // Конечное значение
        _total_duration,            // Длительность
        ac_linear,                  // Кривая анимации
        // --- НОВИНКА: Callback по завершению анимации ---
        // Мы передаем функцию, которая будет вызвана, когда анимация закончится.
        function() {
            show_debug_message("Dialogue Controller: Анимация текста завершена.");
            obj_dialogue_controller.is_animation_complete = true;
        },
    );
    
    // --- 4. Звуковое сопровождение ---
    //if (instance_exists(sound_manager)) {
    //    sound_manager.play_sfx("dialogue_start");
    //}
}

/// @function skip()
/// @description Мгновенно завершает анимацию текста.
function skip() {
    if (!is_animation_complete) {
        show_debug_message("Dialogue Controller: Анимация пропущена (skipped).");
        is_skipped = true;
        // Опять же, здесь нужна функция для остановки конкретной анимации
        // Animation.stop(id, "visible_word_index");
    }
}

/// @function close()
/// @description Завершает текущую сессию диалога.
function close() {
    show_debug_message("Dialogue Controller: Сессия диалога закрыта.");
    is_active = false;
    
    // "Прячем" текст, отправляя пустое событие
    EventBusBroadcast("OnDialogueUpdate", {
        text_to_draw: "",
        fading_word: "",
        fading_word_alpha: 0,
        is_animating: false
    });
}