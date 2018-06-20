$(document).ready(function(){
	$('form.js').each(function(){

		var form = $(this),
			btn = form.find('.submit'),
			url = form.attr('action'),
			captcha = $(this).find('.captchaImg')[0];

		form.find('input').addClass('empty_field');
		form.find('textarea').addClass('empty_field');

		function checkInput(){

			form.find('input').each(function(){
				if(($(this).val() != '') || !($(this).hasClass('required'))){
					if($(this).val() != 'on'){
						$(this).removeClass('empty_field');
					} else {
						if($(this).prop('checked')){
							$(this).removeClass('empty_field');
						} else {
							$(this).addClass('empty_field');
						}
					}
				} else {
					$(this).addClass('empty_field');
				}
			});

			form.find('textarea').each(function(){
				if(($(this).val() != '') || !($(this).hasClass('required'))){
					$(this).removeClass('empty_field');
				} else {
					$(this).addClass('empty_field');
				}
			});
		}


		function lightEmpty(){
			form.find('.empty_field').css({'border-color':'#d8512d'});
			setTimeout(function(){
				form.find('.empty_field').removeAttr('style');
			},500);
		}

		setInterval(function(){
			checkInput();
			var sizeEmpty = form.find('.empty_field').length;
			if(sizeEmpty > 0){
				if(btn.hasClass('disabled')){
					return false
				} else {
					btn.addClass('disabled')
				}
			} else {
				btn.removeClass('disabled')
			}
		},500);

		btn.click(function(event){
			event.preventDefault();
			if($(this).hasClass('disabled')){
				lightEmpty();
			} else {
				AjaxFormRequest(form, url);
			}
// 			if(typeof captcha !== "undefined"){captchaLoad(captcha);}
		});
	});

	function AjaxFormRequest(form,url) {
		jQuery.ajax({
			url: url,
			type: "POST",
			dataType: "json",
			data: jQuery(form).serialize(),
			success: function(answer){
				if(typeof answer === "object"){
					if(answer.error){
						if(typeof answer.captcha !== "undefined"){
							form.find(".content-form-captcha").attr("src", answer.captcha.imagePath);
							form.find("input[name=answerId]").val(answer.captcha.answerId);
							form.find("input[name=answer]").val("").focus();
						}
						ShowMessage(answer.text);
					} else {
						var func = form.attr('data-function');
						if(typeof func === "undefined"){
							ShowMessage(answer.text);
						}else{
							window[func](form, answer.text);
						}
					}
				}else{
					ShowMessage(response);
				}
			},
			error: function(response) {
				ShowMessage("Ошибка при отправке формы");
			}
		});
	}

/*	function captchaLoad(captcha){
		jQuery.ajax({
			url: "/modules/captcha/index.html", //Адрес подгружаемой страницы
			dataType: "html", //Тип данных
			success: function(response) { //Если все нормально
				captcha.innerHTML = response;
			},
			error: function(response) { //Если ошибка
				captcha.innerHTML = "captcha error";
			}
		});
	}*/
});

function ShowMessage(message){
	$.fancybox.open(message,{
		minWidth: 'auto',
		minHeight: 'auto',
		helpers: {
			overlay: {
				locked: false
			}
		}
	});
}
function Reload(form, message){
	location.reload();
}
function RedirectWidthMessage(form, message){
	ShowMessage(message);
	setTimeout(function(){
		window.location.href = form.attr('data-redirect-url');
	},1000);
}
function ReloadWidthMessage(form, message){
	ShowMessage(message);
	setTimeout(function(){
		window.location.reload();
	},1000);
}