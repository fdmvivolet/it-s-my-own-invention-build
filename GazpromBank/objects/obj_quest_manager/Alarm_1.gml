/// @description Insert description here
// You can write your code in this editor

if obj_ui_manager.current_ui_state == UIState.HIDDEN{
	trigger_one_time_event("FirstFieldFull", {tutorial_id : "FirstFieldFull"})
}else{
	alarm[1] = 10	
}