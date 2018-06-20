$(document).ready(function(){

	if($('.message').hasClass('show')){
		setTimeout(function(){
			if($('.message').hasClass('red')){
				$('.message').removeClass('show').removeClass('red').hide().html();
				$('form').slideDown();
			} else {
				parent.$.fancybox.close();
				parent.location.reload(true);
			}
		}, 1000);
	}

	$('form').on('submit', function(event){
		var form = $(this),
				images = $('input[type=file]')[0].files,
				formData = new FormData(),
				answer = { error: false };
		if(images.length == 1){
			// Если не соответствует тип
			if(!images[0].type.match(/(.png)|(.jpeg)|(.jpg)|(.gif)$/i)){
				answer.error = true;
				answer.text = 'Неверный формат файла';
			} else {
				// Если превышен размер фото
				if((images[0].size / 1024).toFixed(0) > 1524){
					answer.error = true;
					answer.text = 'Размер файла слишком велик';
				}
			}
		} else {
			answer.error = true;
			answer.text = 'Не выбран файл';
		}
		if(answer.error){
			event.preventDefault();
			form.slideUp('slow', function(){
				$('.message').html(answer.text).addClass('red').show();
				setTimeout(function(){
					$('.message').removeClass('red').hide().html();
					form.slideDown();
				}, 1000);
			});
		}

	});

});