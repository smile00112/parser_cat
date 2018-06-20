$(document).ready(function(){
	var addSlideBtn = $("#addSlideBtn"),
			addSlideBtnOffset = addSlideBtn.offset().top;
	$(window).scroll(function(){
		if ( $(this).scrollTop() > addSlideBtnOffset && !addSlideBtn.hasClass("fixed") ){
			addSlideBtn.addClass("fixed");
		} else if($(this).scrollTop() <= addSlideBtnOffset && addSlideBtn.hasClass("fixed")) {
			addSlideBtn.removeClass("fixed");
		}
	});

	$(".addForm").fancybox({
		padding:			5,
		maxWidth:			800,
		maxHeight:		600,
		fitToView:		false,
		autoSize:			true,
		closeClick:		false,
		openEffect:		'none',
		closeEffect:	'none'
	});
});

$.fn.DeleteProperty = function(){
	if (confirm('Вы действительно хотите удалить это свойство?')){
		var id				= $(this).closest("tr").attr("data-id"),
				object		= $(this).closest("tr");
		$.post("actions.html", { action: "delete_property", id: id }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};

$.fn.UpdateColorProperty = function(){
		var id			= $(this).closest("tr").attr("data-id"),
				value		= $(this).val(),
				object	= $(this);
	$.post("actions.html", { action: "update_color_property", id: id, value: value }, function(data){
		if(data < 1){
			object.val("ffffff");
		}
	});
};

$.fn.ResetDefaultProperty = function(){
	if (confirm('Вы действительно хотите установить значение по умолчанию?')){
		var id				= $(this).closest("tr").attr("data-id"),
				value			= $(this).attr("data-default");
		$('#property_input_'+id).val(value).css('backgroundColor', '#'+value);;
	}
}

$.fn.ReloadDefaultImage = function(){
	if (confirm('Вы действительно хотите вернуть изображение по умолчанию?')){
		var id				= $(this).closest("tr").attr("data-id"),
				value			= $(this).attr("data-default");
		$.post("actions.html", { action: "reload_default_image", id: id }, function(data){
			if(data > 0){
				if(value.length > 0){
					$("#image_"+id).attr("src",value);
				} else {
					$("#image_container_"+id).html("Нет изображения");
				}
			}
		});
	}
}