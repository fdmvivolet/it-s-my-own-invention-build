//--------------------------
//функции
function draw_counter(){
	// --- 1.1. ОТРИСОВКА СЧЕТЧИКА МОНЕТ ---
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()
	var _white = make_color_rgb(217, 217, 217)
	var _bar_render_height = 250 + 100;
	
	var _window_width = _width * 0.25
	
	var _spr_width = sprite_get_width(spr_ico_settings) 
	var _spr_height = sprite_get_height(spr_coin_icon) 
	var x_pos = _spr_width / 4
	var y_pos = _bar_render_height  - _spr_height + 75
	//draw_roundrect_ext(x_pos, y_pos, x_pos + _window_width, _bar_render_height + 65 , 128, 128, true)
	draw_set_alpha(0.5)

	//draw_roundrect_color_ext(x_pos, y_pos, x_pos + _window_width, _bar_render_height + 65 , 108, 108, _white, _white, false)
	draw_set_alpha(1)
	
	//draw_sprite_ext(spr_coin_icon, -1, _spr_width, _bar_render_height  - sprite_get_height(spr_coin_icon)/2, 
	//0.75 * (1 - sprite_get_width(spr_coin_icon)/_width ), 0.75, 0, c_white, 1)
		
	// --- Константы для настройки положения и вида (легко менять) ---
	var _hud_padding = 48;      // Отступ от края экрана
	var _hud_icon_radius = 32;  // Размер иконки-заглушки
	var _hud_text_gap = 24;     // Расстояние между иконкой и текстом

	// --- Получаем данные ---
	// Всегда берем данные из единого источника - global.game_data
	var _coins = global.game_data.player_coins;

	// --- Позиционирование ---
	// Рассчитываем координаты от левого верхнего угла
	var _icon_x = _hud_padding;
	var _icon_y = _hud_padding;
	var _text_x = _icon_x + _hud_icon_radius + _hud_text_gap;
	var _text_y = _icon_y;

    hud_coins_target_x = _icon_x;
    hud_coins_target_y = _icon_y;

	// 2. Рисуем текст с количеством монет
	// Устанавливаем выравнивание, чтобы текст рисовался от левого края и был по центру вертикали
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(_text_x, _text_y, string(_coins));

	// Сбрасываем выравнивание к дефолтному, чтобы не влиять на другую отрисовку
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}