// Инициализируем нашу шину событий как глобальную структуру.
// Она будет хранить все "подписки".
if (!variable_global_exists("event_bus")) {
    global.event_bus = {};
}

/// @function EventBusSubscribe(event_name, listener_instance, callback_function)
/// @description Подписывает экземпляр на прослушивание события.
/// @param {string} event_name    Название события, на которое подписываемся (например, "PlayerDied").
/// @param {Id.Instance} listener_instance   ID экземпляра, который слушает (обычно 'id').
/// @param {function} callback_function Функция, которая будет вызвана при событии.
function EventBusSubscribe(_event_name, _listener_instance, _callback) {
    // Если для этого события еще нет списка подписчиков, создаем его
    if (!variable_struct_exists(global.event_bus, _event_name)) {
        global.event_bus[$ _event_name] = [];
    }
    
    // Получаем список подписчиков
    var _subscribers = global.event_bus[$ _event_name];
    
    // Создаем структуру для хранения информации о подписчике
    var _subscriber_info = {
        instance_id: _listener_instance,
        callback: _callback
    };
    
    // Добавляем нового подписчика в список
    array_push(_subscribers, _subscriber_info);
}

/// @function EventBusUnsubscribe(event_name, listener_instance)
/// @description Отписывает экземпляр от события.
/// @param {string} event_name    Название события, от которого отписываемся.
/// @param {Id.Instance} listener_instance   ID экземпляра, который нужно отписать.
function EventBusUnsubscribe(_event_name, _listener_instance) {
    // Проверяем, существует ли вообще такое событие
    if (variable_struct_exists(global.event_bus, _event_name)) {
        var _subscribers = global.event_bus[$ _event_name];
        
        // Проходим по списку подписчиков в обратном порядке (безопасно при удалении)
        for (var i = array_length(_subscribers) - 1; i >= 0; i--) {
            if (_subscribers[i].instance_id == _listener_instance) {
                // Если нашли, удаляем из списка
                array_delete(_subscribers, i, 1);
            }
        }
    }
}

/// @function EventBusBroadcast(event_name, data_struct)
/// @description Публикует событие, уведомляя всех подписчиков.
/// @param {string} event_name    Название события, которое публикуем.
/// @param {struct} [data_struct]   (Опционально) Структура с данными для передачи подписчикам.
function EventBusBroadcast(_event_name, _data = {}) { // Используем {} как данные по умолчанию
    // Проверяем, есть ли кто-то, кто слушает это событие
    if (variable_struct_exists(global.event_bus, _event_name)) {
        var _subscribers = global.event_bus[$ _event_name];
        
        // Проходим по всем подписчикам
        for (var i = 0; i < array_length(_subscribers); i++) {
            var _sub = _subscribers[i];
            
            // ВАЖНО: Проверяем, существует ли еще экземпляр-подписчик
            if (instance_exists(_sub.instance_id)) {
                // Если да, вызываем его функцию-обработчик, передавая данные
                _sub.callback(_data);
            }
        }
    }
}

enum EVENT_NAMES{
	SEND_MESSAGE,
	DEACTIVATE_RECIEVER
}