if (device_mouse_check_button_released(0, mb_left) &&
    obj_dragdrop_manager.dragged_sprite != noone)
{
    if (position_meeting(device_mouse_x(0), device_mouse_y(0), id))
    {
        held_sprite = obj_dragdrop_manager.dragged_sprite;
        obj_dragdrop_manager.dragged_sprite = noone;
        // audio_play_sound(snd_place, 1, false);
    }
}