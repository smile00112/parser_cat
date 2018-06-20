// загрузка страницы
$(document).ready(function(){
	$('.catalog_ajax_data').click(function(){
		var link = $(this).attr('href');
		ajaxFuncService(link);
		return false
	});
	
	/*$('.catalog_pop_up').click(function(){
		var link = $(this).attr('href');
		var text = $(this).attr('text_pop');
		var type = $(this).attr('type_pop');
		$('#cms_pop_windows').show();
		popWindows(text,type,link);
		return popWindows();
	});*/
	
	var titleElem = $('*[title]');
	simple_tooltip(titleElem);
	
	$('#cms_pop_windows>span').click(function(){
		$('#cms_pop_windows').hide();
	});
	
	// кнопка не активна пока не загружен файл
	$('.load_img input[type="submit"]').attr('disabled','disabled');
	$('.load_img input[type="submit"]').css({'opacity':'0.4','cursor':'default'});
	$('.load_img input[type="file"]').change(function(){
		if($(this).val() !== ''){
			var parent = $(this).parents('.load_img');
			$(parent).find('input[type="submit"]').removeAttr('disabled');
			$(parent).find('input[type="submit"]').css({'opacity':'0.8','cursor':'pointer'});
			$(parent).find('.load_photo_name').text($(this).val());
		}
	});
});

function simple_tooltip(target_items){
	$(target_items).each(function(i){
		$('body').append("<div class='tooltip' id='tooltip"+i+"'>"+$(this).attr('title')+"</div>");
		
		var my_tooltip = $('#tooltip'+i);

		$(this).removeAttr('title').mouseover(function(){
			my_tooltip.css({opacity:1, display:'none'}).fadeIn(200);
		}).mousemove(function(kmouse){
			// если курсор далеко от правого края экрана
			var widthTool = $(my_tooltip).width() + 10 + 20;
			var widthWin = $(window).width() - widthTool;
			if(kmouse.pageX < widthWin){
				my_tooltip.css({left:kmouse.pageX + 15, top:kmouse.pageY + 15});
			}else{
				my_tooltip.css({left:kmouse.pageX - widthTool + 15, top:kmouse.pageY+15});
			}
		}).mouseout(function(){
			my_tooltip.fadeOut(200);
		});
	});
}

function ajaxFuncService(link){
	$.ajax({
		url: link, // указываем URL и
		dataType : 'html', // тип загружаемых данных
		success: function (data){ // обработчик на функцию success
			popWindows(data,2);
			$('#cms_pop_windows').show();
		},
		error: function (){
			var txtError = 'Ошибка передачи данных!';
			popWindows(txtError,2);
			$('#cms_pop_windows').show();
		}
	});
}

function popWindows(text,type,link){
	if(type == 1){
		$('#cms_pop_windows div').html(text);
		$('#cms_pop_windows').append('<span class="button false">Отмена</span><span class="button true">Ок</span>');
		$('#cms_pop_windows .false').click(function(){
			$('#cms_pop_windows').hide();
			console.log('false');
			return false;
		});
		$('#cms_pop_windows .true').click(function(){
			$('#cms_pop_windows').hide();
			console.log('true');
			return true;
		});
	}
	if(type == 2){
		$('#cms_pop_windows div').text(text);
	}
}

// j-tap
// 26.02.13
