$(document).ready(function(){
	var jcrop,
			actionClick = false,
			defaultCropRegion;
	// Открыть в Fancybox
	$('.open').on('click', function(){
		if($(this).hasClass('add-image')){actionClick = true;}
		$(this).OpenFancybox();
	});
	// Drag'n'drop
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
	// Нажатие на элемент
	$('.element').on('click', function(){
		if(!actionClick){
			if($(this).hasClass('video')){
				$(this).OpenFancybox();
			} else {
				$(this).siblings('.string').find('.open-folder')[0].click();
			}
		}
		actionClick = false;
	});

	// Видимость видео
	$('.visible').on('click', function(){
		var id			= $(this).closest(".block_video").attr("data-id"),
				object	= $(this);
		$.post("actions.html", { action: "update_visible", id: id }, function(data){
			var data = JSON.parse(data),
					className = '';
			if(!data.error){
				className = 'success';
			} else {
				className = 'error';
			}
			if(!data.error){
				if(!data.visible){
					object.removeClass('true').addClass('false');
				} else {
					object.removeClass('false').addClass('true');
				}
			}
			$('#visible_'+id).html(data.text).addClass(className).show();
			setTimeout(function(){
				$('#visible_'+id).removeClass(className).hide();
			},1000);
		});
	});
	// Удаление видео
	$('.delete').on('click', function(){
		if (confirm('Вы действительно хотите удалить это видео?')){
			var object	= $(this).closest(".block_video");
			$.post("actions.html", { action: "delete", id: object.attr("data-id") }, function(data){
				data = JSON.parse(data);
				if(!data.error){
					object.fadeTo("slow", 0, function() {
						object.remove();
						if($('.block_video').length == 0){
							$('.no-videos').fadeTo("slow", 1);
						}
					});
				}
			});
		}
	});
	// Удаление изображения
	$('.remove').on('click', function(){
		actionClick = true;
		if (confirm('Вы действительно хотите удалить это изображение?')){
			var object = $(this).closest(".image");
			$.post("actions.html", { action: "delete_image", id: object.closest(".block_video").attr("data-id") }, function(data){
				data = JSON.parse(data);
				if(!data.error){
					object.addClass('empty').css('background-image','none');
				}
			});
		}
	});
	// Обрезка изображения
	$('.crop').on('click', function(){
		actionClick = true;
		var elementID = parseInt($(this).closest('.block_video').attr('data-id'));
		$('.crop-form').data('elementId', elementID).attr('data-element-id', elementID);
		var data = $('.crop-form').data(),
				img = new Image();

		img.src= $(this).attr('data-image');
		img.onload = function(){
			$('.crop-form img').replaceWith(img);
			defaultCropRegion = GetDefaultCropRegion(img, data.ratio);
			jcrop = $.Jcrop('.crop-form img',{
				aspectRatio: data.ratio,
				minSize: [ data.minWidth, data.minHeight ],
				setSelect: defaultCropRegion
			});
			$.fancybox($('.crop-form'),{
				beforeClose: function(){
					jcrop.destroy();
				}
			});
		}
	});
	// Генерирует м ассив координат обрезки по умолчанию
	GetDefaultCropRegion = function(img, ratio){
		var maxHeight = Math.round(img.width/ratio);
		if(maxHeight > img.height){
			var maxHeight = img.height,
					maxWidth = Math.round(maxHeight*ratio);
		} else {
			var maxWidth = img.width;
		}
		var answer = [0, 0, 10000, 10000];
		answer[0] = Math.round(Math.abs(maxWidth-img.width)/2);
		answer[1] = Math.round(Math.abs(maxHeight-img.height)/2);
		answer[3] = answer[0]+maxWidth;
		answer[4] = answer[1]+maxHeight;
		return answer;
	}
	// "По умолчанию" при обрезке
	$('.reset-button').on('click', function(){
		jcrop.animateTo(defaultCropRegion);
	});
	// Обрезка изображения и вывод результата
	$('.crop-button').click(function(event){
		var cropData = jcrop.tellSelect(),
				elementID = $('.crop-form').data('elementId'),
				data = {
					'action': 'crop_image',
					'element_id': elementID,
					'x': Math.round(cropData.x),
					'y': Math.round(cropData.y),
					'width': Math.round(cropData.w),
					'height': Math.round(cropData.h)
				};
		$.ajax({
			url: 'actions.html',
			type: 'POST',
			dataType: 'json',
			data: data,
			success: function(answer){
				if(!answer.error){
					var $img = $('#image_'+elementID),
							regexp = /url\("(.*)"\)/g,
							imgURL = regexp.exec($img.css('background-image'))[1].split('?')[0] + '?' + Math.random();
					$img.css('background-image','url('+imgURL+')');
				}
			},
			error: function(response) {
				console.log(response);
			},
			complete: function(response){
				parent.$.fancybox.close();
				jcrop.destroy();
			}
		});
	});
	// Сохранение текстового поля
	$('.save').on('change', function(){
		var id			= $(this).closest(".block_video").attr("data-id"),
				field		= $(this).attr("name"),
				object	= $(this);
		$.post("actions.html", { action: "save_field", id: id, field: field, value: $(this).val() }, function(data){
			var data = JSON.parse(data),
					className = '';
			if(!data.error){
				className = 'success';
			} else {
				className = 'error';
			}
			$('#'+field+'_'+id).html(data.text).addClass(className).show();
			setTimeout(function(){
				$('#'+field+'_'+id).removeClass(className).hide();
			},1000);
		});
	});

});