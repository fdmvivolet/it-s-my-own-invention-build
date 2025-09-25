/// @function draw_cta_window()
/// @description Рисует модальное окно Call-to-Action с предложением узнать больше о продукте.
function draw_cta_window() {
    
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;	
	
    // --- 1. Получаем данные из контекста, который сохранил bus_handler ---
    // В current_context_data лежат title, body, question и тексты кнопок.
    var _context = current_context_data;
    
    var _title_x = _gui_w / 2;
    var _title_y = _gui_h/2 - _win_height / 2 * 0.85;
    
    // --- 3. Рисуем контент (текст) ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top); // Выравниваем по верху для удобства позиционирования
    
    // Заголовок
    draw_text(_title_x, _title_y, _context.title);
    
    var _body_text_width = _win_width - 170; // Ширина текста = ширина окна минус отступы
    
	var _body_y = _title_y + 0.2 * _win_height
	
	draw_set_font(fnt_main_normal_big)
	draw_text_ext(_title_x, _body_y, _context.body, 50 * window_scale, _body_text_width * window_scale);
    
	
	var _ui = obj_ui_manager.cta_buttons
	var acc_button_y = _gui_h/2 + 0.3 * _win_height + 50
	var no_acc_button_y = _gui_h/2 + 0.15 * _win_height + 25
	
	draw_sprite_ext(spr_no_accept_cta, -1, _ui[0].x_pos, _ui[0].y_pos, 
	_ui[0].current_scale * window_scale * 1/2,
	_ui[0].current_scale * window_scale * 1/2, 0, c_white, 1)
	
	draw_sprite_ext(spr_accept_cta, -1, _ui[1].x_pos, _ui[1].y_pos, 
	_ui[1].current_scale * window_scale * 1/2,
	_ui[1].current_scale * window_scale * 1/2, 0, c_white, 1)	
	
	//draw_sprite_ext(spr_accept_cta, -1, _gui_w/2, acc_button_y, window_scale * 1/2, window_scale * 1/2, 0, c_white, 1)	
	
	draw_set_color(c_black)
	//draw_set_font(fnt_main_bold)
	//draw_sprite_ext(spr_no_accept_cta, -1, _gui_w/2, no_acc_button_y, window_scale * 1/2, window_scale * 1/2, 0, c_white, 1)
	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
	draw_text(_gui_w/2, _ui[0].y_pos, _context.decline_text)

	//draw_sprite_ext(spr_accept_cta, -1, _gui_w/2, acc_button_y, window_scale * 1/2, window_scale * 1/2, 0, c_white, 1)
	draw_text(_gui_w/2, _ui[1].y_pos, _context.confirm_text)
    draw_set_color(c_black)
	// --- 5. Сброс настроек отрисовки ---
    // Важно, чтобы не повлиять на другие элементы UI, которые рисуются после
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
	

}

function create_cta_buttons() {
	
	obj_ui_manager.cta_buttons = []
	
	var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
	var window_scale = obj_ui_manager.window_scale 
  
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;	
	

    var _context = obj_ui_manager.current_context_data;       
	
	if _context == noone {exit}
	
	var no_acc_button_y = _gui_h/2 + 0.15 * _win_height + 25

	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; 
	var _button_scale_pressed = 1;

	array_push(obj_ui_manager.cta_buttons, {
		x_pos: _gui_w/2, 
		y_pos: no_acc_button_y, 
		sprite_index: spr_no_accept_cta,
		state: ButtonState.IDLE,
		callback: function() {
			WINDOW_CLOSE_ANIMATION
		},
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle 
	});	

    var acc_button_y = _gui_h/2 + 0.3 * _win_height + 50

	array_push(obj_ui_manager.cta_buttons, {
		x_pos: _gui_w/2, 
		y_pos: acc_button_y, 
		sprite_index: spr_accept_cta,
		state: ButtonState.IDLE,
		callback: function() {
			var _url = obj_ui_manager.current_context_data.context_url
			show_message_async("Переход по ссылке\n" + string(_url))
			WINDOW_CLOSE_ANIMATION
		},
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});

}

/*
/// @function draw_cta_window()
/// @description Рисует модальное окно Call-to-Action с предложением узнать больше о продукте.
function draw_cta_window() {
    
    // --- 1. Получаем данные из контекста, который сохранил bus_handler ---
    // В current_context_data лежат title, body, question и тексты кнопок.
    var _context = current_context_data;
    
    // --- 2. Рисуем фон и плашку окна (стандартная процедура, аналогично level-up) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Рисуем полупрозрачное затемнение на весь экран
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);
    
    // Определяем размеры и положение окна, используя window_scale для адаптивности.
    // Размеры взяты из примера draw_level_up_window для единообразия.
    var _win_width = 800 * window_scale;
    var _win_height = 600 * window_scale;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    
    // Рисуем подложку окна
    draw_set_color(c_dkgray); // Используем тот же цвет фона, что и в примере
    draw_rectangle(_win_x, _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    // --- 3. Рисуем контент (текст) ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top); // Выравниваем по верху для удобства позиционирования
    
    // Заголовок
    draw_text(_win_x + _win_width / 2, _win_y + 50 * window_scale, _context.title);
    
    // Основной текст (используем draw_text_ext для переноса строк)
    // Отступы и размеры блока текста подобраны так, чтобы он хорошо смотрелся в окне
    var _body_text_width = _win_width - (160 * window_scale); // Ширина текста = ширина окна минус отступы
    draw_text_ext(_win_x + _win_width / 2, _win_y + 120 * window_scale, _context.body, 40 * window_scale, _body_text_width);
    
    // Вопрос перед кнопками
    draw_text(_win_x + _win_width / 2, _win_y + 250 * window_scale, _context.question);
    
    // --- 4. Рисуем кнопки (вертикально) ---
    draw_set_valign(fa_middle); // Для текста на кнопках лучше выравнивание по центру
    
    // Определяем общие параметры для кнопок
    var _btn_w = 400 * window_scale; // Ширина кнопок
    var _btn_h = 80 * window_scale;  // Высота кнопок
    var _btn_x = _win_x + _win_width / 2;
    
    // --- Кнопка "Подтвердить" (верхняя) ---
    var _btn_confirm_y = _win_y + 350 * window_scale;
    // Сохраняем геометрию кнопки в переменную для обработки нажатий в Step событии
    btn_cta_confirm = { x: _btn_x, y: _btn_confirm_y, w: _btn_w, h: _btn_h, text: _context.confirm_text };
    
    draw_set_color(c_green); // Зеленый цвет для основного действия
    draw_rectangle(_btn_x - _btn_w / 2, _btn_confirm_y - _btn_h / 2, _btn_x + _btn_w / 2, _btn_confirm_y + _btn_h / 2, false);
    draw_set_color(c_white);
    draw_text(_btn_x, _btn_confirm_y, btn_cta_confirm.text);
    
    // --- Кнопка "Отказаться" (нижняя) ---
    var _btn_decline_y = _btn_confirm_y + _btn_h + (30 * window_scale); // Располагаем ниже с отступом
    // Сохраняем геометрию второй кнопки
    btn_cta_decline = { x: _btn_x, y: _btn_decline_y, w: _btn_w, h: _btn_h, text: _context.decline_text };
    
    draw_set_color(c_red); // Красный/другой цвет для второстепенного действия
    draw_rectangle(_btn_x - _btn_w / 2, _btn_decline_y - _btn_h / 2, _btn_x + _btn_w / 2, _btn_decline_y + _btn_h / 2, false);
    draw_set_color(c_white);
    draw_text(_btn_x, _btn_decline_y, btn_cta_decline.text);
    
    // --- 5. Сброс настроек отрисовки ---
    // Важно, чтобы не повлиять на другие элементы UI, которые рисуются после
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

