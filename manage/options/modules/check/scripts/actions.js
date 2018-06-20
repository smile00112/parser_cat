// -----------------------------------------------------------------------------
$(document).ready(function(){
	var addSlideBtn = $("#addSlideBtn"),
			addSlideBtnOffset = addSlideBtn.offset().top;
	$(window).scroll(function(){
		if ( $(this).scrollTop() > addSlideBtnOffset && !addSlideBtn.hasClass("fixed") ){
			addSlideBtn.addClass("fixed");
		} else if($(this).scrollTop() <= addSlideBtnOffset && addSlideBtn.hasClass("fixed")) {
			addSlideBtn.removeClass("fixed");
		}
	});
});
// -----------------------------------------------------------------------------
$.fn.EditPath = function(){
	if (confirm('Изменить путь к модулю?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "edit_path", module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.InsertTable = function(){
	if (confirm('Добавить эту таблицу?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				name				= $(this).closest("tr").attr("data-name"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "insert_table", name: name, module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.RenameTable = function(){
	if (confirm('Вы действительно хотите переименовать эту таблицу?')){
		var name			= $(this).closest("tr").attr("data-name"),
				old_name	= $(this).closest("tr").attr("data-old-name"),
				object		= $(this).closest("tr");
		$.post("actions.html", { action: "rename_table", name: name, old_name: old_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.DeleteTable = function(){
	if (confirm('Вы действительно хотите удалить эту таблицу?')){
		var name		= $(this).closest("tr").attr("data-name"),
				object	= $(this).closest("tr");
		$.post("actions.html", { action: "delete_table", name: name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.InsertField = function(){
	if (confirm('Добавить это поле?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				table_name	= $(this).closest("tr").attr("data-name"),
				field				= $(this).attr("data-field"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "insert_field", table_name: table_name, field: field, module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.RenameField = function(){
	if (confirm('Переименовать это поле?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				table_name	= $(this).closest("tr").attr("data-name"),
				field				= $(this).attr("data-field"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "rename_field", table_name: table_name, field: field, module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.DeleteField = function(){
	if (confirm('Удалить это поле?')){
		var	table_name	= $(this).closest("tr").attr("data-name"),
				field				= $(this).attr("data-field"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "delete_field", table_name: table_name, field: field }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.InsertOption = function(){
	if (confirm('Добавить эту настройку?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				block_id		= $(this).closest("tr").attr("data-block_id"),
				option			= $(this).closest("tr").attr("data-option"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "insert_option", option: option, block_id: block_id, module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.RenameOption = function(){
	if (confirm('Переименовать эту настройку?')){
		var	module_name	= $(this).closest("table").attr("data-name"),
				block_id		= $(this).closest("tr").attr("data-block_id"),
				option			= $(this).closest("tr").attr("data-option"),
				object			= $(this).closest("tr");
		$.post("actions.html", { action: "rename_option", option: option, block_id: block_id, module_name: module_name }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------
$.fn.DeleteOption = function(){
	if (confirm('Удалить эту настройку?')){
		var	block_id	= $(this).closest("tr").attr("data-block_id"),
				option		= $(this).closest("tr").attr("data-option"),
				object		= $(this).closest("tr");
		$.post("actions.html", { action: "delete_option", option: option, block_id: block_id }, function(data){
			if(data > 0){
				object.fadeTo("slow", 0, function() {
					object.remove();
				});
			}
		});
	}
};
// -----------------------------------------------------------------------------