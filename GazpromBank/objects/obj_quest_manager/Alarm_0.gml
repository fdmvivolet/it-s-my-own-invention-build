/// @description Insert description here
// You can write your code in this editor
if obj_ui_manager.current_ui_state == UIState.HIDDEN{
	quest_window_visited = true
	trigger_one_time_event("TasksReminder", {tutorial_id: "TasksReminder"});	
}else{
	alarm[0] = 10	
}