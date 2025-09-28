/// @description Insert description here
// You can write your code in this editor

bloom_layer = layer_create(depth - 1, "bloom_layer")
_blur = fx_create("_effect_gaussian_blur")
fx_set_parameter(_blur, "g_numDownsamples", 2);
fx_set_parameter(_blur, "g_numPasses", 2);
fx_set_single_layer(_blur, true)
layer_set_fx(bloom_layer, _blur)