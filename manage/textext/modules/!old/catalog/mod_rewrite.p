################################################################################
@CLASS
mod_rewrite
################################################################################
@make_rewrite[]
$cat_table[^table::sql{select id, name, idpage, url from catalog}]]
^cat_table.menu{
	$name[^if(def $cat_table.url){$cat_table.url}{$cat_table.id}]
	$uri[^string:sql{select uri from menus where id='$cat_table.idpage'}[$.default{catalog}]]
	$rule[RewriteRule	^^$uri/$name/^$	index.html?p=${cat_table.idpage}&idc=$cat_table.id	^[L,QSA^]]
	^if(def $cat_table.url){
 		$rule[${rule}^#0ARewriteRule ^^$uri/$cat_table.id/(.*)^$ $uri/$name/^$1 [L,R=301]]
	}
	$tmp[${tmp}^#0A${rule}]
}
$result[$tmp]
################################################################################