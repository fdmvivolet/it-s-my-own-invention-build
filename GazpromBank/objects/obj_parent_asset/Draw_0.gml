// --- obj_parent_asset: Draw Event (ИСПРАВЛЕННАЯ ВЕРСИЯ) ---
/// @description Отрисовка актива, прогресс-бара и индикатора готовности

// 1. Рисуем основной спрайт объекта
draw_self();
/*
var _time_elapsed = base_timer_seconds - timer_current;
var _progress_percent = (_time_elapsed / base_timer_seconds) * 100;
    
var _indicator_x = x + 12 * image_xscale;
var _indicator_y = y - 95 * image_yscale;
    
var scale_mult = 71/5; // <--- ПОДБЕРИТЕ ЭТОТ КОЭФФИЦИЕНТ
    
draw_elliptical_progress(
    _indicator_x,
    _indicator_y,
    _progress_percent/100,
    4.9 * scale_mult,  // outer_rx
    2.85 * scale_mult, // outer_ry
    2.8 * scale_mult,  // inner_rx
    1.7 * scale_mult,  // inner_ry
    #DEE1EE,
    spr_ring_black
);

*/
// 2. ОТРИСОВКА ПРОГРЕСС-БАРА
var _sfx_id = obj_sfx_manager
array_delete(_sfx_id.ring_structs, 0, array_length(_sfx_id.ring_structs))
if (timer_current > 0 && !is_ready_to_collect) {

	
	
    var _time_elapsed = base_timer_seconds - timer_current;
    var _progress_percent = (_time_elapsed / base_timer_seconds) * 100;
	var _indicator_x = x + 12 * image_xscale;
	var _indicator_y = y - 95 * image_yscale;
    var scale_mult = 71/5; // <--- ПОДБЕРИТЕ ЭТОТ КОЭФФИЦИЕНТ    
    
	var ring_struct = {
		progress : _progress_percent/100,
		x : _indicator_x,
		y : _indicator_y,
		scale : scale_mult * image_xscale
	}
	
	array_push(_sfx_id.ring_structs, ring_struct)
	
	draw_elliptical_progress(
        _indicator_x,
        _indicator_y,
        _progress_percent/100,
        4.9 * scale_mult * image_xscale,  // outer_rx
        2.85 * scale_mult * image_yscale, // outer_ry
        2.8 * scale_mult * image_xscale,  // inner_rx
        1.7 * scale_mult * image_yscale,  // inner_ry
        #DEE1EE,
		spr_ring_black
    );
}

// 3. ОТРИСОВКА ИНДИКАТОРА ГОТОВНОСТИ
if (is_ready_to_collect) {
    //draw_set_color(c_yellow);
    //draw_circle(x, y, sprite_width/2+2, false);
    //draw_set_color(c_white);
}

//draw_text(x+25, y-150, is_ready_to_collect)
//draw_text(x-25, y-50, timer_current)