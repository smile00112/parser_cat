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
^void:sql{drop table IF EXISTS news}
^void:sql{drop table IF EXISTS news_group}
^void:sql{drop table IF EXISTS  news_gallery}
^try{$tmp[^table::sql{select * from news}]}{$exception.handled(true) ^self.update_sql[create1.sql] Создание 1<br>}
^try{$tmp[^table::sql{select * from news_gallery}]}{$exception.handled(true) ^self.update_sql[create2.sql] Создание 2<br>}
^try{$tmp[^table::sql{select * from news_group}]}{$exception.handled(true) ^self.update_sql[create3.sql] Создание 3<br>}