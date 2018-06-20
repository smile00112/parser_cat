@CLASS
clean_all


@init[]
$run[yes]

@clean[]
^void:sql{truncate menus}
^void:sql{INSERT INTO menus 
	(id_menu, typepage, name, parent, uri, sortir, mainpage, visible, level, head, keywords, descript, redirect, email)
	VALUES ( 'a', 'textext', 'О компании', 0, NULL, 10, 1, '1', 0, NULL, NULL, NULL, NULL, NULL)
	}
