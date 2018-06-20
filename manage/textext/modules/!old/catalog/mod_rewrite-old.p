################################################################################
@CLASS
mod_rewrite
################################################################################
@make_rewrite[]
$cat_table[^table::sql{select id, name, idpage from catalog group by idpage}]]
^cat_table.menu{
	$uri[^string:sql{select uri from menus where id='$cat_table.idpage'}[$.default{catalog}]]
	$rule[RewriteRule	^^$uri/([0-9]+)/^$	index.html?p=${cat_table.idpage}&idc=^$1	^[L,QSA^]]
	$tmp[${tmp}^#0A${rule}]
}
$result[$tmp]
################################################################################