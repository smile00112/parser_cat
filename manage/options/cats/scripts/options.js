$(document).ready(function(){
	// Сохранение настройки
	$('.saveOption').on('change', function(){
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
			url: $('.options').attr('data-url'),
			type: 'post',
			dataType: 'json',
			data: {
				action:	'save-option',
				id:			$element.closest('.element-string').attr('data-id'),
				value:	value
			},
			success: function(data){
				if(data.error){var className = 'error'}else{var className = 'success'}
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
});
// Вывод подсказки
function ShowCallout($callout, text, className){
	$callout.addClass(className).html(text).show();
	setTimeout(function(){
		$callout.removeClass(className).hide();
	},2000);
}