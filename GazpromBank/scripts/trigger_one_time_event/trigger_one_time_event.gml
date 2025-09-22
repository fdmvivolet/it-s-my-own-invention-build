/// @function           trigger_one_time_event(event_name, data)
/// @param {string}     event_name  Уникальное имя события для проверки и отправки.
/// @param {struct}     [data]      Необязательная структура с данными для EventBus.
/// @description        Проверяет, происходило ли событие ранее. Если нет -
//                      транслирует его в EventBus и помечает как произошедшее.
function trigger_one_time_event(event_name, data = {}) {
    
    // 1. Проверяем, было ли это событие уже запущено ранее
    // array_contains - быстрая и удобная функция для поиска значения в массиве
    if (array_contains(global.game_data.triggered_one_time_events, event_name)) {
        // Если событие уже есть в списке, ничего не делаем.
        return false;
    }
    
    // 2. Если мы здесь, значит, событие происходит впервые.
    show_debug_message("One-Time Event: Впервые срабатывает событие '" + event_name + "'");
    
    // Отправляем событие в EventBus
    EventBusBroadcast(event_name, data);
    
    // 3. Запоминаем, что это событие произошло, чтобы оно не сработало снова
    array_push(global.game_data.triggered_one_time_events, event_name);
    
    return true; // Возвращаем true, если событие было успешно запущено
}