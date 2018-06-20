$(document).ready(function(){

	window.onbeforeunload = null;

	$('form').on('submit', function(event){
		event.preventDefault();
		var $input = $("input[name=redirect]"),
				value = $input.val(),
				url = window.location.protocol+'//'+document.location.host+'/';
		if(value[0] === '/'){
			value = window.location.protocol+'//'+document.location.host+value;
		}
		if(value !== ''){url = value;}
		$.ajax({
			url: '../actions.html',
			type: 'POST',
			dataType: 'json',
			data: { action: 'check_url', url: url },
			success: function(answer){
				if(!answer.error){
					var status = new Object();
					switch(answer.file.status){
						case 200:
							status.error = false;
							status.text = 'Валидный URL';
							break;
						case 301:
						case 302:
						case 303:
						case 307:
							status.error = true;
							status.text = 'Это не прямой URL. На нём работает '+answer.file.status+' redirect';
							break;
						case 404:
							status.error = true;
							status.text = 'Этот URL ведёт на несуществующую страницу';
							break;
						default:
							status.error = true;
							status.text = 'Вы ввели неверный URL (Статус ответа:'+answer.file.status+')';
					}
					if(!status.error){
						var pos = value.indexOf(document.location.host),
								withChilds;
						if(~pos){
							value = value.substring(pos+document.location.host.length);
							$input.val(value)
						}
						if($("input[name=withChilds]").prop("checked")){ withChilds = 1;} else { withChilds = 0;}
						$.ajax({
							url: '../actions.html',
							type: 'POST',
							dataType: 'json',
							data: { action: 'save_redirect', element_id: $input.closest('form').attr('data-id'), value: value, withChilds: withChilds },
							success: function(answer){
								if(!answer.error){
									$(".ok").fadeIn();
									setTimeout(function(){
										$('.ok').fadeOut();
									},1000);
								} else {
									ShowMessage(answer.text);
								}
							},
							error: function(response) {
								ShowMessage('Произошла ошибка');
							}
						});
					} else {
						console.log(status);
						ShowMessage(status.text);
					}
				} else {
					ShowMessage('Вы ввели неверный URL');
				}
			},
			error: function(response) {
				ShowMessage('Произошла ошибка');
			}
		});
	});

	$('.save').on('click', function(){
		$(this).closest('form').submit();
	});

	$('.label').on('click', function(){
		$('input[name=withChilds]').click();
	});

});