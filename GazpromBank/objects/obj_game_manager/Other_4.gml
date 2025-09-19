/// @description Insert description here
// You can write your code in this editor
if room_get_name(room) == "rm_main_game"
{
	world_init_tiles();
	load_world_from_data();
	game_state = GameState.GAMEPLAY;
}else
{
	show_debug_message("room != rm_main_game")	
}