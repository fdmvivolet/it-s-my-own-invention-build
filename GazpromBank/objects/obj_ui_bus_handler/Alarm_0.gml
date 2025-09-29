/// @description Insert description here
// You can write your code in this editor
if obj_ui_manager.current_ui_state != UIState.HIDDEN{
	alarm[0] = 10	
	show_debug_message("IMA TRYING START THIS" + show_debug_message(queue_data)) 
	//queue_data = data
}else{
	show_message("IT SHOULKD START")
	on_tutorial_triggered(queue_data)	
}