$(document).ready(function(){

	$('.fa-chevron-up').on('click', function(){
		$(this).closest(".element-string").toggleClass("close");
	});

	$('input[type=checkbox]').on('click', function(){
		$('input[type=checkbox]').not(this).removeAttr("checked");
		var id = element_id = $(this).closest('.element-string').attr('data-id');
		if(!$(this).prop("checked")){element_id = $('.elements').attr('data-default-id')}
		$.post("../actions.html", { action: 'link_element', element_id: $('.elements').attr('data-element-id'), parent: element_id }, function(data){
			data = JSON.parse(data);
			if(data.error){
				$("#"+id).html("Привязка не завершена. "+data.text).addClass("error").fadeIn(500);
				setTimeout(function(){
					$("#"+id).hide().removeClass("error");
				},2000);
			} else {
				$("#"+id).html(data.text).addClass("success").fadeIn(500);
				setTimeout(function(){
					$("#"+id).hide().removeClass("success");
				},1000);
			}
		});
	});

});