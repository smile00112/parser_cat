################################################################################
@auto[]
^use[videogallery.p]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$videogallery[^videogallery::init[$cms_page_id;$form:id;$form:idpage;$form:idpage_name]]
	^cms.SetCurrentModule[$videogallery.className]
}
################################################################################
@check_options[]
$table_opt[^int:sql{select count(*) from te_opt where id_te='$form:id'}[$.default{0}]]
^if($table_opt==0){
 ^create_new_options[]
}	
################################################################################
# создание настроек
@create_new_options[]
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Колво колонок','countcol','2',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина','width','320',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота','height','240',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Описание','descript','',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить название блока','view_name_gallery','',1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить описание видео','view_name_video',1,1)}
################################################################################