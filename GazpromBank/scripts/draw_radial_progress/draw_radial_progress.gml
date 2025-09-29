/// @function           draw_radial_progress(x, y, progress, outer_radius, inner_radius, color, bg_sprite)
/// @param {real}       x               Центральная координата X.
/// @param {real}       y               Центральная координата Y.
/// @param {real}       progress        Прогресс заполнения от 0.0 до 1.0.
/// @param {real}       outer_radius    Внешний радиус кольца.
/// @param {real}       inner_radius    Внутренний радиус кольца (размер "дырки").
/// @param {color}      color           Цвет заполнения.
/// @param {Asset.GMSprite} bg_sprite   Спрайт-подложка (полное кольцо). Используйте -1, если фон не нужен.
/// @description        Рисует процедурный круговой индикатор в форме кольца.

function draw_radial_progress(x, y, progress, outer_radius, inner_radius, color, bg_sprite) {
    
    // --- 1. Рисуем фон (подложку) ---
    if (sprite_exists(bg_sprite)) {
        draw_sprite(bg_sprite, 0, x, y);
    }
    
    // --- 2. Подготовка к рисованию "заливки" ---
    // Ограничиваем прогресс в пределах от 0 до 1, чтобы избежать ошибок.
    var _progress = clamp(progress, 0, 1);
    
    // Если прогресс нулевой, то рисовать ничего не нужно. Выходим.
    if (_progress <= 0) {
        return;
    }
    
    // --- 3. Расчет геометрии ---
    // В GameMaker 0 градусов - это "3 часа". Нам нужно начать с "12 часов", что равно 90 градусам.
    var _start_angle = 90; 
    
    // Мы будем рисовать по часовой стрелке, поэтому будем вычитать угол из начального.
    var _angle_to_draw = _progress * 360;
    var _end_angle = _start_angle - _angle_to_draw;
    
    // Определяем, насколько гладким будет кольцо. Чем меньше шаг, тем больше треугольников и тем плавнее.
    var _angle_step = 5; // Шаг в 5 градусов - хороший баланс качества и производительности.
    
    // --- 4. Рисование примитива ---
    draw_set_color(color);
    draw_primitive_begin(pr_trianglestrip);
    
    // В цикле создаем "полосу" из треугольников
    for (var i = _start_angle; i > _end_angle; i -= _angle_step) {
        
        // Вычисляем координаты для ВНЕШНЕЙ вершины
        var _x_outer = x + lengthdir_x(outer_radius, i);
        // ВАЖНО: Мы вычитаем Y, так как в GameMaker ось Y направлена вниз.
        var _y_outer = y - lengthdir_y(outer_radius, i); 
        
        // Вычисляем координаты для ВНУТРЕННЕЙ вершины
        var _x_inner = x + lengthdir_x(inner_radius, i);
        var _y_inner = y - lengthdir_y(inner_radius, i);
        
        // Добавляем пару вершин в "полосу". Порядок важен.
        draw_vertex(_x_outer, _y_outer);
        draw_vertex(_x_inner, _y_inner);
    }
    
    // ВАЖНО: Чтобы индикатор был точным, нам нужно добавить последнюю пару вершин
    // точно в конечной точке, так как цикл мог ее "перешагнуть".
    var _x_outer_end = x + lengthdir_x(outer_radius, _end_angle);
    var _y_outer_end = y - lengthdir_y(outer_radius, _end_angle);
    var _x_inner_end = x + lengthdir_x(inner_radius, _end_angle);
    var _y_inner_end = y - lengthdir_y(inner_radius, _end_angle);
    
    draw_vertex(_x_outer_end, _y_outer_end);
    draw_vertex(_x_inner_end, _y_inner_end);
    
    // Завершаем рисование примитива
    draw_primitive_end();
    
    // Сбрасываем цвет на белый, чтобы не влиять на другие элементы
    draw_set_color(c_white);
}

/// @function           draw_elliptical_progress(x, y, progress, outer_rx, outer_ry, inner_rx, inner_ry, color, bg_sprite)
/// @param {real}       x               Центральная координата X.
/// @param {real}       y               Центральная координата Y.
/// @param {real}       progress        Прогресс заполнения от 0.0 до 1.0.
/// @param {real}       outer_rx        Внешний ГОРИЗОНТАЛЬНЫЙ радиус (ваш 'a' для внешнего эллипса).
/// @param {real}       outer_ry        Внешний ВЕРТИКАЛЬНЫЙ радиус (ваш 'b' для внешнего эллипса).
/// @param {real}       inner_rx        Внутренний ГОРИЗОНТАЛЬНЫЙ радиус.
/// @param {real}       inner_ry        Внутренний ВЕРТИКАЛЬНЫЙ радиус.
/// @param {color}      color           Цвет заполнения.
/// @param {Asset.GMSprite} bg_sprite   Спрайт-подложка (полное кольцо). Используйте -1, если фон не нужен.
/// @description        Рисует процедурный эллиптический индикатор прогресса.

function draw_elliptical_progress(x, y, progress, outer_rx, outer_ry, inner_rx, inner_ry, color, bg_sprite = noone) {
    
    // --- 1. Рисуем фон (подложку) ---
    // ВАЖНО: Спрайт-подложка должен быть отмасштабирован, чтобы соответствовать эллипсу.
    if (sprite_exists(bg_sprite)) {
        // Мы "сплющиваем" или "растягиваем" квадратный спрайт до нужных пропорций эллипса.
        var _spr_w = sprite_get_width(bg_sprite);
        var _spr_h = sprite_get_height(bg_sprite);
        var _xscale = (outer_rx * 2) / _spr_w;
        var _yscale = (outer_ry * 2) / _spr_h;
        //draw_sprite_ext(bg_sprite, 0, x, y, _xscale, _yscale, 0, c_white, 1);
		draw_sprite_ext(bg_sprite, 0, x, y, image_xscale * 0.99,image_xscale * 0.99, 0, c_white, 0.5);
    }
    
    // --- 2. Подготовка к рисованию "заливки" ---
    var _progress = clamp(progress, 0, 1);
    if (_progress <= 0) {
        return;
    }
	
    if (!surface_exists(global.primitive_surface)) {
		global.primitive_surface = surface_create(256, 256);
        //show_debug_message("ОШИБКА: primitive_surface не существует!");
        //return; 
    }	
	surface_set_target(global.primitive_surface);
    draw_clear_alpha(color, 0);
    var surf_x = 128;
    var surf_y = 128;
	
	
    // --- 3. Расчет геометрии ---
    var _start_angle = -90; 
    var _angle_to_draw = -(_progress * 360);
    var _end_angle = _start_angle - _angle_to_draw;
    var _angle_step = 1; 
    
    // --- 4. Рисование примитива ---
    draw_set_color(color);
    draw_primitive_begin(pr_trianglestrip);
    
    for (var i = _start_angle; i < _end_angle; i += _angle_step) {
        var _x_outer = surf_x + lengthdir_x(outer_rx, i);
        var _y_outer = surf_y - lengthdir_y(outer_ry, i); 
        var _x_inner = surf_x + lengthdir_x(inner_rx, i);
        var _y_inner = surf_y - lengthdir_y(inner_ry, i);
        
        draw_vertex(_x_outer, _y_outer);
        draw_vertex(_x_inner, _y_inner);
    }
    
    var _x_outer_end = surf_x + lengthdir_x(outer_rx, _end_angle);
    var _y_outer_end = surf_y - lengthdir_y(outer_ry, _end_angle);
    var _x_inner_end = surf_x + lengthdir_x(inner_rx, _end_angle);
    var _y_inner_end = surf_y - lengthdir_y(inner_ry, _end_angle);
    
    draw_vertex(_x_outer_end, _y_outer_end);
    draw_vertex(_x_inner_end, _y_inner_end);
    
    draw_primitive_end();
	
    surface_reset_target();
    
    draw_set_color(c_white); // Для surface цвет должен быть белым, чтобы не искажать цвета
    draw_set_alpha(1.0);   // Рисуем surface с полной непрозрачностью	
	
    draw_surface(global.primitive_surface, x - surf_x, y - surf_y);	
	
    draw_set_color(c_white);
}