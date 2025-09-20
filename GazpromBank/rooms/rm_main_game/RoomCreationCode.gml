if (!instance_exists(obj_display_manager)) {
    instance_create_layer(0, 0, "Instances", obj_display_manager);
}
/*
if (!instance_exists(obj_ui_manager)) {
    instance_create_depth(0, 0, -100500, obj_ui_manager);
}