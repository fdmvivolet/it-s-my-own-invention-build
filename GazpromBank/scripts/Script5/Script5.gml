// --- Script: input_system ---

/// @function input_system_process()
/// @description Обрабатывает касания и наведение для всех интерактивных объектов.
/// Должна вызываться каждый кадр из obj_game_manager.
function input_system_process() {

    // --- 1. ОПРЕДЕЛЕНИЕ КООРДИНАТ КАСАНИЯ ---
    // device_mouse_... функции работают как для мыши, так и для касаний на мобильных устройствах.
    // Аргумент 0 означает первое касание/палец.
    var _touch_x = device_mouse_x(0);
    var _touch_y = device_mouse_y(0);
    
    // --- 2. ЛОГИКА "НАВЕДЕНИЯ" (HOVER) ---
    // Находим самый верхний экземпляр под курсором/пальцем
    var _current_hover = instance_position(_touch_x, _touch_y, obj_parent_clickable);
    
    // Сравниваем с тем, что было в прошлом кадре
    if (_current_hover != global.last_hovered_instance) {
        // Если мы убрали палец с предыдущего объекта, вызываем у него OnHoverEnd
        if (instance_exists(global.last_hovered_instance)) {
            with (global.last_hovered_instance) {
                event_perform(ev_other, ev_user2); // Вызов User Event 2 (OnHoverEnd)
            }
        }
        
        // Если мы навели палец на новый объект, вызываем у него OnHoverStart
        if (instance_exists(_current_hover)) {
            with (_current_hover) {
                event_perform(ev_other, ev_user1); // Вызов User Event 1 (OnHoverStart)
            }
        }
        
        // Обновляем "предыдущий" объект на "текущий" для следующего кадра
        global.last_hovered_instance = _current_hover;
    }
    
    // --- 3. ЛОГИКА "ТАПА" (TAP) ---
    // Проверяем, было ли совершено нажатие в этом кадре
    if (device_mouse_check_button_pressed(0, mb_left)) {
        // Если в момент нажатия мы находились над каким-либо интерактивным объектом...
        if (instance_exists(global.last_hovered_instance)) {
            // ...вызываем у этого объекта событие OnTap
            with (global.last_hovered_instance) {
                event_perform(ev_other, ev_user0); // Вызов User Event 0 (OnTap)
            }
        }
    }
}