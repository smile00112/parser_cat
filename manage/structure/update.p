@CLASS
update

# инициализируем модуль и запоминаем путь
@init[vpath_block]
$run[yes]
$path_block[$vpath_block]

# процедура загрузки и обновления
@update_sql[filename]
$t[^file::load[text;$path_block/update/$filename]]
$template[^untaint{$t.text}]
^void:sql{$template}


@update[]
# v1.2 добавлено поле fio

^try{$tmp[^table::sql{select head from menus}]}{$exception.handled(true) ^self.update_sql[head.sql] head.sql <br>}
^try{$tmp[^table::sql{select keywords from menus}]}{$exception.handled(true) ^self.update_sql[keywords.sql] keywords.sql <br>}
^try{$tmp[^table::sql{select descript from menus}]}{$exception.handled(true) ^self.update_sql[descript.sql] descript.sql <br>}
^try{$tmp[^table::sql{select email from menus}]}{$exception.handled(true) ^self.update_sql[email.sql] email.sql <br>}
^try{$tmp[^table::sql{select redirect from menus}]}{$exception.handled(true) ^self.update_sql[redirect.sql] redirect.sql <br>}


^try{$tmp[^table::sql{select sortir from menus}]}{$exception.handled(true) ^self.update_sql[add_sortir.sql] add_sortir.sql <br>}
^try{$tmp[^table::sql{select visible from menus}]}{$exception.handled(true) ^self.update_sql[add_visible.sql] add_visible.sql <br>}
^try{$tmp[^table::sql{select level from menus}]}{$exception.handled(true) ^self.update_sql[upd_level.sql] upd_level.sql <br>}
^try{$tmp[^table::sql{select typepage from menus}]}{$exception.handled(true) ^self.update_sql[add_typepage.sql] add_typepage.sql <br>}
^try{$tmp[^table::sql{select security from menus}]}{$exception.handled(true) ^self.update_sql[add_security.sql] add_security.sql <br>}
    

	



	