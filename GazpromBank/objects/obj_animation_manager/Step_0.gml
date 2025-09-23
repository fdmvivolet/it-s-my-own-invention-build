// --- obj_animation_manager: Step Event ---

/// @description Обновление всех активных анимаций.

// Получаем delta_time один раз за кадр.
var _dt = delta_time;

// Пробегаемся по списку активных анимаций.
// ВАЖНО: Идем с конца, чтобы безопасно удалять элементы прямо во время итерации.
for (var i = array_length(active_tweens) - 1; i >= 0; i--) {
    
    var _tween = active_tweens[i];
    
    // --- 1. Обновляем таймер ---
    // Увеличиваем таймер на время, прошедшее с прошлого кадра
    _tween.time += _dt;
    
    // --- 2. Проверяем, существует ли еще цель ---
    if (!instance_exists(_tween.target)) {
        // Если объект был уничтожен, просто удаляем его анимацию
        array_delete(active_tweens, i, 1);
        continue; // Переходим к следующей итерации
    }
    
    // --- 3. Рассчитываем прогресс ---
    // `progress` - это число от 0.0 до 1.0, показывающее, на сколько завершена анимация
    var _progress = clamp(_tween.time / _tween.duration, 0, 1);
    
    // Сначала мы должны получить struct с данными кривой по ее ID
    var _curve_struct = animcurve_get(_tween.curve); 
    
    // Теперь, когда у нас есть struct, мы можем безопасно обратиться к ее каналам
    // `_curve_struct.channels[0]` - это первый (и обычно единственный) канал кривой
    var _curve_value = animcurve_channel_evaluate(_curve_struct.channels[0], _progress);
    var _current_value;
    
    if (_tween.start_value == _tween.end_value) {
        // В этом случае кривая напрямую управляет результатом.
        // Мы умножаем стартовое значение на значение с кривой.
        // Наша кривая ac_bounce идет от 0 до 1.1 и обратно до 1.0,
        // поэтому масштаб будет от 0 до 1.1 и обратно до 1.0.
        // Чтобы это работало, кривая должна начинаться и заканчиваться на 1.0, а в середине иметь пик 1.1.
        _current_value = _tween.start_value * _curve_value; 
    } else {
        // Если значения разные, используем lerp, как и раньше (для обычных анимаций).
        _current_value = lerp(_tween.start_value, _tween.end_value, _curve_value);
    }
    
    // --- 6. Применяем значение к объекту ---
    variable_instance_set(_tween.target, _tween.property, _current_value);
    
    // --- 7. Проверяем, завершена ли анимация ---
    if (_progress >= 1.0) {
        // Анимация завершена, удаляем ее из списка.
        array_delete(active_tweens, i, 1);
    }
}