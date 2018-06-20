jQuery(function($){

	$('.editThumb').click(function(e) {

		image_id		= $(this).data( "id" ),
		aspectRatio = $(this).data( "ratio" ),
		width				= $(this).data( "width" ),
		idblock     = $(this).data( "idblock" );

		$('#targetWrap').html('<img src="' + $(this).data( "big" ) + '" id="target"/>');

		$.fancybox({
			href : '#cropImg'
		});

		$('#target').Jcrop({
			onChange:			showCoords,
			onSelect:			showCoords,
			aspectRatio:	aspectRatio,
			minSize:			[ width, 0 ],
			setSelect:		[ 0, 0, 10000, 10000 ]
		},function(){
			jcrop_api = this;
		});

		// Изменение координат
		function showCoords(c){
			x1 = c.x;
			y1 = c.y;
			x2 = c.x2;
			y2 = c.y2;

			if(c.w > 0 && c.h > 0){
				$('#crop').show();
			}else{
				$('#crop').hide();
			}

		}

	});

	// По умолчанию
    $('#reset').click(function(e) {
		jcrop_api.setOptions(
			{setSelect: [ 0, 0, 10000, 10000 ]}
		);
		jcrop_api.focus();
    });

	function release(){
		jcrop_api.release();
  		$('#crop').hide();
	}

	// Обрезка изображение и вывод результата
	$('#crop').click(function(e) {
		$.post('actions.html', {'idblock': idblock, 'action': 'crop_image', id: image_id, 'x': x1, 'y': y1, 'width': Math.round(x2-x1), 'height': Math.round(y2-y1)}, function(data) {
			if(data > 0){
				location.reload(true);
			}
		});
	});

});