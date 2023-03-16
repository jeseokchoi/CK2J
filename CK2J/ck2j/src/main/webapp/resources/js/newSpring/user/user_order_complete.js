function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        
        alert('주문이 완료 되었습니다.')
		location.href= cpath
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
    	alert('주문이 완료 되었습니다.')
		location.href= cpath
        return false;
    }
}
