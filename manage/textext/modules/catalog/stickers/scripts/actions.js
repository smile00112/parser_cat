$(document).ready(function(){
	// Сохранения значения поля стикера
	$('input').on('change', function(){
		var $input = $(this),
				$callout = $(this).siblings('.callout');
		$.ajax({
			url: 'actions.html',
			type: 'post',
			dataType: 'json',
			data: {
				action: 'save-sticker-field',
				id: $input.closest(".sticker-string").attr('data-id'),
				field: $input.attr('name'),
				value: $input.val()
			},
			success: function(data){
				if(data.error){
					$callout.addClass('error');
				}
				$callout.html(data.text).show('slow');
				setTimeout(function(){
					$callout.hide('slow').removeClass('error');
				}, 2000);
			},
			error: function(response) {
				$callout.addClass('error').html('Ошибка сохранения значения').show('slow');
				setTimeout(function(){
					$callout.hide('slow').removeClass('error');
				}, 2000);
			},
			complete: function(response){
				$('.wait').hide();
			}
		});
	});
	// Удаление стикера
	$('.delete').on('click', function(){
		if (confirm('Вы действительно хотите удалить этот стикер?')){
			var $sticker = $(this).closest(".sticker-string"),
					$callout = $sticker.children('.callout');
			$('.wait').show();
			$.ajax({
				url: 'actions.html',
				type: 'post',
				dataType: 'json',
				data: {
					action: 'delete-sticker',
					id: $sticker.attr('data-id')
				},
				success: function(data){
					if(!data.error){
						$sticker.fadeTo('slow', 0, function() {
							$sticker.remove();
							if($('.sticker-string').length == 0){
								$('.no-stickers').fadeTo('slow', 1);
							}
						});
					} else {
						$callout.addClass('error').html(data.text).show('slow');
						setTimeout(function(){
							$callout.hide('slow').removeClass('error');
						}, 2000);
					}
				},
				error: function(response) {
					$callout.addClass('error').html('Ошибка удаления стикера').show('slow');
					setTimeout(function(){
						$callout.hide('slow').removeClass('error');
					}, 2000);
				},
				complete: function(response){
					$('.wait').hide();
				}
			});
		}
	});

	// Добавление стикера
	$('#add-sticker form').on('submit', function(event){
		event.preventDefault();
		var allTyped = true;
		if( $('input[name=name]').val() == '' ){
			allTyped = false;
			ShowCallout($('input[name=name]').siblings('.callout'), 'Укажите имя стикера');
		}
		if( $('select[name=color_id] option:selected')[0].disabled ){
			allTyped = false;
			ShowCallout($('select[name=color_id]').siblings('.callout'), 'Укажите цвет стикера');
		}
		if(allTyped){
			$('.wait').show();
			var $form = $(this);
			$.ajax({
				url: $form.attr('action'),
				type: 'post',
				dataType: 'json',
				data: $form.serialize(),
				success: function(data){
					$form.slideUp('slow', function(){
						$('.message').html(data.text).show();
						if(!data.error){
							var handler = function(){
								parent.$.fancybox.close();
								location.reload(true);
							}
						} else {
							$('.message').addClass('red');
							var handler = function(){
								$('.message').removeClass('red').hide();
								$form.slideDown('slow');
							};
						}
						setTimeout(handler, 1500);
					});
				},
				error: function(response) {
					$form.slideUp('slow', function(){
						$('.message').addClass('red').html('Ошибка выполнения').show();
						setTimeout(function(){
							$('.message').hide().removeClass('red');
							$form.slideDown('slow');
						}, 1500);
					});
					console.log(response);
				},
				complete: function(response){
					$('.wait').hide();
				}
			});
		}
	});

	// Drag'n'drop
	dragula([document.querySelector('.stickers-blocks')],{
		direction: 'vertical',
		moves: function (el, container, handle){
			return handle.classList.contains('move');
		}
	}).on('drop', function (element){
		var changeFlag = false,
				errorCount = 0;
		// Проверяем все блоки
		$('.stickers-blocks div[data-id]').each(function(index){
			var position = index+1,
					currentElement = $(this);
			// Если позиция изменилась
			if(position != $(this).attr('data-position')){
				changeFlag = true;
				$.post("actions.html", { action: "save-sticker-field", id: $(this).attr("data-id"), field: 'sortir', value: position }, function(data){
					data = JSON.parse(data);
					if(data.error){
						errorCount += 1;
					} else {
						currentElement.attr('data-position', position);
					}
				});
			}
		});
		// Если было какое-то изменение
		if(changeFlag){
			var $callout = $(element).children('.callout');
			console.log($callout);
			if(errorCount>0){
				var message='Ошибка сохранения позиции';
				$callout.addClass('error');
			} else {
				var message='Позиция сохранена';
			}
			$callout.html(message).show('slow');
			setTimeout(function(){
				$callout.hide('slow').removeClass('error');
			}, 2000);
		}
	});

});

function ShowCallout($callout, text){
	$callout.html(text).show();
	setTimeout(function(){
		$callout.hide();
	},2000);
}