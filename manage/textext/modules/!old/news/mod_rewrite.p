################################################################################
@CLASS
mod_rewrite
################################################################################
@make_rewrite[]
$tmp[]
$news_idpage[^table::sql{select id, uri from menus where id IN (select idpage from text_ext where pref_block='news')}]
^if($news_idpage){
 ^news_idpage.menu{
  $news_end[^table::sql{select id, url from news where id_page='$news_idpage.id'}]]
  ^if($news_end){
   ^news_end.menu{
    ^if(def $news_end.url){$end_url[$news_end.url]}{$end_url[$news_end.id]}
    $rule[RewriteRule ^^$news_idpage.uri/${end_url}/^$ index.html?p=${news_idpage.id}&id=${news_end.id} [L,QSA]]
    $tmp[${tmp}^#0A${rule}]
   }
  }
 }
}
$result[$tmp]
################################################################################