$(document).ready(function(){

	window.onbeforeunload = null;

	$('.save').on('click', function(){
		$textarea = $(this).closest('table').find('textarea');
		tinyMCE.triggerSave();
		$('.wait').show('slow');
		$.ajax({
			url: 'actions.html',
			type: 'POST',
			dataType: 'json',
			data: { action: 'save_field', id: $textarea.attr('data-id'), field: $textarea.attr('id'), value: $textarea.val() },
			success: function(answer) {
				if(!answer.error){
					$('.ok').fadeIn();
					setTimeout(function(){
						$('.ok').fadeOut();
// 						parent.location.href = '/manage/structure/?debug=true'
// 						parent.$.fancybox.close();
					},1500);
				}
			},
			error: function(response) {
				ShowMessage('Произошла ошибка');
			},
			complete: function(response) {
				$('.wait').hide('slow');
			}
		});
	});

});