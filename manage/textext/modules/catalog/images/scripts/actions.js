$.fn.ChangeVisible = function(){
	var id			= $(this).closest(".block_image").attr("data-id"),
			object	= $(this);
	$.post("actions.html", { action: "update_visible", id: id }, function(data){
		if(data == 0){
			object.removeClass('fa-eye').addClass('fa-eye-slash');
		} else {
			object.removeClass('fa-eye-slash').addClass('fa-eye');
		}
	});
};
$.fn.Delete = function(){
	if (confirm('Вы действительно хотите удалить это изображение?')){
		var id			= $(this).closest(".block_image").attr("data-id"),
				object	= $(this).closest(".block_image");
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
	var id			= $(this).closest(".block_image").attr("data-id"),
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
	var id			= $(this).closest(".block_image").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val();
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		if(data > 0){
			location.reload(true);
		}
	});
};
$.fn.SetMain = function(){
	var id			= $(this).closest(".block_image").attr("data-id"),
			object	= $(this);
	$.post("actions.html", { action: "set_main", id: id }, function(data){
		if(data > 0){
			object.removeClass('fa-square-o').removeClass('pointer').addClass('fa-check-square-o').removeAttr("onClick").attr("title", "Главное изображение");
			$("#main_"+data).removeClass('fa-check-square-o').addClass('fa-square-o').addClass('pointer').attr("onClick", "$(this).SetMain();").attr("title", "Сделать главным изображением");
		}
	});
};