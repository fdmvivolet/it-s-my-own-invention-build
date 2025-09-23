/// @function       process_buttons_input(button_array)
/// @param {array}  button_array  Массив структур, описывающих кнопки.
/// @return {bool}   Возвращает true, если клик был обработан одной из кнопок.
function process_buttons_input(button_array) {
    
    var _mouse_x = device_mouse_x_to_gui(0);
    var _mouse_y = device_mouse_y_to_gui(0);
    var _mouse_pressed = device_mouse_check_button_pressed(0, mb_left);
    var _mouse_released = device_mouse_check_button_released(0, mb_left);
    
    var _click_handled = false;
    
    for (var i = 0; i < array_length(button_array); i++) {
        var _button = button_array[i];
        
        // --- Логика состояний (упрощенная, без hover) ---
        var _w_half = _button.width / 2;
        var _h_half = _button.height / 2;
        var _mouse_over = point_in_rectangle(_mouse_x, _mouse_y, _button.x_pos - _w_half, _button.y_pos - _h_half, _button.x_pos + _w_half, _button.y_pos + _h_half);
        
        switch (_button.state) {
            case ButtonState.IDLE:
                if (_mouse_pressed && _mouse_over) {
                    _button.state = ButtonState.PRESSED;
                }
                break;
            
            case ButtonState.PRESSED:
                if (_mouse_released) {
                    // Если кнопку отпустили над ней же, вызываем действие
                    if (_mouse_over) {
                        if (is_method(_button.callback)) {
                            obj_sound_manager.play_sfx("ui_click_high");
                            _button.callback(_button);
                            _click_handled = true;
                        }
                    }
                    // В любом случае возвращаемся в состояние покоя
                    _button.state = ButtonState.IDLE;
                }
                break;
        }
        
        // --- Логика анимации (упрощенная, без hover) ---
        var _target_scale = _button.scale_idle;
        if (_button.state == ButtonState.PRESSED) {
            _target_scale = _button.scale_pressed;
        }
        
        var _animation_speed = 0.2;
        if (_target_scale == _button.scale_pressed) {
            _animation_speed = 0.8;
        }
        
        _button.current_scale = lerp(_button.current_scale, _target_scale, _animation_speed);
    }
    
    return _click_handled;
}

function process_buttons_input_test(button_array) {
    
    var _mouse_x = device_mouse_x_to_gui(0);
    var _mouse_y = device_mouse_y_to_gui(0);
    var _mouse_pressed = device_mouse_check_button_pressed(0, mb_left);
    var _mouse_released = device_mouse_check_button_released(0, mb_left);
    
    var _click_handled = false;
    
    for (var i = 0; i < array_length(button_array); i++) {
        var _button = button_array[i];
        
        // --- Логика состояний (упрощенная, без hover) ---
        var _w_half = _button.width / 2;
        var _h_half = _button.height / 2;
        draw_rectangle_color(_button.x_pos - _w_half, _button.y_pos - _h_half, _button.x_pos + _w_half, _button.y_pos + _h_half, 
		c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, false);
         var _mouse_over = point_in_rectangle(_mouse_x, _mouse_y, _button.x_pos - _w_half, _button.y_pos - _h_half, _button.x_pos + _w_half, _button.y_pos + _h_half);
        switch (_button.state) {
            case ButtonState.IDLE:
                if (_mouse_pressed && _mouse_over) {
                    _button.state = ButtonState.PRESSED;
                }
                break;
            
            case ButtonState.PRESSED:
                if (_mouse_released) {
                    // Если кнопку отпустили над ней же, вызываем действие
                    if (_mouse_over) {
                        if (is_method(_button.callback)) {
                            obj_sound_manager.play_sfx("ui_click_high");
                            _button.callback(_button);
                            _click_handled = true;
                        }
                    }
                    // В любом случае возвращаемся в состояние покоя
                    _button.state = ButtonState.IDLE;
                }
                break;
        }
        
        // --- Логика анимации (упрощенная, без hover) ---
        var _target_scale = _button.scale_idle;
        if (_button.state == ButtonState.PRESSED) {
            _target_scale = _button.scale_pressed;
        }
        
        var _animation_speed = 0.2;
        if (_target_scale == _button.scale_pressed) {
            _animation_speed = 0.8;
        }
        
        _button.current_scale = lerp(_button.current_scale, _target_scale, _animation_speed);
    }
    
    return _click_handled;
}