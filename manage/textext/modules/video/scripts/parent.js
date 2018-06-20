$(document).ready(function(){

	$('.fa-chevron-up').on('click', function(){
		$(this).closest(".element-string").toggleClass("close");
	});

	$('input[type=checkbox]').on('click', function(){
		if($(this).prop("checked")){
			$('input[type=checkbox]').not(this).removeAttr("checked");
			var id = element_id = $(this).closest('.element-string').attr('data-id');
			if(!$(this).prop("checked")){element_id = $('.elements').attr('data-default-id')}
			$.post("actions.html", { action: 'change_parent', element_id: $('.elements').attr('data-element-id'), parent: element_id }, function(data){
				data = JSON.parse(data);
				if(data.error){
					$("#callout_"+id).html("Привязка не завершена. "+data.text).addClass("error").fadeIn(500);
					setTimeout(function(){
						$("#callout_"+id).hide().removeClass("error");
					},2000);
				} else {
					$("#callout_"+id).html(data.text).addClass("success").fadeIn(500);
					setTimeout(function(){
						$("#callout_"+id).hide().removeClass("success");
					},1000);
				}
			});
		} else {
			$(this).prop("checked", true);
		}
	});

});