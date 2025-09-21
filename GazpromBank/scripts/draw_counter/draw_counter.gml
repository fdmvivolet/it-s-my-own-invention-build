//--------------------------
//функции
function draw_counter(){
	// --- 1.1. ОТРИСОВКА СЧЕТЧИКА МОНЕТ ---

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

	// --- Отрисовка ---
	// 1. Рисуем заглушку для иконки (простой желтый круг)
	draw_set_color(c_yellow);
	draw_circle(_icon_x, _icon_y, _hud_icon_radius, false); // false = не залитый, outline
	draw_set_color(c_white); // Возвращаем цвет по умолчанию для текста

	// 2. Рисуем текст с количеством монет
	// Устанавливаем выравнивание, чтобы текст рисовался от левого края и был по центру вертикали
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(_text_x, _text_y, string(_coins));

	// Сбрасываем выравнивание к дефолтному, чтобы не влиять на другую отрисовку
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);	
	
}