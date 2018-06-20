$(document).on("click", ".visible", function(event){
	var id = $(this).attr('id');
	$.post('visible.html', { id: id }, function(data){
		if(data>0){
			$('#'+id).removeClass('fa-eye-slash').addClass('fa-eye'); $('#tr_'+id).attr('style', 'background-color: #e5efff');
		} else {
			$('#'+id).removeClass('fa-eye').addClass('fa-eye-slash'); $('#tr_'+id).attr('style', 'background-color: #eeeeee');
		}
	});
});