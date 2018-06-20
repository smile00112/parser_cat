$(document).ready(init);

function init(){
//Положение элементов
name_resize();	
$(window).resize(function() {
	name_resize();
	var winHeight=$(document).height();
	var winHeight=winHeight-200;
	var winWidth=$(document).width();
	var winWidth=winWidth-105;
	$(".way").css("width",winWidth);
	$(".table_main").css("height",winHeight);
	$(".main").css("height",winHeight);
});
$(".way").css("width",100)
$(".table_main").css("height",100);
$(".main").css("height",100);
var winHeight=$(document).height();
var winHeight=winHeight-210;
var winWidth=$(document).width();
var winWidth=winWidth-105;
$(".way").css("width",winWidth);
$(".table_main").css("height",winHeight);
$(".main").css("height",winHeight);

//В скрытое поле значение пути
var way_name=($("#way_name").text());	
way_name_space=way_name.replace(/\s+/g, '');
$("#hidden_way").attr("value",escape(way_name_space));

//Переключает вид
$('.switch_view').click(function(eventObject){
	var way_name=($("#way_name").text());
	way_name_space=way_name.replace(/\s+/g, '');	
	 window.location.href="switch_view.html?url="+way_name_space;
});
	

//При перемещении элемента считывает ID
$('.left').mousedown(function() {
	var id_name=($(this).attr('id'));
	var div_name=($("#font_"+id_name).text());
	var way_name=($("#way_name").text());	
	$(".delete").droppable({
		accept: '.left',
		activeClass: 'active',
		hoverClass: 'hover',			
		drop: function(){ 
			var query=""; 
			div_name_space=div_name.replace(/\s+/g, '');
			way_name_space=way_name.replace(/\s+/g, '');
			query=query+"name_delete="+escape(div_name_space)+"&";
			way="way="+escape(way_name_space);
			if (confirm('Вы действительно хотите удалить '+div_name_space+'?')) {
				  window.location.href="delete_clear.html?"+query+way;
			} 
			return false;
		} 
	});
});
	

$(".left").draggable({
	appendTo: 'body',
	containment: 'window',
	scroll: false,
	helper: 'clone',
	opacity: 0.9
});

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
function insertURL(input){
			var win = window.dialogArguments || opener || parent || top;
			tinyMCE = win.tinyMCE;
			var params = tinyMCE.activeEditor.windowManager.params;

			params.window.document.getElementById(params.input).value = input;
			try {
				params.window.ImageDialog.showPreviewImage(input);
			} catch(e) {}
tinyMCEPopup.close();
return false;
}

//В Opere input text меняет длину
function folder_input_text(name){
var query=""; //перечисление имен
var UA=window.navigator.userAgent,      // содержит переданный браузером юзерагент
//--------------------------------------------------------------------------------
	OperaB = /Opera[ \/]+\w+\.\w+/i,     //
	OperaV = /Version[ \/]+\w+\.\w+/i,   //
	FirefoxB = /Firefox\/\w+\.\w+/i,     // шаблоны для распарсивания юзерагента
	ChromeB = /Chrome\/\w+\.\w+/i,       //
	SafariB = /Version\/\w+\.\w+/i,      //
	IEB = /MSIE *\d+\.\w+/i,             //
	SafariV = /Safari\/\w+\.\w+/i,       //	
//--------------------------------------------------------------------------------
	browser = new Array(),               //массив с данными о браузере
	browserSplit = /[ \/\.]/i,           //шаблон для разбивки данных о браузере из строки
	OperaV = UA.match(OperaV),
	Firefox = UA.match(FirefoxB),
	Chrome = UA.match(ChromeB),
	Safari = UA.match(SafariB),
	SafariV = UA.match(SafariV),
	IE = UA.match(IEB),
	Opera = UA.match(OperaB);
	
	if(Opera){
		$("#"+name+"_id").replaceWith('<input type="text" name="'+name+'" id="'+name+'_id" size="46" maxlength="500"/>');
	}
	$("#"+name+"_id").focus();	

return false;
}

//Изменение длины имени от размера экрана
function name_resize(){
	var count_files=$("input:checkbox.checkbox:enabled").length;
	var width_name_table_s=$('.name_table').css('width');
	if(width_name_table_s){
		width_name_table=width_name_table_s.substr(0,width_name_table_s.length-2);
		width_name_norm=width_name_table/6;
		for(i=1;i<=count_files;i++){
			var name_length=$("#"+i).find('.name_table').text();
			if(width_name_norm<name_length.length){
				$("#"+i).find('.name_table').text(name_length.substr(0,width_name_norm-4)+'..');
				$("#"+i).find('.name_table').attr('title',name_length);
			}
		}
}
return false;
}

//---------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------CHECKBOX---------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//Выбрать все чекбоксы
function checkbox_all(spisok_files){	
		
	if($("#all_chek").prop("checked")){
		$(".checkbox").attr("checked","checked");
		
		var count=$("input:checkbox.checkbox:checked").length;
		n_file=spisok_files.split("|");
		for(i=1;i<=count;i++){
			$("#"+i+"_chek").attr("name","name_delete");
			$("#"+i+"_chek").attr("value",n_file[i-1]);
		}
		
		var all_sizes=$(".summ_file_size").text();
		$(".one_file_size").html(all_sizes);
	}
	else{
		$(".checkbox").removeAttr("checked");
		
		var count=$("input:checkbox.checkbox:enabled").length;
		n_file=spisok_files.split("|");
		for(i=1;i<=count;i++){
			$("#"+i+"_chek").attr("name","");
			$("#"+i+"_chek").attr("value","");
		}
		
		$(".one_file_size").html("0");
	}	

var count=$("input:checkbox.checkbox:checked").length;
$("span.count_file").html(count);

return false;
}

//Кликнуть по таблице
function click_tr(id,uri_src,original,width,height,type_file){			
	$(".zagolovok").find('.img_table').css("background-color", "#FFFFFF");
	$(".zagolovok").find('.name_table').css("background-color", "#FFFFFF");
	$(".zagolovok").find('.date_table').css("background-color", "#FFFFFF");
	$("#"+id).find('.img_table').css("background-color", "#E0E0E0");
	$("#"+id).find('.name_table').css("background-color", "#E0E0E0");
	$("#"+id).find('.date_table').css("background-color", "#E0E0E0");
		
	var name_file=$("#"+id).find('.name_table').text();
		
	var dote="";
	if(name_file.length>25){
		dote="..";
	}
		
	var size_file=$("#"+id).find('.size_table').text();
	if(width){
		var param_w_h=width+"x"+height+"px";
	}
	else{
		var param_w_h="";
	}
	//var razreshenie="Разрешение:";
	var razreshenie="";
	if(original){
		$(".img_add").html('<div class="status_img"><img height="70px;" src="'+uri_src+'"></div><div class="status_file"><table><tr><td>Имя файла:</td><td>'+name_file.substr(0, 15)+dote+'</td></tr><tr><td>Тип файла:</td><td>'+type_file+'</td></tr><tr><td>Размер файла:</td><td>'+size_file+'</td></tr><tr><td>'+razreshenie+'</td><td>'+param_w_h+'</td></tr></table></div>');
	}
	else{
		$(".img_add").html('<div class="status_img"><img src="'+uri_src+'"></div><div class="status_file"><table><tr><td>Имя файла:</td><td>'+name_file.substr(0, 25)+dote+'</td></tr><tr><td>Тип файла:</td><td>'+type_file+'</td></tr><tr><td>Размер файла:</td><td>'+size_file+'</td></tr><tr><td>'+razreshenie+'</td><td>'+param_w_h+'</td></tr></table></div>');
	}	
return false;
}

//Кликнуть по checkbox
function click_checkbox(id,uri_src,original,width,height,type_file){
	var count=$("input:checkbox.checkbox:checked").length;
	$("span.count_file").html(count);
	
	if($("#"+id+"_chek").prop("checked")){
		if(!type_file){
			type_file="папка";
			uri_src="picturies/extension/folder.png"
		}
		
		click_tr(id,uri_src,original,width,height,type_file);
		
		$("#"+id+"_chek").attr("checked","checked"); //Добавить в chekbox
		$("#"+id+"_chek").attr("name","name_delete");
		var name_file=$("#"+id).find('.name_table').text();
		$("#"+id+"_chek").attr("value",name_file);
		
		var size=$("#"+id).find('.size_table span').text();
		var all_size=$(".one_file_size").text();
		all_size=all_size/1+size/1;
		$(".one_file_size").html(all_size);
		
		active_download();//Делает прозрачным картинку скачать файл
	
	}
	else{
		$(".zagolovok").find('.img_table').css("background-color", "#FFFFFF");
		$(".zagolovok").find('.name_table').css("background-color", "#FFFFFF");
		$(".zagolovok").find('.date_table').css("background-color", "#FFFFFF");
		$("#"+id+"_chek").removeAttr("checked");
		var name_file=$("#"+id).find('.name_table').text();
		$("#"+id+"_chek").attr("name","");
		$("#"+id+"_chek").attr("value","");
		$(".img_add").html("");
		
		var size=$("#"+id).find('.size_table span').text();
		var all_size=$(".one_file_size").text();
		all_size=all_size/1-size/1;
		$(".one_file_size").html(all_size);
		
		active_download();//Делает прозрачным картинку скачать файл
	}	
return false;
}

	
//---------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------FOLDER_LOAD FILE_LOAD-----------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

function fileADD(uri_get,spisok_file,ext_filters,win,field_name) {
tinyMCE.activeEditor.windowManager.open({ file : "/manage/v3filemanager/file_load.html?opener=tinymce&url="+uri_get+"&name_file="+spisok_file+"&ext="+ext_filters+"",
title	: "FileManager.Plupload",
width : 750,
height : 370,
resizable : "yes",
inline : true,
close_previous : "no",
popup_css : false,
}, {
window : win,
input : field_name
});
return false;
}

function folderADD(uri_get,spisok_file,ext_filters,win,field_name){
tinyMCE.activeEditor.windowManager.open({ file : "/manage/v3filemanager/folder_load.html?opener=tinymce&uri_get="+uri_get+"",
title	: "FileManager.Plupload",
width : 380,
height : 160,
resizable : "no",
inline : true,
close_previous : "no",
popup_css : false,
}, {
window : win,
input : field_name
});

return false;
}
//---------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------CUT COPY PASTE---------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//получение списка выделенных файлов 
function list_checked(spisok){
	n_file=spisok.split("|");
	var count=n_file.length;
	var name="";
	for(start=1;start<=count;start++){
		if($("#"+start+"_chek").prop("checked")){
			name=name+($("#"+start+"_chek").attr('value'))+"|";
		}
	}
return name;
}
function arr_list_checked(spisok){
	n_file=spisok.split("|");
	var count=n_file.length;
	var name=[];
	var arr_i=0;
	for(start=1;start<=count;start++){
		if($("#"+start+"_chek").prop("checked")){
			name[arr_i]=($("#"+start+"_chek").attr('value'));
			arr_i++;
		}
	}
return name;
}
//общий список, список файлов(проверяет есть ли совпадения)
function spisok_proverka(spisok,spisok_paste){
	n_file=spisok.split("|");
	var count=n_file.length;
	n_paste=spisok_paste.split("|");
	var n=n_paste.length;
	
	if(spisok_paste){
		for(i=0;i<count/1-1;i++){
			for(g=0;g<=n/1-1;g++){
				if(n_file[i]==n_paste[g]){
					return true;
				}
			}
		}
	}
return false;
}

function cut_file(url,spisok){
	name=list_checked(spisok);
	
	$.ajax({
		url: "toolbar_up/cut.html?url="+url+"&spisok="+name,
		success: function(y){
			if(y){
				$("#picturies_paste").fadeTo(1,1);
				n_file=spisok.split("|");
				var count=n_file.length;
				var cnt_chek=arr_list_checked(spisok).length;
				for(i=1;i<=count;i++){
					for(g=1;g<=cnt_chek;g++){
						if(arr_list_checked(spisok)[g/1-1]==($("#"+i+"_chek").attr("value"))){
							var id=i;
							$("#"+id).find('.img_table').css("opacity", "0.7");
							$("#"+id).find('.name_table').css("opacity", "0.7");
							$("#"+id).find('.date_table').css("opacity", "0.7");
						}
					}
				}
			}
		},
		error: function(){
			alert("Произошла ошибка");
		}
	});
return false;
}

function copy_file(url,spisok){
	name=list_checked(spisok);
	$.ajax({
		url: "toolbar_up/copy.html?url="+url+"&spisok="+name,
		success: function(y){
			if(y){
				$("#picturies_paste").fadeTo(1,1);
				n_file=spisok.split("|");
				var count=n_file.length;
				var cnt_chek=arr_list_checked(spisok).length;
				for(i=1;i<=count;i++){
					for(g=1;g<=cnt_chek;g++){
						if(arr_list_checked(spisok)[g/1-1]==($("#"+i+"_chek").attr("value"))){
							var id=i;
							$("#"+id).find('.img_table').css("opacity", "0.7");
							$("#"+id).find('.name_table').css("opacity", "0.7");
							$("#"+id).find('.date_table').css("opacity", "0.7");
						}
					}
				}	
			}
		},
		error: function(){
			alert("Произошла ошибка");
		}
	});
return false;
}

function paste_file(url,cut,copy,paste,spisok){
	var opacity=($("#picturies_paste").css('opacity'));
	if(cut){
		name=cut;
	}else{
		name=copy;
	}
	if(cut||copy){
		if(spisok_proverka(spisok,name)){
			if (confirm("Файл с таким именем уже существует\nпереместить с заменой?")) {
				  location.href="toolbar_up/paste.html?url="+url;
			}
		}else{
			location.href="toolbar_up/paste.html?url="+url;
		}
	}
return false;
}
//---------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------RENAME DOWNLOAD-----------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
function rename(uri_get,spisok_file,ext_filters,spisok,name_view,win,field_name) {
name=list_checked(spisok);
	if(arr_list_checked(spisok).length){
		if(arr_list_checked(spisok).length>1 || arr_list_checked(spisok).length==0){
			$("#picturies_load").fadeTo(1,0.7);
		}else{
			name=arr_list_checked(spisok);
			tinyMCE.activeEditor.windowManager.open({ file : "/manage/v3filemanager/rename.html?opener=tinymce&url="+uri_get+"&name_file="+spisok_file+"&ext="+ext_filters+"&name="+name,
			title	: "FileManager.Plupload",
			width : 370,
			height : 150,
			resizable : "yes",
			inline : true,
			close_previous : "no",
			popup_css : false,
			}, {
			window : win,
			input : field_name
			});
		}
	}else{
		if(name_view){
			name=name_view;
			tinyMCE.activeEditor.windowManager.open({ file : "/manage/v3filemanager/rename.html?opener=tinymce&url="+uri_get+"&name_file="+spisok_file+"&ext="+ext_filters+"&name="+name,
				title	: "FileManager.Plupload",
				width : 370,
				height : 150,
				resizable : "yes",
				inline : true,
				close_previous : "no",
				popup_css : false,
				}, {
				window : win,
				input : field_name
			});
		}else{
			$("#picturies_load").fadeTo(1,0.7);
		}
	}
	
return false;
}

function file_download(url,spisok){
	name=arr_list_checked(spisok);
	if(arr_list_checked(spisok).length>1 || arr_list_checked(spisok).length==0){
		$("#picturies_load").fadeTo(1,0.7);
	}else{
		//alert(name);
		//for(i=0;i<arr_list_checked(spisok).length;i++){
		//alert(arr_list_checked(spisok)[i]);
		//	location.href="toolbar_up/download.html?url="+url+"&name="+arr_list_checked(spisok)[i];
		//}
		location.href="toolbar_up/download.html?url="+url+"&name="+name;
	}
return false;
}

function active_download(){
	var count=$("input:checkbox.checkbox:checked").length;
	if(count>1 || count==0){
		$("#picturies_load").fadeTo(1,0.7);
		$("#picturies_rename").fadeTo(1,0.7);
	}else{
		$("#picturies_load").fadeTo(1,1);
		$("#picturies_rename").fadeTo(1,1);
	}
return false;
}