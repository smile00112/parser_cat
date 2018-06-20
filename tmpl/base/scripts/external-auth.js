function HandleToken(token){
	jQuery.ajax({
		url: $('.external-auth').attr('data-url'),
		type: 'POST',
		dataType: 'json',
		data: {token: token},
		success: function(answer){
			if(answer.error){
				ShowMessage(answer.text);
			} else {
				if(answer.auth){
					location.reload();
				} else {
					var lefto = screen.availWidth/2-400,
							righto = screen.availHeight/2-325;
							window.open($('.external-auth').attr('data-url-choice')+"?account_id="+answer.account_id,"Авторизация","menubar=no, toolbar=no, location=no, directories=no, status=no, resizable=no, scrollbars=no, width=720, height=600, left=" + lefto + ", top="+righto+"");
				}
			}
		},
		error: function(response) {
			ShowMessage('Ошибка получения информации');
		}
	});
}