$(document).ready(function(){

	$(window).scroll(function(){
		if ($(this).scrollTop() > 300){
			$('a#move_up').fadeIn('slow');
		} else {
			$('a#move_up').fadeOut('slow');
		}
	});

	$('a#move_up').click(function(event){
		event.preventDefault();
		$('body,html').animate({ scrollTop: 0}, 'slow');
	});

});
// Отображение сообщения
function ShowMessage(message) {
	$.fancybox(message,{
		minWidth: 'auto',
		minHeight: 'auto',
		helpers: {
			overlay: {
				locked: false
			}
		}
	});
}