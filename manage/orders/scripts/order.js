$(document).ready(function(){
//	Открывает информацию о заказе при нажатии на строку заказа
	$('select, textarea').on('change', function(event){
		var $element = $(this),
				$form = $element.closest('form'),
				$callout = $element.siblings('.callout');
		$.ajax({
			url: $form.attr('data-url'),
			type: 'post',
			dataType: 'json',
			data: {
				action: 'update_order_field',
				order_id: $form.attr('data-order-id'),
				field: $element.attr('name'),
				value: $element.val()
			},
			success: function(data){
				var params = { fadeTime: 500 };
				if(data.error){
					params.class = 'error';
					params.showTime = 2000;
				} else {
					params.class = 'success';
					params.showTime = 1000;
				}
				console.log($callout);
				$callout.html(data.text).addClass(params.class).fadeIn(params.fadeTime);
				setTimeout(function(){
					$callout.hide().removeClass(params.class);
				},params.showTime);
			},
			error: function(response) {
				alert('Ошибка сохранения');
			}
		});
	});
});