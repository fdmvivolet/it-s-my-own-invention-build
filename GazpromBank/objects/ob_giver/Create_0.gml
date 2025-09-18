function send_message(_message){
	
	var _data = {message : _message}
	EventBusBroadcast(EVENT_NAMES.SEND_MESSAGE, _data)
	
}

function Is_Deactivated(_data){
	show_debug_message("Ресивер Отключен")
}

EventBusSubscribe(EVENT_NAMES.DEACTIVATE_RECIEVER, id, Is_Deactivated)