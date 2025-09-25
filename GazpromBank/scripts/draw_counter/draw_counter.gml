//--------------------------
//функции
function draw_counter(){
	draw_set_font(fnt_main_bold)

	
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()

	var _bar_render_height = 250 + 100;
	
	var _lvl_x = sprite_get_width(spr_ico_settings)/2
	var _lvl_y = _bar_render_height  - sprite_get_height(spr_coin_icon)/2	

	var _coins = global.game_data.player_coins;

    hud_coins_target_x = _lvl_x;
    hud_coins_target_y = _lvl_y;

	// 2. Рисуем текст с количеством монет
	// Устанавливаем выравнивание, чтобы текст рисовался от левого края и был по центру вертикали
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black)
	draw_text(_lvl_x, _lvl_y, string(_coins));
	draw_set_color(c_white)
	// Сбрасываем выравнивание к дефолтному, чтобы не влиять на другую отрисовку
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}