$(document).ready(function(){
	$('.save').on('change', function(){
		var id			= $(this).closest(".parameters").attr("data-id"),
				field		= $(this).attr("name"),
				value		= $(this).val(),
				object	= $(this);
		$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
			data = JSON.parse(data);
			if(!data.error){
				object.addClass("green_border");
				setTimeout(function(){
					object.removeClass("green_border");
				},1000);
			}
		});
	});
});