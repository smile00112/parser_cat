$(document).ready(function(){
	$('.visible').on('click', function(){
		var object	= $(this);
		$.post("actions.html", { action: "update_visible", id: $(this).closest("tr").attr("data-id") }, function(data){
			data = JSON.parse(data);
			if(!data.error){
				if(data.visible){
					object.removeClass('false').addClass('true').attr('title','Скрыть');
				} else {
					object.removeClass('true').addClass('false').attr('title','Показать');
				}
			}
		});
	});
	$('.delete').on('click', function(){
		if (confirm('Вы действительно хотите удалить этот цвет?')){
			var id			= $(this).closest("tr").attr("data-id"),
					object	= $(this).closest("tr");
			$.post("actions.html", { action: "delete", id: id }, function(data){
				data = JSON.parse(data);
				if(!data.error){
					object.fadeTo("slow", 0, function(){
						object.remove();
					});
				}
			});
		}
	});
	$('.save').on('change', function(){
		var id			= $(this).closest("tr").attr("data-id"),
				field		= $(this).attr("name"),
				value		= $(this).val(),
				object	= $(this);
		$.post("actions.html", { action: "save_field", id: id, field: field, value: value }, function(data){
			data = JSON.parse(data);
			if(!data.error){
				if(field == 'sortir'){
					$('.wait').fadeIn("slow");
					location.reload(true);
				} else {
					var $callout = object.siblings(".callout");
					$callout.html(data.text).addClass("success").fadeIn("slow");
					setTimeout(function(){
						$callout.fadeOut("slow", function(data){
							$(this).removeClass("success");
						});
					},1000);
				}
			} else {
				var $callout = object.siblings(".callout");
				$callout.html(data.text).addClass("error").fadeIn("slow");
				setTimeout(function(){
					$callout.fadeOut("slow", function(data){
						$(this).removeClass("error");
					});
				},1000);
			}
		});
	});
});