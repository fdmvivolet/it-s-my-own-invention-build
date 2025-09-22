// --- obj_npc_helper: Create Event (ФИНАЛЬНАЯ, ЧИСТАЯ ВЕРСЯ) ---

/// @description Инициализация менеджера подсказок.

show_debug_message("NPC Helper: Инициализация...");

// --- 1. Переменные ---
// Единственное, что хранит NPC Helper - это очередь сообщений, которые ждут своего часа.
message_queue = [];


// --- obj_npc_helper: Create Event (исправленная версия) ---

// ...

// --- 2. Методы-обработчики ---

// Этот метод срабатывает, когда игра сообщает о событии, на которое нужно показать подсказку.
function on_tutorial_trigger(data) {
    // ... (этот метод не трогает message_queue, он в порядке)
    EventBusBroadcast("ShowTooltipRequested", data);
}

// Этот метод срабатывает, когда UI Bus Handler сообщает нам, что UI занят.
function on_request_tooltip_queue(data) {
    show_debug_message("NPC Helper: UI занят. Подсказка добавлена в очередь.");
    // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
    array_push(obj_npc_helper.message_queue, data.message);
}

// Этот метод срабатывает, когда любое окно UI закрывается.
function on_ui_window_closed(data) {
    // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
    if (array_length(obj_npc_helper.message_queue) > 0) {
        // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
        var _next_message = obj_npc_helper.message_queue[0]; 
        // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
        array_delete(obj_npc_helper.message_queue, 0, 1);
        
        EventBusBroadcast("ShowTooltipRequested", { message: _next_message });
    }
}

// ... (остальной код с подписками) ...


// --- 3. Подписки на события ---
show_debug_message("NPC Helper: Подписка на триггеры обучения...");

// Подписываемся на игровые события, которые должны вызывать подсказки.
// Все они будут использовать один и тот же простой обработчик on_tutorial_trigger.
EventBusSubscribe("FirstAssetPurchased", id, on_tutorial_trigger);
// EventBusSubscribe("FirstIncomeCollected", id, on_tutorial_trigger); // <-- раскомментируем в будущем
// EventBusSubscribe("PlayerLeveledUp", id, on_tutorial_trigger);      // <-- раскомментируем в будущем

// Подписываемся на служебные события от UI.
EventBusSubscribe("RequestTooltipQueue", id, on_request_tooltip_queue);
EventBusSubscribe("UIWindowClosed", id, on_ui_window_closed);


show_debug_message("NPC Helper: Инициализация завершена.");