$(document).ready(function(){
	$(".zoom_picture").fancybox({
		helpers: {
			overlay: {
				locked: false
			}
		}
	});

	$("a.gallery-item").fancybox({
		padding	: 0,
		helpers	: {
			overlay: {
				locked: false
			},
			thumbs	: {
				width	: 150,
				height	: 100
			},
		}
	});

	$('.social-button').on('click', function(e){
		var is_https = window.location.href.substr(0, 5)=='https';
		var lefto = screen.availWidth/2-400;
		var righto = screen.availHeight/2-325;
		var network = 'vk';
		window.open("/modules/social/auth.html?from="+network,"Авторизация","menubar=no, toolbar=no, location=no, directories=no, status=no, resizable=no, scrollbars=no, width=720, height=600, left=" + lefto + ", top="+righto+"");
	});
});

function no_call_choice() {
	$("#choice-login ~ span").remove();
	$("#choice-password ~ span").remove();

	var msg = $('#choice_form').serialize();
	$.ajax({
		type:			'POST',
		url:			'/people?auth',
		data:			msg,
		success:	function(data) {
								var answer = eval("(" + data + ")");
								if(answer.error) {
									$("<span><span>"+answer.error+"</span></span>").insertAfter("#choice-"+answer.field);
								} else {
									location.reload();
								}
							}
	});
}