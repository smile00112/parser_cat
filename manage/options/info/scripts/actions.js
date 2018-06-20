$.fn.UpdateModuleVersion = function(){
	var module	= $(this).attr("data-module"),
			version	= $(this).attr("data-version"),
			object	= $(this);
	$.post("actions.html", { action: "update_module_version", module: module, version: version }, function(answer){
		answer = JSON.parse(answer);
		if(!answer.error){
			object.removeAttr("onClick").removeClass('red').removeClass('pointer');
			$("#max-"+module).html(version);
		} else {
			console.log(answer);
		}
	});
};

$.fn.UpdateCMSVersion = function(){
	var site	= $(this).closest("tr").attr("data-site"),
			cms_version	= $(this).closest("tr").attr("data-cms-version"),
			object	= $(this).closest("table");
	$.post("actions.html", { action: "update_cms_version", site: site, cms_version: cms_version }, function(answer){
		answer = JSON.parse(answer);
		if(!answer.error){
			object.remove();
		} else {
			console.log(answer);
		}
	});
};