$(document).ready(function(){

	dragula([document.querySelector('.videos')]).on('drop', function (element){
		var changeFlag = false,
				errorCount = 0;
		// Проверяем все блоки
		$('.videos .block_video').each(function(index){
			var position = index+1,
					currentElement = $(this);
			// Если позиция изменилась
			if(position != $(this).attr('data-position')){
				changeFlag = true;
				$.post("actions.html", { action: "save_field", id: $(this).attr("data-id"), field: 'sortir', value: position }, function(data){
					data = JSON.parse(data);
					if(data.error){
						errorCount += 1;
					} else {
						currentElement.attr('data-position', position);
					}
				});
			}
			// Если было какое-то изменение
			if(changeFlag){
				if(errorCount>0){
					var message='Ошибка сохранения позиции';
				} else {
					var message='Позиция сохранена';
				}
				$(element).find(".message").html(message).show("slow");
				setTimeout(function(){
					$(element).find(".message").hide("slow");
				}, 1000);
			}
		});
	});
	// Видимость видео
	$('.visible').on('click', function(){
		var id			= $(this).closest(".block_video").attr("data-id"),
				object	= $(this);
		$.post("actions.html", { action: "update_visible", id: id }, function(data){
			data = JSON.parse(data);
			if(!data.error){
				if(!data.visible){
					object.removeClass('true').addClass('false');
				} else {
					object.removeClass('false').addClass('true');
				}
				object.closest('.block_video').find(".message").html(data.text).show("slow");
				setTimeout(function(){
					object.closest('.block_video').find(".message").hide("slow");
				}, 1000);
			}
		});
	});
	// Удаление видео
	$('.delete').on('click', function(){
		if (confirm('Вы действительно хотите удалить это видео?')){
			var id			= $(this).closest(".block_video").attr("data-id"),
					object	= $(this).closest(".block_video");
			$.post("actions.html", { action: "delete", id: id }, function(data){
				data = JSON.parse(data);
				if(!data.error){
					object.fadeTo("slow", 0, function() {
						object.remove();
					});
				}
			});
		}
	});
	// Сохранение текстового поля
	$('.save').on('change', function(){
		var id			= $(this).closest(".block_video").attr("data-id"),
				field		= $(this).attr("name"),
				value		= $(this).val(),
				object	= $(this);
		$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
			data = JSON.parse(data);
			if(!data.error){
				object.addClass("green_border");
				setTimeout(function(){
					object.removeClass("green_border");
				},1000);
			}
		});
	});

	$('.video').on('click', function(){
			$(this).OpenFancybox();
	});

});