var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);


var _button_left = x - sprite_get_width(sprite_index)/2;
var _button_top = y - sprite_get_height(sprite_index)/2;
var _button_right = x; 
var _button_bottom = y; 

// Проверяем, назначен ли вообще спрайт этому объекту
if (sprite_index != -1)
{
    // Если спрайт есть, рассчитываем правую и нижнюю границы
    _button_right = x + sprite_get_width(sprite_index)/2;
    _button_bottom = y + sprite_get_height(sprite_index)/2;
}

var _mouse_over = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, _button_left, _button_top, _button_right, _button_bottom);

var _mouse_pressed = device_mouse_check_button_pressed(0, mb_left);
var _mouse_released = device_mouse_check_button_released(0, mb_left);

switch (state) {
    case BUTTON_STATE.IDLE:
        if (_mouse_over) { state = BUTTON_STATE.HOVER; }
        break;
    
    case BUTTON_STATE.HOVER:
        if (!_mouse_over) { state = BUTTON_STATE.IDLE; }
        else if (_mouse_pressed) { state = BUTTON_STATE.PRESSED; }
        break;
    
    case BUTTON_STATE.PRESSED:
        if (!_mouse_over || _mouse_released) {
            if (_mouse_over && _mouse_released) {
                if (callback_function != noone) {
                    callback_function();
                }
            }
            state = _mouse_over ? BUTTON_STATE.HOVER : BUTTON_STATE.IDLE;
        }
        break;
}