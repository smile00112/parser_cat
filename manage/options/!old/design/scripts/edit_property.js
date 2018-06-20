$.fn.UpdatePropertyField = function(){
		var id			= $(this).closest("table").attr("data-id"),
				field		= $(this).attr("name"),
				value		= $(this).val()
				object	= $(this);
	$.post("actions.html", { action: "update_property_field", id: id, field: field, value: value }, function(data){
		if(data > 0){
			object.attr("style","border: 2px solid green;");
			setTimeout(function(){
				object.removeAttr("style");
			}, 500);
		}
	});
};