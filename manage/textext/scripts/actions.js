$(document).ready(function(){

	$(document).on("change", "input", function(event){
		var object = $(this),
				property = $(this).attr("name"),
				value = $(this).val();
		$.ajax({
			url: "UpdatePageProperty.html",
			type: "POST",
			data: {id: object.closest(".seo_tags").attr("data-id"), property: property, value: value },
			success: function(data, textStatus){
				data = JSON.parse(data)
				if(data.error){
					$("#"+property).html("Значение не сохранено. "+data.text).addClass("error").fadeIn(500);
					setTimeout(function(){
						$("#"+property).hide().removeClass("error");
					},2000);
				} else {
					$("#"+property).html("Значение сохранено").addClass("success").fadeIn(500);
					setTimeout(function(){
						$("#"+property).hide().removeClass("success");
					},1000);
				}
			}
		});
	});

	$(document).on("focus", "input", function(event){
		var property = $(this).attr("name"),
				info = propertyInfo(property, $(this).val());
				text = "";
		$(".callout").hide();
		$("#"+property).html(info.text).fadeIn(500);
	});

	$(document).on("keydown", "input", function(event){
		var property = $(this).attr("name"),
				info = propertyInfo(property, $(this).val());
		$("#"+property).find('.words').removeClass().addClass("words").addClass(info.words.color).find('strong').html(info.words.count);
		$("#"+property).find('.symbols').removeClass().addClass("symbols").addClass(info.symbols.color).find('strong').html(info.symbols.count);
	});

	$(document).on("blur", "input", function(event){
		$("#"+$(this).attr("name")).hide();
	});

	function propertyInfo(property, value){
		var answer = new Object();
				answer.words = new Object();
				answer.words.count = value.split(' ').length;
				answer.words.error = false;
				answer.words.color = "green";
				answer.symbols = new Object();
				answer.symbols.count = value.length;
				answer.symbols.error = false;
				answer.symbols.color = "green";
		switch(property){
			case "head":
				if(answer.words.count > 15){ answer.words.error = true; answer.words.color = "red"; }
				if(answer.symbols.count > 50){ answer.symbols.error = true; answer.symbols.color = "red"; }
				answer.text = "Тэг title должен содержать не более 15 слов (<span class='words "+answer.words.color+"'>использовано <strong>"+answer.words.count+"</strong></span>) и его общая длина не должна превышать 50 символов (<span class='symbols "+answer.symbols.color+"'>использовано <strong>"+answer.symbols.count+"</strong></span>). Также он должен содержать все ключевые слова.";
				break;
			case "keywords":
				if(answer.words.count > 20){ answer.words.error = true; answer.words.color = "red"; }
				answer.text = "Тэг keywords должен содержать не более 20 слов (<span class='words "+answer.words.color+"'>использовано <strong>"+answer.words.count+"</strong></span>) и не содержать повторов. Лучше использовать слова в разных склонениях.";
				break;
			case "descript":
				if(answer.words.count > 30){ answer.words.error = true; answer.words.color = "red"; }
				if(answer.symbols.count > 150){ answer.symbols.error = true; answer.symbols.color = "red"; }
				answer.text = "Тэг description должен содержать не более 30 слов (<span class='words "+answer.words.color+"'>использовано <strong>"+answer.words.count+"</strong></span>) и его общая длина не должна превышать 150 символов (<span class='symbols "+answer.symbols.color+"'>использовано <strong>"+answer.symbols.count+"</strong></span>). Также он должен содержать все ключевые слова.";
				break;
			default:
				answer.text = "Неизвестный тэг "+property;
		}
		return answer;
	}

});