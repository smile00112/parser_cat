$(document).ready(function(){

	var element_id = $('table').data('id');

	$('.save').on('change', function(){
		var field		= $(this).prop('name'),
				value		= $(this).val(),
				object	= $(this);
		$.post('actions.html', { action: 'save_field', id: element_id, field: field, value: value }, function(data){
			var data = JSON.parse(data),
					className = '';
			if(!data.error){
				className = 'success';
			} else {
				className = 'error';
			}
			$('#'+field).html(data.text).addClass(className).show();
			setTimeout(function(){
				$('#'+field).removeClass(className).hide();
			},1000);
		});
	});

	$('table').on('keydown', 'input', function(){
		var property = $(this).prop('name');
		if(property !== 'url'){
			var info = propertyInfo(property, $(this).val());
			$('#'+property).find('.words').removeClass().addClass('words').addClass(info.words.color).find('strong').html(info.words.count);
			$('#'+property).find('.symbols').removeClass().addClass('symbols').addClass(info.symbols.color).find('strong').html(info.symbols.count);
		} else {
			$(this).val(toTranslit($(this).val()).toLowerCase());
		}
	});

	$('table').on('focus', 'input', function(event){
		var property = $(this).prop('name');
		$('.callout').hide();
		if(property !== 'url'){
			var info = propertyInfo(property, $(this).val());
			$('#'+property).html(info.text).fadeIn(500);
		}
	});

});

function toTranslit( text ){
	return text.replace( /([а-яё])|([\s_-])|([^a-z\d])/gi,
		function( all, ch, space, words, i ){
			if ( space || words ){
				return space ? '-' : '';
			}
			var code = ch.charCodeAt(0),
					next = text.charAt( i + 1 ),
					index = code == 1025 || code == 1105 ? 0 :
							code > 1071 ? code - 1071 : code - 1039,
					t = ['yo','a','b','v','g','d','e','zh',
							'z','i','y','k','l','m','n','o','p',
							'r','s','t','u','f','h','c','ch','sh',
							'shch','','y','','e','yu','ya'
					],
					next = next && next.toUpperCase() === next ? 1 : 0;
			return ch.toUpperCase() === ch ? next ? t[ index ].toUpperCase() :
							t[ index ].substr(0,1).toUpperCase() +
							t[ index ].substring(1) : t[ index ];
		}
	);
}

function propertyInfo(property, value){
	var answer = new Object();
			answer.words = new Object();
			answer.words.count = value.split(' ').length;
			answer.words.error = false;
			answer.words.color = 'green';
			answer.symbols = new Object();
			answer.symbols.count = value.length;
			answer.symbols.error = false;
			answer.symbols.color = 'green';
	switch(property){
		case 'title':
			if(answer.words.count > 15){ answer.words.error = true; answer.words.color = 'red'; }
			if(answer.symbols.count > 50){ answer.symbols.error = true; answer.symbols.color = 'red'; }
			answer.text = 'Тэг title должен содержать не более 15 слов (<span class="words '+answer.words.color+'">использовано <strong>'+answer.words.count+'</strong></span>) и его общая длина не должна превышать 50 символов (<span class="symbols '+answer.symbols.color+'">использовано <strong>'+answer.symbols.count+'</strong></span>). Также он должен содержать все ключевые слова.';
			break;
		case 'keywords':
			if(answer.words.count > 20){ answer.words.error = true; answer.words.color = 'red'; }
			answer.text = 'Тэг keywords должен содержать не более 20 слов (<span class="words '+answer.words.color+'">использовано <strong>'+answer.words.count+'</strong></span>) и не содержать повторов. Лучше использовать слова в разных склонениях.';
			break;
		case 'description':
			if(answer.words.count > 30){ answer.words.error = true; answer.words.color = 'red'; }
			if(answer.symbols.count > 150){ answer.symbols.error = true; answer.symbols.color = 'red'; }
			answer.text = 'Тэг description должен содержать не более 30 слов (<span class="words '+answer.words.color+'">использовано <strong>'+answer.words.count+'</strong></span>) и его общая длина не должна превышать 150 символов (<span class="symbols '+answer.symbols.color+'">использовано <strong>'+answer.symbols.count+'</strong></span>). Также он должен содержать все ключевые слова.';
			break;
		default:
			answer.text = 'Неизвестный тэг '+property;
	}
	return answer;
}