/// @function           string_wrap(text, max_width)
/// @param {string}     text        Исходная строка текста.
/// @param {real}       max_width   Максимальная ширина в пикселях, в которую должен вписаться текст.
/// @return {string}     Отформатированная строка с добавленными символами переноса ('\n').
function string_wrap(text, max_width) {
    
    // 1. Предварительная обработка и инициализация
    if (string_width(text) <= max_width) {
        // Если текст и так помещается, ничего не делаем, возвращаем его как есть.
        return text;
    }
    
    var _words = string_split(text, " "); // Разбиваем текст на массив слов
    var _line_count = array_length(_words);
    
    var _final_text = ""; // Сюда будем собирать результат
    var _current_line = ""; // Здесь собираем текущую строку
    
    // 2. Основной цикл: собираем строки слово за словом
    for (var i = 0; i < _line_count; i++) {
        var _word = _words[i];
        
        // Формируем "тестовую" строку, чтобы проверить ее ширину
        var _test_line = _current_line + (_current_line == "" ? "" : " ") + _word;
        
        if (string_width(_test_line) > max_width) {
            // Если с новым словом строка стала слишком длинной:
            
            // 1. "Фиксируем" предыдущую версию строки (без нового слова) в результат
            _final_text += _current_line + "\n";
            
            // 2. Начинаем новую строку с этого "не поместившегося" слова
            _current_line = _word;
            
        } else {
            // Если новое слово помещается, просто добавляем его к текущей строке
            _current_line = _test_line;
        }
    }
    
    // 3. Добавляем последнюю собранную строку в результат
    _final_text += _current_line;
    
    return _final_text;
}