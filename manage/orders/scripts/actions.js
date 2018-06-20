$(document).ready(function(){
//	URL для шаблоны вывода строки заказа
	var templateURL = $('.orders').attr('data-template-url');
//	Открывает информацию о заказе при нажатии на строку заказа
	$('.orders').on('click', '.window', function(event){
		event.preventDefault();
		var $a = $(this),
		orderID = $a.closest('.order').attr('data-id');
		$.fancybox.open({
			type:		'iframe',
			href:		$a.attr('href'),
			title:	$a.attr('title'),
			padding:	5,
			fitToView:	true,
			afterClose: function(){
				$.ajax({
					url: templateURL,
					type: 'POST',
					dataType: 'json',
					data: {action: 'get_order_string', order_id: orderID},
					success: function(answer){
						if(answer.error){
							alert(answer.text);
						} else {
							var $item = $('.order[data-id='+orderID+']');
							$item.fadeTo('slow', 0, function(){
								$item.replaceWith(answer.html).fadeTo('slow', 1);
							});
						}
					},
					error: function(response) {
						if(reload){
							location.reload(true);
						}
					}
				});
			}
		});
	});
//	Открывает информацию о заказе при нажатии на строку заказа
	$('.orders').on('click', 'td:not(".actions")', function(event){
		$(this).closest('.order').find('.window').click();
	});
//	Отправляет форму при выборе элемента фильтра
	$('.filter select').on('change', function(event){
		$(this).closest('form').submit();
	});
});