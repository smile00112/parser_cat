################################################################################
@CLASS
update
################################################################################
# инициализируем модуль и запоминаем путь
@init[vpath_block]
$run[yes]
$path_block[$vpath_block]
################################################################################
# процедура загрузки и обновления
@update_sql[filename]
$t[^file::load[text;$path_block/update/$filename]]
$template[^untaint{$t.text}]
^void:sql{$template}
################################################################################
@update[param]
# v1.2 добавлено поле fio
^try{$tmp[^table::sql{SELECT fio FROM admins}]}{$exception.handled(true) ^self.update_sql[add_fio.sql] add_fio.sql <br>}
# добавление таблицы с правами на видимость
^try{$tmp[^table::sql{SELECT * FROM admins_access}]}{$exception.handled(true) ^self.update_sql[table_admins_access.sql] table_admins_access.sql <br>}
# ставим права пользователю 
^if(!def $param){$tmp[^void:sql{UPDATE admins SET level=10 WHERE login="a3"}] a3 проставлены права <br>}
^if(!def $param){$tmp[^void:sql{UPDATE admins SET level=10 WHERE login="kirill"}] kirill проставлены права <br>}
################################################################################	