function save_room()
{
	var _exampleNum = instance_number(ob_example)
	
	var _roomStruct =
	{
		exampleNum : _exampleNum,
		exampleData : array_create(_exampleNum),
	}

	global.statData.save_x = Ob_player.x;
	global.statData.save_y = Ob_player.y;

	for (var i = 0; i < _exampleNum; i++)
	{
		var _inst = instance_find(ob_example, i)
		
			_roomStruct.pathen2Data[i] =
			{
			x : _inst.x,
			y : _inst.y,
			}
	
	}
}


function load_room()
{
	global.isloading = true
	///что угодно	
	global.isloading = false
}
	

function save_game()
{
	var _saveArray = array_create(0)
	
	array_push(_saveArray, global.statData);
	
	var _filename = "savedata.sav";
	var _json = json_stringify(_saveArray);
	var _buffer = buffer_create (string_byte_length(_json) + 1, buffer_fixed, 1);
	buffer_write (_buffer, buffer_string, _json);
	
	buffer_save(_buffer, _filename);
	
	buffer_delete(_buffer);
	
}

function loadsave()
{
	var _filename = "savedata.sav";
	if !file_exists(_filename) {show_debug_message("file not exists"); exit}
	var _buffer = buffer_load(_filename);
	var _json = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _loadArray = json_parse(_json);
	///дальше че угодно
}
