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

$.fn.ChangeVisible = function(){
	var id			= $(this).closest(".block_news").attr("data-id"),
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
	if (confirm('Вы действительно хотите удалить эту новость?')){
		var id			= $(this).closest(".block_news").attr("data-id"),
				object	= $(this).closest(".block_news");
		$.post("actions.html", { action: "delete", id: id }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
$.fn.DeleteImage = function(){
	var id				= $(this).closest(".block_news").attr("data-id"),
			image_id	= $(this).attr("data-id");
	$.post("./actions.html", { action: "delete_main_image", id: image_id }, function(data){
		if(data > 0){
			$("#image_"+id).hide();
			$("#no_image_"+id).show();
		}
	});
};
$.fn.Save = function(){
	var id			= $(this).closest(".block_news").attr("data-id"),
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
$.fn.SaveDate = function(){
	var id			= $(this).closest(".block_news").attr("data-id"),
			value		= $(this).val(),
			object	= $(this);
	$.post("actions.html", { action: "save_date", id: id, field: "date", value: value }, function(data){
		if(data > 0){
			location.reload(true);
		}
	});
};
$.fn.SaveTime = function(){
	var id			= $(this).closest(".block_news").attr("data-id"),
			value		= $(this).val(),
			object	= $(this);
	$.post("actions.html", { action: "save_date", id: id, field: "time", value: value }, function(data){
		if(data > 0){
			location.reload(true);
		}
	});
};
$.fn.SaveOption = function(){
	var id			= $(this).closest("tr").attr("data-id"),
			value		= $(this).val(),
			object	= $(this);
	$.post("actions.html", { action: "save_option", id: id, value: value }, function(data){
		if(data > 0){
			object.addClass("green_border");
			setTimeout(function(){
				object.removeClass("green_border");
			},1000);
		}
	});
};
$.fn.SaveCheckBoxOption = function(){
	var id			= $(this).closest("tr").attr("data-id"),
			value		= $(this).is(':checked');
	if(value){value=1;}else{value=0;}
	$.post("actions.html", { action: "save_option", id: id, value: value });
};
$.fn.UpdateMain = function(){
	var id			= $(this).closest(".block_news").attr("data-id"),
			one     = $(this).attr("data-one"),
			value		= $(this).is(':checked');
	if(value){value=1;}else{value=0;}
	$.post("actions.html", { action: "update_main", id: id, value: value, one: one }, function(data){
		if(one == "true"){
			location.reload(true);
		}
	});
};