$(document).ready(function() {

	if ($.cookie('devMode')){
		$( "body" ).addClass('devMode');
	}

	var settings = {
		defaults : {
			minWidth : '800px',
			maxWidth : '1280px',
			mainColor : '#ad0708',
			logo: '/bank/logo.png'
		},
		mainColor : null,
		minWidth : null,
		maxWidth : null,
		logo: null
	}


	settings.mainColor =  $.cookie('@mainColor') ? $.cookie('@mainColor') : settings.defaults.mainColor;
	settings.minWidth = $.cookie('@minWidth') ? $.cookie('@minWidth') : settings.defaults.minWidth;
	settings.maxWidth = $.cookie('@maxWidth') ? $.cookie('@maxWidth') : settings.defaults.maxWidth;
	settings.logo = localStorage.logo ? localStorage.logo : settings.defaults.logo;


	setLessVars(settings);


	function setLessVars (settings) {
		less.modifyVars({
			'@mainColor':	settings.mainColor,
			'@minWidth'	:	settings.minWidth,
			'@maxWidth'	:	settings.maxWidth
		});

		$('#logoImage').attr( "src", settings.logo );
		$('#footerLogoImage').attr( "src", settings.logo );

		$.cookie('@mainColor', settings.mainColor, { path: '/' });
		$.cookie('@minWidth', settings.minWidth, { path: '/' });
		$.cookie('@maxWidth', settings.maxWidth, { path: '/' });
		localStorage.logo = settings.logo;

		console.log(settings.logo);

		$( "#settingsInput" ).val('@mainColor=' + settings.mainColor + '; @minWidth=' + settings.minWidth + '; @maxWidth=' + settings.maxWidth);
		$( "#logoText" ).val(settings.logo);

		return false;
	}


	$('#colorSelector').ColorPicker({
		color: settings.mainColor,
		onShow: function (colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide: function (colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange: function (hsb, hex, rgb) {
			$('#colorSelector div').css('backgroundColor', '#' + hex);

			settings.mainColor = '#' + hex;
			setLessVars(settings);
		}
	});


	$('#otherColors > div > span').on('click',function(e){
		var color = $(this).data('color');

		settings.mainColor = color;
		setLessVars(settings);

		$('#colorSelector').ColorPickerSetColor(color);
		$('#colorSelector div').css('backgroundColor', color);
	});


	$( "#widthValue" ).slider({
		min: 600,
		max: 1600,
		step: 10,
		value: parseFloat(settings.minWidth) ? parseFloat(settings.minWidth) : settings.defaults.minWidth,
		slide: function( event, ui ) {

			$( "#minWidth" ).val(ui.value + 'px');
			$( "#maxWidth" ).val(ui.value + 'px');
			$( "#width" ).val(ui.value + 'px');

			settings.minWidth = ui.value + 'px';
			settings.maxWidth = ui.value + 'px';

			setLessVars(settings);

		}
	});


	$( "#widthRange" ).slider({
		range: true,
		min: 600,
		max: 1600,
		step: 10,
		values: [ 	parseFloat(settings.minWidth) ? parseFloat(settings.minWidth) : settings.defaults.minWidth,
					parseFloat(settings.maxWidth) ? parseFloat(settings.maxWidth) : settings.defaults.maxWidth ],
		slide: function( event, ui ) {
			settings.minWidth = ui.values[ 0 ] + 'px';
			settings.maxWidth = ui.values[ 1 ] + 'px';

			$( "#minWidth" ).val(settings.minWidth);
			$( "#maxWidth" ).val(settings.maxWidth);
			$( "#width" ).val(settings.minWidth);

			setLessVars(settings);

		}
	});


	$( "#widthAc" ).accordion({
		 active: 1
	});



	$( "#siteWidth button").button();
	$( "#btnsPanel .resetSettings").button();
	$( "#btnsPanel .submitSettings").button();



	$( "#flexWidth" ).click(function(){
		settings.minWidth = '0';
		settings.maxWidth = 'none';

		setLessVars(settings);
	});


	$( "#siteWidth .reset" ).click(function(){
		settings.minWidth = settings.defaults.minWidth;
		settings.maxWidth = settings.defaults.maxWidth;

		setLessVars(settings);
	});


	$( "#btnsPanel .resetSettings" ).click(function(){
		settings.minWidth = settings.defaults.minWidth;
		settings.maxWidth = settings.defaults.maxWidth;
		settings.mainColor = settings.defaults.mainColor;
		settings.logo = settings.defaults.logo;

		$.removeCookie('minWidth', { path: '/' });
		$.removeCookie('maxWidth', { path: '/' });
		$.removeCookie('mainColor', { path: '/' });
		localStorage.removeItem(logo);

		setLessVars(settings);
	});



	$( "#togglePanel" ).click(function(){
		$( "body" ).toggleClass('devMode');

		if ($.cookie('devMode')){
			$.removeCookie('devMode', { path: '/' });
		} else{
			$.cookie('devMode', true, { path: '/' });
		}
	});



	function readImage(input) {
	    if ( input.files && input.files[0] ) {
	        var FR= new FileReader();
	        FR.onload = function(e) {
	             // $('#logoImage').attr( "src", e.target.result );
	             // $('#base').text( e.target.result );
	             settings.logo = e.target.result;
	             setLessVars(settings);
	        };       
	        FR.readAsDataURL( input.files[0] );
	    }
	}

	$("#logoUpload").change(function(){
	    readImage( this );
	});



});