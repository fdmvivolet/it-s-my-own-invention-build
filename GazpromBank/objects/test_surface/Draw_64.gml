/// @description DEBUG: Отображение содержимого global.primitive_surface

// --- Защита от ошибок ---
// Рисуем, только если поверхность существует
if (!surface_exists(global.primitive_surface)) {
    // Если surface нет, рисуем красный текст, чтобы сообщить об этом.
    draw_set_color(c_red);
    draw_text(10, 10, "primitive_surface НЕ СУЩЕСТВУЕТ!");
    return; // Выходим, чтобы не было ошибок
}

// --- Рисуем рамку и фон для наглядности ---
var _debug_x = 10;
var _debug_y = 10;
var _surf_w = surface_get_width(global.primitive_surface);
var _surf_h = surface_get_height(global.primitive_surface);

// Рисуем черный фон под поверхностью, чтобы было видно альфа-канал
draw_set_color(c_black);
draw_rectangle(_debug_x, _debug_y, _debug_x + _surf_w, _debug_y + _surf_h, false);

// --- Рисуем саму поверхность ---
// draw_surface рисует поверхность как текстуру.
// Мы используем c_white и alpha=1.0, чтобы отобразить ее "как есть", без искажения цветов.
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_surface(global.primitive_surface, _debug_x, _debug_y);

// Рисуем белую рамку поверх, чтобы было видно границы
draw_set_color(c_white);
draw_rectangle(_debug_x, _debug_y, _debug_x + _surf_w, _debug_y + _surf_h, true); // true = контур

// Рисуем подпись
draw_text(_debug_x, _debug_y + _surf_h + 5, "Debug: global.primitive_surface");