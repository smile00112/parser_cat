################################################################################
@CLASS
mod_rewrite
################################################################################
@make_rewrite[]
# Инициализируем хэш ответа
$answer[
	$.htaccess[]
	$.sitemap[^hash::create[]]
]
$pages[^table::sql{SELECT id, name, uri, mainpage, redirect FROM menus WHERE visible=1 AND ( id_menu='a' OR id_menu='b' ) ORDER BY sortir}]
$pagesHash[^pages.hash[id]]
$counter(0)
^pages.menu{
	^if(def $pages.redirect){
		$redirect[^pages.redirect.split[^#] ]
		^if(^redirect.count[]==2){
			^redirect.offset(1)
			$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^$pages.uri/^$ ${redirect.piece} [L,R=301]]
		}{
			$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^$pages.uri/^$ index.html?p=${redirect.piece} [L,QSA]]
		}
	}{
		^if(def $pages.uri && !-d "/$pages.uri/"){
			^counter.inc[]
			^if($counter>1){$answer.htaccess[${answer.htaccess}^#0A]}
			^if($pages.mainpage){
				$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^$pages.uri/^$ / [R=301,L]]
			}{
				$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^$pages.uri/^$ index.html?p=${pages.id} [L,QSA]]
			}
		}
		$answer.sitemap.[$pages.id][^hash::create[]]
		$answer.sitemap.[$pages.id].loc[${env:REQUEST_SCHEME}://$env:SERVER_NAME/^if(!$pages.mainpage){$pages.uri/}]
	}
}
$result[$answer]
################################################################################