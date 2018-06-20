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

$.fn.Delete = function(){
	if (confirm('Вы действительно хотите удалить это поле?')){
		var id			= $(this).closest("tr").attr("data-id"),
				object	= $(this).closest("tr");
		$.post("actions.html", { action: "delete_field", id: id }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};