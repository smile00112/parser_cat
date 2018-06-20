################################################################################
@auto[]
^connect[$site:connectString]{
	^cms.SetCurrentModule[gallery]
}
################################################################################
@module_info[]
^use[./module_info.p]
$result[^module_information[]]
################################################################################
@check_options[]
$table_opt[^int:sql{select count(*) from te_opt where id_te='$form:id'}[$.default{0}]]
^if($table_opt==0){
	^create_new_options[]
}	
################################################################################
# создание настроек
@create_new_options[]
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить в виде таблицы','viewastable','',1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Кол-во колонок','countcol','2',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина превью','preview_width','180',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота превью','preview_height','999',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина','width','800',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота','height','999',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Описание','descript','',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить название блока','view_name_gallery','',1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить описание фото','view_name_foto',1,1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Делать только превью','make_resize_preview','',1)}
################################################################################