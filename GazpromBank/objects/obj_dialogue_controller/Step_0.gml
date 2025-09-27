/// @description Insert description here
// You can write your code in this editor
/// @description Вычисляет видимый текст и "вещает" в EventBus.
/*
// Если диалог не активен, ничего не делаем.
if (!is_active) {
    return;
}

// --- 1. Определяем, сколько слов должно быть видно ---
var _text_to_draw = "";
var _fading_word = "";
var _fading_word_alpha = 0;

if (is_skipped || is_animation_complete) {
    // Если анимацию пропустили или она завершена, показываем весь текст.
    _text_to_draw = full_text_wrapped;
    
} else {
    // Иначе, вычисляем на основе анимируемой переменной.
    var _visible_count_full = floor(visible_word_index);
    var _current_alpha = frac(visible_word_index);
    
    // Собираем полностью видимую часть текста
    var _visible_words = []//array_slice(words_array, 0, _visible_count_full);

	array_copy(_visible_words, 0, words_array, 0, _visible_count_full)

    _text_to_draw = string_join(" ", _visible_words);
    
    // Добавляем пробел перед следующим словом, если это не первое слово
    if (_visible_count_full > 0) {
        _text_to_draw += " ";
    }
    
    // Получаем слово, которое сейчас проявляется
    if (_visible_count_full < array_length(words_array)) {
        _fading_word = words_array[_visible_count_full];
        _fading_word_alpha = _current_alpha;
    }
}

// --- 2. "Вещаем" данные для отрисовки в EventBus ---
//show_debug_message(string(_text_to_draw) + "\n" + string(_fading_word) + "\n" + string(_fading_word_alpha))
EventBusBroadcast("OnDialogueUpdate", {
    text_to_draw: _text_to_draw,
    fading_word: _fading_word,
    fading_word_alpha: _fading_word_alpha,
    is_animating: !is_animation_complete && !is_skipped
});