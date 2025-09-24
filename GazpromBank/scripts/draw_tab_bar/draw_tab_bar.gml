/// @function draw_tab_bar()
/// @description Рисует нижнюю панель навигации и кнопки на ней.
function draw_tab_bar() {
    
    // --- Отрисовка фона панели ---
    // (Используем ваш существующий код, немного адаптировав)
    var _width = display_get_gui_width();
    var _height = display_get_gui_height();
    var _bar_render_height = 250; // Как в вашем коде
    
    draw_set_alpha(0.15); // Чуть более прозрачный для наглядности
	var _white = make_color_rgb(217, 217, 217)
    draw_rectangle_color(0, _height - _bar_render_height, _width, _height, _white, _white, _white, _white, false);
    draw_set_alpha(0.25);
	//draw_line_color()
	draw_line_width_color(0, _height - _bar_render_height, _width, _height - _bar_render_height, 2, c_black, c_black)
    draw_set_alpha(1);	

	
    // --- Отрисовка кнопок в цикле ---
    for (var i = 0; i < array_length(tab_bar_buttons); i++) {
		var _button = tab_bar_buttons[i];
		
		var _place_x  = _button.x_pos
		var _place_y = _button.y_pos
		
		var _current_scale = _button.current_scale;
		var _w = 0//(_button.width / 2) * _current_scale;
		var _h = 0//(_button.height / 2) * _current_scale;
		
		var _x1 = _place_x - _w//_button.x - _w;
		var _y1 = _place_y - _h;
		var _x2 = _place_x + _w;
		var _y2 = _place_y + _h;

		//draw_set_color(_button.color);
		
		//draw_rectangle(_x1, _y1, _x2, _y2, false);
        
		 var sprite_name = "spr_ico_" + _button.id
		 var _sprite_index = asset_get_index(sprite_name)
		
		draw_sprite_ext(_sprite_index, -1, _button.x_pos, _button.y_pos, _button.current_scale*0.75, _button.current_scale*0.75, 0, c_white, 1)
		
        // Подписываем кнопку для отладки
        //draw_set_color(c_white);
        //draw_set_halign(fa_center);
        //draw_set_valign(fa_top);
        //draw_text(_place_x, _place_y + _h, _button.label);
		//draw_text(_place_x, _place_y, "AA")
    }
    
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}