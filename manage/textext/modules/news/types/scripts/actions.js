$.fn.Delete = function(){
	if (confirm('Вы действительно хотите удалить это изображение?')){
		var id			= $(this).closest("tr").attr("data-id"),
				object	= $(this).closest("tr");
		$.post("actions.html", { action: "delete", id: id }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
$.fn.Save = function(){
	var id			= $(this).closest("tr").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val(),
			object	= $(this);
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		if(data > 0){
			object.addClass("green_border");
			setTimeout(function(){
				object.removeClass("green_border");
			},1000);
		}
	});
};
$.fn.SavePosition = function(){
	var id			= $(this).closest("tr").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val();
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		if(data > 0){
			location.reload(true);
		}
	});
};