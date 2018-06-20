// x1, y1, x2, y2 - Координаты для обрезки изображения
// crop - Папка для обрезанных изображений
var x1, y1, x2, y2, crop = 'crop/';
var jcrop_api;

jQuery(function($){             

	$('.editThumb').click(function(e) {
	
		$('#targetWrap').html('<img src="' + $(this).data( "big" ) + '" id="target"/>'); 
		
		$.fancybox({
			href : '#cropImg'
		});

	
		$('#target').Jcrop({		
			onChange:   showCoords,
			onSelect:   showCoords
		},function(){		
			jcrop_api = this;		
		});
	
	
	
	// Снять выделение	
    $('#release').click(function(e) {		
		release();
    });   
	// Соблюдать пропорции
    $('#ar_lock').change(function(e) {
		jcrop_api.setOptions(this.checked?
			{ aspectRatio: 1/2 }: { aspectRatio: 0 });
		jcrop_api.focus();
    });
   // Установка минимальной/максимальной ширины и высоты
   $('#size_lock').change(function(e) {
		jcrop_api.setOptions(this.checked? {
			minSize: [ 80, 80 ],
			maxSize: [ 350, 350 ]
		}: {
			minSize: [ 0, 0 ],
			maxSize: [ 0, 0 ]
		});
		jcrop_api.focus();
    });
	// Изменение координат
	function showCoords(c){
		x1 = c.x; $('#x1').val(c.x);		
		y1 = c.y; $('#y1').val(c.y);		
		x2 = c.x2; $('#x2').val(c.x2);		
		y2 = c.y2; $('#y2').val(c.y2);
		
		$('#w').val(c.w);
		$('#h').val(c.h);
		
		if(c.w > 0 && c.h > 0){
			$('#crop').show();
		}else{
			$('#crop').hide();
		}
		
	}	
	
	});
});

function release(){
	jcrop_api.release();
	$('#crop').hide();
}
// Обрезка изображение и вывод результата
jQuery(function($){
	$('#crop').click(function(e) {
		console.log('x1: '+ x1 +', x2:' + x2 +', y1: ' + y1 + ', y2: ' + y2 + ', img: ' + img + ', crop: ' +crop);
		
		var img = $('#target').attr('src');
		$.post('action.php', {'x1': x1, 'x2': x2, 'y1': y1, 'y2': y2, 'img': img, 'crop': crop}, function(file) {
			$('#cropresult').append('<img src="'+crop+file+'" class="mini">');
			release();
		});
		
    });   
});