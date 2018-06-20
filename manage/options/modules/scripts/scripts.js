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
});

$(document).on("click", ".tabname", function(){
	$(".tabname").removeClass("active");
	$(this).addClass("active");
	$("div.tabcontent").hide();
	$("div[data-tabcontent='"+$(this).data('tabname')+"']").show();
});

$(document).on("click", ".fa-chevron-up", function(){
	var element = $(this).closest(".element-string");
	element.toggleClass("close");
	$('.element-string[data-parent="'+element.attr("data-id")+'"]').each(function(i,elem) {
		if(element.hasClass("close")){
			$(elem).fadeTo(1000, 0, function() {
				$(elem).hide();
			});
		} else {
			$(elem).show();
			$(elem).fadeTo(1000, 1);
		}
	});
});

$(document).on("change", ".js-change", function(){
	var id			= $(this).closest(".element-string").attr("data-id"),
			field		= $(this).attr("name"),
			value		= $(this).val(),
			object	= $(this);
	$(".wait").show();
	$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
		var answer = JSON.parse(data);
		$(".wait").hide();
		if(!answer.error){
			switch (field) {
				case 'parent':
					var currentObject = object.closest(".element-string"),
							prevParent = object.attr("data-prev-parent");
					// Перемещаем блок на новое место
					currentObject.fadeTo("slow", 0, function() {
						if(answer.prevSort>0){
							currentObject.insertAfter($("#block_"+answer.prevId));
						} else {
							if(answer.nextSort>0){
								currentObject.insertBefore($("#block_"+answer.nextId));
							} else {
								currentObject.insertAfter($('#block_'+value));
							}
						}
					});
					// Записываем новое значение сортировки
					currentObject.find('input[name="sortir"]').val(answer.sort);
					// Записываем новое значение родителя (для группировки скрываемых блоков)
					currentObject.attr("data-parent",value);
					// Стилизуем блоки
					if(value > 0){
						currentObject.addClass('child');
						$('.element-string[data-id="'+value+'"]').addClass("parent");
					} else {
						currentObject.removeClass('child');
						console.log($('.element-string[data-parent="'+prevParent+'"]').length);
						if($('.element-string[data-parent="'+prevParent+'"]').length==0){
							$('.element-string[data-id="'+prevParent+'"]').removeClass("parent");
						}
					}
					// Сбрасываем предыдущего родителя (используется для скрывания стрелки если нет больше детей)
					object.attr("data-prev-parent",value);
					// Отображаем перемещённый элемент
					currentObject.fadeTo("slow", 1);
					// Скрываем строку выбора родителя
					object.animate({width:'hide'},500);
					break
				case 'sortir':
					var sortArray = [],
					prevSort = 0,
					currentObject = object.closest(".element-string");
					value = parseInt(value),
					object.attr("data-prev", value);
					object.val(value);
					object.closest(".tabcontent").find('input[name="sortir"][data-prev!="'+value+'"]').each(function(i,elem) {
						sortArray[i] = parseInt($(elem).val());
					});
					sortArray.sort(function (a, b) {
						return a - b;
					});
					for (i = 0; i < sortArray.length; i++) {
						if( sortArray[i] > value){
							break;
						} else {
							prevSort = sortArray[i];
						}
					}
					currentObject.fadeTo("slow", 0, function() {
						if(prevSort>0){
							currentObject.insertAfter($('input[name="sortir"][data-prev="'+prevSort+'"]').closest(".element-string"));
						} else {
							currentObject.insertBefore($('input[name="sortir"][data-prev="'+sortArray[0]+'"]').closest(".element-string"));
						}
					});
					currentObject.fadeTo("slow", 1);
					break
				default:
					object.addClass("green_border");
					setTimeout(function(){
						object.removeClass("green_border");
					},1000);
			}
		} else {
			object.val(object.attr("data-prev"));
			alert(answer.text);
		}
	});
});

$(document).on("click", ".js-delete", function(){
	if (confirm('Вы действительно хотите удалить этот модуль?')){
		var id			= $(this).closest(".element-string").attr("data-id"),
				object	= $(this).closest(".element-string");
		$.post("actions.html", { action: "delete", id: id }, function(data){
			var answer = JSON.parse(data);
			if(!answer.error){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			} else {alert(answer.text);}
		});
	}
});

$(document).on("click", ".fa-link", function(){
	var object = $(this).closest(".element-string").find('select[name="parent"]');
	if(object.css('display') == 'none'){
		$('select[name="parent"]').each(function(i,elem) {
			$(elem).animate({width:'hide'},500);
		});
		object.animate({width:'show'},500);
	} else {
		object.animate({width:'hide'},500);
	}
});