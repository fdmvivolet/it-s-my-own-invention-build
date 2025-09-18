if (device_mouse_check_button_pressed(0, mb_left) &&
    position_meeting(device_mouse_x(0), device_mouse_y(0), id) &&
    obj_dragdrop_manager.dragged_sprite == noone)
{

    obj_dragdrop_manager.dragged_sprite = spr_gem;
    // audio_play_sound(snd_pickup, 1, false);
}