/// @description Insert description here
// You can write your code in this editor
if room_get_name(room) == "rm_main_game"
{
	world_init_tiles();
	load_world_from_data();
	game_state = GameState.GAMEPLAY;
	
	var _tutorial_data = {
		tutorial_id: "FirstAssetPurchase" // <-- Это имя должно ТОЧНО совпадать с ключом в game_config
	};			
	
	trigger_one_time_event("TutorialTriggered", _tutorial_data);	
	
	//if (!surface_exists(global.primitive_surface)) {
    //global.primitive_surface = surface_create(256, 256);
    //show_debug_message("Game Manager: Создана поверхность 'primitive_surface' (256x256).");}

	
}else
{
	show_message("Настоятельно рекомендуется включить \"Версию для ПК\" на случай, если игра будет в низком качестве.\nСпасибо за внимание! ")
	show_debug_message("room != rm_main_game")	
}