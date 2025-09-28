/// @description Insert description here
// You can write your code in this editor
ring_structs = []

var lay_id = layer_get_id("Instances")
var lay_depth = layer_get_depth(lay_id)

/*
var bloom_layer = layer_create(-20000, "bloom_layer")
var _blur = fx_create("_effect_gaussian_blur")


fx_set_parameter(_blur, "g_numDownsamples", 1);
fx_set_parameter(_blur, "g_numPasses", 4);
fx_set_parameter(_blur, "g_intensity", 1);


fx_set_single_layer(_blur, true)
layer_set_fx(bloom_layer, _blur)
*/



//layer_add_instance(bloom_layer, id)
depth = -20000

//show_message(fx_get_single_layer(_blur))