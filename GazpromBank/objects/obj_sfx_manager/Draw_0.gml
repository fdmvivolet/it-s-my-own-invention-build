/// @description Insert description here
// You can write your code in this editor
for (var i = 0; i < array_length(ring_structs); i++){
	var _ring = ring_structs[i]
	
	
	draw_elliptical_progress(
        _ring.x,
        _ring.y,
        _ring.progress,
        4.9 * _ring.scale,  // outer_rx
        2.85 * _ring.scale, // outer_ry
        2.8 * _ring.scale,  // inner_rx
        1.7 * _ring.scale,  // inner_ry
        #DEE1EE,
		//spr_ring_black
    );		
	
}