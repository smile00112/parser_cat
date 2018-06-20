$(document).ready(function(){

	$('select[name=type]').on('change', function(){
		if($(this).val()<1){
			$('textarea[name=src]').closest('tr').hide();
		} else {
			$('textarea[name=src]').closest('tr').show();
		}
	});

	$('form').on('submit', function(event){
		event.preventDefault();
		var form = $(this);
		$.ajax({
			url: 'actions.html',
			type: 'POST',
			dataType: 'json',
			data: form.serialize()+'&action=add',
			success: function(data){
				form.slideUp('slow', function(){
					$('.message').html(data.text).show();
					if(!data.error){
						var handler = function(){
							parent.$.fancybox.close();
						}
					} else {
						$('.message').addClass('red');
						var handler = function(){
							$('.message').removeClass('red').hide();
							form.slideDown('slow');
						};
					}
					setTimeout(handler, 1500);
				});
			},
			error: function(response) {
				console.log(response);
			}
		});

	});

});