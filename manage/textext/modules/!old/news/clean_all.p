@CLASS
clean_all


@init[]
$run[yes]

@clean[]
^void:sql{truncate news}
^void:sql{truncate news_group}
^void:sql{truncate news_gallery}
^void:sql{INSERT INTO news_group (id, name, rewrite, sortir, id_page) VALUES (1, 'Основная', 'main', 30, 7)}

