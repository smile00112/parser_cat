$(document).ready(function (){
	addBlock();
	$('.struct_add_razdel>span:first-child').click(function(){
		var bt = $('.struct_add_razdel').css('bottom');
		if(bt != '0px'){
			$('.struct_add_razdel').animate({
				bottom: 0
			}, 160 );
		}
		else {
			$('.struct_add_razdel').animate({
				bottom: -68
			}, 160 );
		}
	});
	//console.log ($(document).height());
	//console.log (document.body.clientHeight);
});
$(window).resize(function (){
	addBlock();
	//console.log ('смена размера');
});
$(window).scroll(function (){
	//console.log ($(this).scrollTop());
	addBlock();
	headerFix();
});

function addBlock() {
	var h_doc = $(document).height();
	var h_client = document.body.clientHeight;
	if (h_doc <= h_client || $(this).scrollTop() >= h_doc - h_client - 60){
		$('.struct_add_razdel').addClass('normal');
	}else{
		$('.struct_add_razdel').removeClass('normal');
	}
}

function headerFix() {
	if ($(this).scrollTop() > 160) {
		$('#fixHead').fadeIn();
	}else {
		$('#fixHead').fadeOut(40);
	}
}
