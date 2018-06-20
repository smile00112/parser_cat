$(document).ready(function(){

	$('.fa-chevron-up, .element-name').on('click', function(){
		$(this).closest(".element-string").toggleClass("close");
	});

	$('.deleteElement').on('click', function(){
		if (confirm('Вы действительно хотите удалить этот элемент?')){
			var object	= $(this).closest(".element-string");
			$.post("../actions.html", { action: "delete", id: object.attr("data-id") }, function(data){
				if(data > 0){
					object.fadeTo("slow", 0, function() {
						object.remove();
					});
				}
			});
		}
	});

});