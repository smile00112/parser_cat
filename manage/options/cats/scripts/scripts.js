$(document).ready(function(){
	// Сохранение значения
	$('.save').on('change', function(){
		var $element = $(this),
				$callout = $(this).siblings('.callout');
		if(this.tagName.toLowerCase()=='input' && this.type=='checkbox'){
			if($element.prop('checked')){
				value = 1;
			} else {
				value = 0;
			}
		} else {
			value = $element.val();
		}
		$('.wait').show();
		$.ajax({
			url: $('.fields').attr('data-url'),
			type: 'post',
			dataType: 'json',
			data: {
				action:	'save-field',
				id:			$element.closest('.element-string').attr('data-id'),
				field:	$element.attr('name'),
				value:	value
			},
			success: function(data){
				if(data.error){var className = 'error'}else{var className = 'success'}
				// Для видимости указываем title
				if($element.attr('name')=='visible'){
					var title = 'Отобразить';
					if(value){
						title = 'Скрыть';
						$element.closest('.element-string').find('select,input:not([name=visible])').removeAttr('disabled');
					} else {
						$element.closest('.element-string').find('select,input:not([name=visible])').attr('disabled', 'disabled');
					}
					$element.siblings('label').attr('title', title);
				}
				ShowCallout($callout, data.text, className);
			},
			error: function(response){
				ShowCallout($callout, 'Ошибка сохранения значения', 'error');
			},
			complete: function(response){
				$('.wait').hide();
			}
		});
	});

	$('.save_p').on('change', function(){
		var $element = $(this),
				$callout = $(this).siblings('.callout');
		if(this.tagName.toLowerCase()=='input' && this.type=='checkbox'){
			if($element.prop('checked')){
				value = 1;
			} else {
				value = 0;
			}
		} else {
			value = $element.val();
		}
		
		//Велосипед для назначения помёта коту, т.к. другая табл,
		if($element.attr('name') == 'kitens'){
				
			$('#pom-kitens option:selected').each(function() {
				var catid = $(this).val();
				var pomet = $element.closest('.element-string').attr('data-id'); 
				var field = 'pomet';
				
				$.ajax({
					url: $('.fields').attr('data-url'),
					type: 'post',
					dataType: 'json',
					data: {
						action:	'save-field',
						id:		catid,
						field:	field,
						value:	pomet
					},
					success: function(data){
						if(data.error){var className = 'error'}else{var className = 'success'}
						// Для видимости указываем title
						if($element.attr('name')=='visible'){
							var title = 'Отобразить';
							if(value){
								title = 'Скрыть';
								$element.closest('.element-string').find('select,input:not([name=visible])').removeAttr('disabled');
							} else {
								$element.closest('.element-string').find('select,input:not([name=visible])').attr('disabled', 'disabled');
							}
							$element.siblings('label').attr('title', title);
						}
						ShowCallout($callout, data.text, className);
					},
					error: function(response){
						ShowCallout($callout, 'Ошибка сохранения значения', 'error');
					},
					complete: function(response){
						$('.wait').hide();
					}
				});
			});


		}
		//	else alert($element.attr('name'))


		return false;

		$('.wait').show();
		$.ajax({
			url: $('.fields').attr('data-url'),
			type: 'post',
			dataType: 'json',
			data: {
				action:	'save-field-pomet',
				id:			$element.closest('.element-string').attr('data-id'),
				field:	$element.attr('name'),
				value:	value
			},
			success: function(data){
				if(data.error){var className = 'error'}else{var className = 'success'}
				// Для видимости указываем title
				if($element.attr('name')=='visible'){
					var title = 'Отобразить';
					if(value){
						title = 'Скрыть';
						$element.closest('.element-string').find('select,input:not([name=visible])').removeAttr('disabled');
					} else {
						$element.closest('.element-string').find('select,input:not([name=visible])').attr('disabled', 'disabled');
					}
					$element.siblings('label').attr('title', title);
				}
				ShowCallout($callout, data.text, className);
			},
			error: function(response){
				ShowCallout($callout, 'Ошибка сохранения значения', 'error');
			},
			complete: function(response){
				$('.wait').hide();
			}
		});
	});
	// Имя поля не должно содержать недопустимых символов
	/*$('input[name=name]').on('keyup', function(){
		value = this.value.toLowerCase();
		this.value = value.replace(/[^a-z1-9_]/, '');
	});
	*/
	// Сохранения имени поля
	/*$('input[name=name]').on('change', function(){
		var $element = $(this),
				$callout = $(this).siblings('.callout'),
				oldName = $element.attr('data-prev'),
				newName = $element.val();
		$('.wait').show();
		$.ajax({
			url: $('.fields').attr('data-url'),
			type: 'post',
			dataType: 'json',
			data: {
				action:	'rename-field',
				id:			$element.closest('.element-string').attr('data-id'),
				field:	$element.attr('name'),
				old_name:	oldName,
				new_name:	newName
			},
			success: function(data){
				if(data.error){
					var className = 'error';
					$element.val(oldName);
				}else{
					var className = 'success';
					$element.attr('data-prev', newName)
				}
				ShowCallout($callout, data.text, className);
			},
			error: function(response){
				$element.val(oldName);
				ShowCallout($callout, 'Ошибка сохранения значения', 'error');
			},
			complete: function(response){
				$('.wait').hide();
			}
		});
	});
	*/
	// Drag'n'drop
	dragula([document.querySelector('.fields')],{
		direction: 'vertical',
		moves: function (el, container, handle){
			return handle.classList.contains('move');
		}
	}).on('drop', function (element){
		var changeFlag = false,
				errorCount = 0,
				sortField = $('.fields').attr('data-sort-field');
		// Проверяем все блоки
		$('.fields .element-string').each(function(index){
			var position = index+1,
					currentElement = $(this);
			// Если позиция изменилась
			if(position != $(this).attr('data-position')){
				changeFlag = true;
				$.post("actions.html", { action: "save-field", id: $(this).attr("data-id"), field: sortField, value: position }, function(data){
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
			var $callout = $(element).find('.move-button .callout');
			if(errorCount>0){
				var message='Ошибка сохранения позиции',
						className = 'error';
			} else {
				var message='Позиция сохранена',
						className = 'success';
			}
			ShowCallout($callout, message, className)
		}
	});
	// Drag'n'drop 2
	dragula([document.querySelector('.fields2')],{
		direction: 'vertical',
		moves: function (el, container, handle){
			return handle.classList.contains('move');
		}
	}).on('drop', function (element){
		var changeFlag = false,
				errorCount = 0,
				sortField = $('.fields2').attr('data-sort-field');
		// Проверяем все блоки
		$('.fields2 .element-string').each(function(index){
			var position = index+1,
					currentElement = $(this);
			// Если позиция изменилась
			if(position != $(this).attr('data-position')){
				changeFlag = true;
				$.post("actions.html", { action: "save-field-pomet", id: $(this).attr("data-id"), field: sortField, value: position }, function(data){
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
			var $callout = $(element).find('.move-button .callout');
			if(errorCount>0){
				var message='Ошибка сохранения позиции',
						className = 'error';
			} else {
				var message='Позиция сохранена',
						className = 'success';
			}
			ShowCallout($callout, message, className)
		}
	});
});
// Вывод подсказки
function ShowCallout($callout, text, className){
	$callout.addClass(className).html(text).show();
	setTimeout(function(){
		$callout.removeClass(className).hide();
	},2000);
}

$(document).ready(function(){

	$(".kittens-select").chosen(
		{
			width: "100%"
		}
	);

	$('#kittensselect').click(function(){
		var len = document.getElementById("kittensselect").options.length;
		var SelectElements = [];
		var i=0;
		for (var n = 0; n < len; n++)
		{
			console.log(n)
		  if (document.getElementById("kittensselect").options[n].selected==true)
		  {
		   SelectElements[i]=document.getElementById("kittensselect").options[n].value;
	
				 i++;
		  }
	
		}
		if(SelectElements.length){
			$('#kittens').val(SelectElements.join());
		}
	})

	$(".editFoto").click(function(){
		var id = $(this).parents('.foto').data('id')*1;
		if(id>0)
			$("#cat_id").val(id);
	})

	$(".addPometForm").fancybox({
		padding:     5,
		maxWidth:    800,
		maxHeight:   600,
		fitToView:   false,
		autoSize:    true,
		closeClick:  false,
		openEffect:  'none',
		closeEffect: 'none'
	});


	$(".editFoto").fancybox({
		padding:     5,
		maxWidth:    800,
		maxHeight:   600,
		fitToView:   false,
		autoSize:    true,
		closeClick:  false,
		openEffect:  'none',
		closeEffect: 'none'
	});

	$(".addForm").fancybox({
		padding:     5,
		maxWidth:    800,
		maxHeight:   600,
		fitToView:   false,
		autoSize:    true,
		closeClick:  false,
		openEffect:  'none',
		closeEffect: 'none'
	});

	if(localStorage.getItem('curtab')){
		$('[data-tabname="'+localStorage.getItem('curtab')+'"]').click();
	}else{
		$('[data-tabname="cats-list"]').click();
	}
});	

$(document).on("click", ".tabname", function(){
	$(".tabname").removeClass("active");
	$(this).addClass("active");
	$("div.tabcontent").hide();
	$("div[data-tabcontent='"+$(this).data('tabname')+"']").show();


	localStorage.setItem('curtab', $(this).data('tabname'))
});