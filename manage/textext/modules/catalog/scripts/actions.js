$(document).ready(function(){
	var addSlideBtn = $("#addSlideBtn");
	if (typeof addSlideBtn.offset() !== "undefined") {
		var addSlideBtnOffset = addSlideBtn.offset().top;
		$(window).scroll(function(){
			if ( $(this).scrollTop() > addSlideBtnOffset && !addSlideBtn.hasClass("fixed") ){
				addSlideBtn.addClass("fixed");
			} else if($(this).scrollTop() <= addSlideBtnOffset && addSlideBtn.hasClass("fixed")) {
				addSlideBtn.removeClass("fixed");
			}
		});
	}


	$('.block_element').on('click', '.headValue', function(){
		document.cookie = 'moduleCatalogIndexTopPos='+$(window).scrollTop()+';path=/';
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

	$('.delete_expand_field').on('click', function(){
		if (confirm('Вы действительно хотите удалить это поле?')){
			var object = $(this).closest("tr");
			$.post("actions.html", { action: "delete_expand_field", field: $(this).closest("tr").attr("data-field") }, function(data){
				data = JSON.parse(data);
				if(data.error){
					alert(data.text);
				} else {
					object.fadeTo("slow", 0, function() {
						object.remove();
					});
				}
			});
		}
	});

	$('.remove_all_relateds').on('click', function(){
		$.ajax({
			url: "actions.html",
			type: "POST",
			data: { action: 'remove_all_relateds', element_id: $(this).attr('data-element-id') },
			success: function(response) {
				$('.related_checkbox:checked').each(function(index, element){
					$(element).removeAttr("checked");
				});
				$('.product-string').addClass("close");
			},
			error: function(response) {
				alert('Произошла ошибка');
			}
		});
	});

	$('.filter_checkbox').on('click', function(){
		var id = $(this).closest('.block_element').attr('data-id'),
				name = $(this).attr('name');
		$.post("actions.html", { action: 'toggle_filter', element_id: id, name: name }, function(data){
			data = JSON.parse(data);
			if(data.error){
				$("#"+name+"_"+id).html("Значение не сохранено. "+data.text).addClass("error").fadeIn(500);
				setTimeout(function(){
					$("#"+name+"_"+id).hide().removeClass("error");
				},2000);
			} else {
				$("#"+name+"_"+id).html(data.text).addClass("success").fadeIn(500);
				setTimeout(function(){
					$("#"+name+"_"+id).hide().removeClass("success");
				},1000);
			}
		});
	});

	$('.fa-chevron-up').on('click', function(){
		$(this).closest(".product-string").toggleClass("close");
	});

	$('.related_checkbox').on('click', function(){
		var id = $(this).closest('.product-string').attr('data-id');
		$.post("actions.html", { action: 'toggle_related', element_id: $('.related-goods').attr('data-id'), related_id: id }, function(data){
			data = JSON.parse(data);
			if(data.error){
				$("#"+id).html("Значение не сохранено. "+data.text).addClass("error").fadeIn(500);
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

	$('input[name=step]').on('change', function(){
		var value = this.value,
				object = $(this);
		value = parseFloat(value.replace(',','.'));
		if( value > 0 ){
			$.post("actions.html", { id: $(".block_elements").attr("data-block-id"), action: "save_step", field_id: $(this).closest(".block_element").attr("data-id"), value: value }, function(data){
				var answer = JSON.parse(data);
				if(!answer.error){
					object.val(value);
					object.attr('data-prev', value);
					object.addClass("green_border");
					setTimeout(function(){
						object.removeClass("green_border");
					},1000);
				} else {
					object.val(object.attr('data-prev'));
				}
			});
		} else {
			object.val(object.attr('data-prev'));
		}
	});

	$('.save').on('change', function(){
		var id			= $(this).closest(".block_element").attr("data-id"),
				field		= $(this).attr("name"),
				value		= $(this).val(),
				object	= $(this);
		switch (field) {
			case 'sizes':
				var action = 'update_sizes';
				if (value != null) {
					value = value.join();
				} else {
					value = 0;
				}
				break
			case 'colors':
				var action = 'update_colors';
				if (value != null) {
					value = value.join();
				} else {
					value = 0;
				}
				break
			case 'stickers':
				var action = 'update_stickers';
				if (value != null) {
					value = value.join();
				} else {
					value = 0;
				}
				break
			default:
				var action = 'save_field';
		}
		$.post("actions.html", { action: action, id: id, field: field, value: value }, function(data){
			var answer = JSON.parse(data);
			if(!answer.error){
				switch (field) {
					case 'sortir':
						location.reload();
						break
					default:
				}
				object.addClass("green_border");
				setTimeout(function(){
					object.removeClass("green_border");
				},1000);
			}
		});
	});

});

$.fn.ChangeVisible = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
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
		var id			= $(this).closest(".block_element").attr("data-id"),
				object	= $(this).closest(".block_element");
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
	var id				= $(this).closest(".block_element").attr("data-id"),
			image_id	= $(this).attr("data-id");
	$.post("./actions.html", { action: "delete_main_image", id: image_id }, function(data){
		if(data > 0){
			$("#image_"+id).hide();
			$("#no_image_"+id).show();
		}
	});
};
$.fn.Save = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val(),
			object	= $(this);
	if(object.hasClass('number')){
		value = value.replace(",", ".");
		value = parseFloat(value);
		if(isNaN(value)){value = 0;}
		$(this).val(value);
	}
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		var answer = JSON.parse(data);
		if(!answer.error){
			switch (field) {
				case 'stock':
					$("#stock_"+id).html(value);
					if(value===""){
						$("#stock_"+id).hide();
					}
					break
				case 'sortir':
					location.reload();
					break
				default:
			}
			object.addClass("green_border");
			setTimeout(function(){
				object.removeClass("green_border");
			},1000);
		}
	});
};
$.fn.SaveParts = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val(),
			object	= $(this);
	// Оставляем только x [0-9] \, \.
	value = value.replace(/[^x0-9\,\.]+/g,"");
	// Убираем спереди и сзади x\,\.
	value = value.replace(/(^[x\,\.]{1})|([x\,\.]{1}$)/,"");
	// Ставим пробел после каждой запятой
	value = value.replace(/\,/g,", ");
	// Сохраняем значение
	$(this).val(value);
	// Отправляем запрос
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value, parts: true }, function(data){
		var answer = JSON.parse(data);
		if(!answer.error){
			$("#price_"+id).val(answer.price);
			object.addClass("green_border");
			setTimeout(function(){
				object.removeClass("green_border");
			},1000);
		}
	});
};
$.fn.SaveDate = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
			value		= $(this).val(),
			object	= $(this);
	$.post("actions.html", { action: "save_date", id: id, field: "date", value: value }, function(data){
		if(data > 0){
			location.reload(true);
		}
	});
};
$.fn.SaveTime = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
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
$.fn.SaveCheckBox = function(){
	var id			= $(this).closest(".block_element").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).is(':checked'),
			object	= $(this);
	if(value){value=1;}else{value=0;}
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		if(data > 0){
			switch (field) {
				case 'new':
					if(value){
						$("#new_element_"+id).show();
					} else {
						$("#new_element_"+id).hide();
					}
					break
				default:
			}
			object.addClass("green_border");
			setTimeout(function(){
				object.removeClass("green_border");
			},1000);
		}
	});
};