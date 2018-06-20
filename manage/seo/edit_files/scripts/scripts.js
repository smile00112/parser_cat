$.fn.Save = function(){
	var path = $(this).closest(".tabcontent").attr("data-file-path"),
			value = $(this).closest(".tabcontent").find("textarea").val();
	$(".wait").show();
	$.post("actions.html", { action: "save_file", path: path, value: value }, function(data){
		var answer = JSON.parse(data);
		$(".wait").hide();
		if(!answer.error){
			$(".ok").fadeIn();
			setTimeout(function(){$('.ok').fadeOut();parent.$.fancybox.close();},1000);
		}
	});
};
$(document).on("click", ".tabname", function(){
	$(".tabname").removeClass("active");
	$(this).addClass("active");
	$("div.tabcontent").hide();
	$("div[data-tabcontent='"+$(this).data('tabname')+"']").show();
});