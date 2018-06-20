$(document).ready(function(){
	$('form').on('submit',function(event){
		var $form = $(this);
		event.preventDefault();
		$.ajax({
			type: 'post',
			url: $form.attr('action'),
			data: $form.serialize(),
			dataType: 'json',
			success: function(data){
				answer = data;
				if(!data.error){
					window.opener.location.reload();
					window.close();
				} else {
					var $message = $form.siblings('.message');
					$message.html(data.text).show();
					setTimeout(function(){
						$message.hide().html('');
					},2000);
				}
			}
		});
	});
});