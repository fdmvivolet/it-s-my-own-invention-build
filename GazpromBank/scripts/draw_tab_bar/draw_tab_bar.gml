/// @function draw_tab_bar()
/// @description Рисует нижнюю панель навигации и кнопки на ней.
function draw_tab_bar() {
    
    // --- Отрисовка фона панели ---
    // (Используем ваш существующий код, немного адаптировав)
    var _width = display_get_gui_width();
    var _height = display_get_gui_height();
    var _bar_render_height = 256; // Как в вашем коде
    
    draw_set_alpha(0.8); // Чуть более прозрачный для наглядности
    draw_rectangle_color(0, _height - _bar_render_height, _width, _height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // --- Отрисовка кнопок в цикле ---
    for (var i = 0; i < array_length(tab_bar_buttons); i++) {
		var _button = tab_bar_buttons[i];
		
		var _place_x  = _button.x_pos
		var _place_y = _button.y_pos
		
		var _current_scale = _button.current_scale;
		var _w = (_button.width / 2) * _current_scale;
		var _h = (_button.height / 2) * _current_scale;
		
		var _x1 = _place_x - _w//_button.x - _w;
		var _y1 = _place_y - _h;
		var _x2 = _place_x + _w;
		var _y2 = _place_y + _h;

		draw_set_color(_button.color);
		draw_rectangle(_x1, _y1, _x2, _y2, false);
        
        // Подписываем кнопку для отладки
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_text(_place_x, _place_y + _h, _button.label);
		//draw_text(_place_x, _place_y, "AA")
    }
    
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}