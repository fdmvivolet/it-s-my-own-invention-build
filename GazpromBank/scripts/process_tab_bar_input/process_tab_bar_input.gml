/// @function process_tab_bar_input()
/// @description Обрабатывает ввод для кнопок Tab Bar, обновляя их состояние.
function process_tab_bar_input() {
    
    // Получаем состояние мыши один раз за кадр для всех кнопок
    var _mouse_x = device_mouse_x_to_gui(0);
    var _mouse_y = device_mouse_y_to_gui(0);
    var _mouse_pressed = device_mouse_check_button_pressed(0, mb_left);
    var _mouse_released = device_mouse_check_button_released(0, mb_left);
    
    // Проверяем каждую кнопку в цикле
    for (var i = 0; i < array_length(tab_bar_buttons); i++) {
        var _button = tab_bar_buttons[i]; // Получаем ссылку на структуру кнопки
        
        // Рассчитываем границы кнопки
        var _w_half = _button.width / 2;
        var _h_half = _button.height / 2;
        var _x1 = _button.x_pos - _w_half;
        var _y1 = _button.y_pos - _h_half;
        var _x2 = _button.x_pos + _w_half;
        var _y2 = _button.y_pos + _h_half;
        
        // Проверяем, находится ли мышь над кнопкой
        var _mouse_over = point_in_rectangle(_mouse_x, _mouse_y, _x1, _y1, _x2, _y2);
        
        // Реализуем машину состояний (логика из вашего примера)
        switch (_button.state) {
            case ButtonState.IDLE:
                if (_mouse_over) { _button.state = ButtonState.HOVER; }
                break;
            
            case ButtonState.HOVER:
                if (!_mouse_over) { _button.state = ButtonState.IDLE; }
                else if (_mouse_pressed) { _button.state = ButtonState.PRESSED; }
                break;
            
            case ButtonState.PRESSED:
                // Если мышь отпущена или ушла с кнопки
                if (!_mouse_over || _mouse_released) {
                    // Если мышь была отпущена именно над этой кнопкой
                    if (_mouse_over && _mouse_released) {
                        // Вызываем callback, если он назначен
                        if (is_method(_button.callback)) {
                            // Вызываем метод, передавая ему саму структуру в качестве аргумента.
                            // Это может быть полезно в будущем.
							obj_sound_manager.play_sfx("ui_click_high");
                            _button.callback(_button);
                        }
                    }
                    // Определяем следующее состояние: HOVER если мышь все еще над кнопкой, иначе IDLE
                    _button.state = _mouse_over ? ButtonState.HOVER : ButtonState.IDLE;
                }
                break;
        }
		
        var _target_scale = _button.scale_idle;
        switch (_button.state) {
            case ButtonState.HOVER:   _target_scale = _button.scale_hover;   break;
            case ButtonState.PRESSED: _target_scale = _button.scale_pressed; break;
        }
        
        // 2. Определяем скорость анимации
        var _animation_speed = 0.2;
        if (_target_scale == _button.scale_pressed) {
            _animation_speed = 0.8; // Быстрое нажатие
        }
        
        // 3. Плавно изменяем текущий масштаб в сторону целевого
        _button.current_scale = lerp(_button.current_scale, _target_scale, _animation_speed);		
		//show_debug_message("123")
    }
}