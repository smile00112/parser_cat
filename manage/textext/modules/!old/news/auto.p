################################################################################
@auto[]
^use[/classes/dtf.p]
^use[/classes/scroller.p]
^use[news.p]
^connect[$site:connectString]{
# $blockId(^if(def $form:idblock){$form:idblock}{$form:id})
 $blockId(^textext:GetBlockIdByPageId[$form:idpage])
 $news[^news::create[$blockId]]
 ^cms.SetCurrentModule[$news.className;true]
}
$show_sticker(0)
$show_body(1)
$show_time(0)
$show_main(0)
$show_main_one(0)
$show_sync(1)
################################################################################
@top_menu[page]
<table cellpadding="4" cellspacing="1" bgcolor="#999999">
<tr>
	<td width="150" ^if($page==1){class="tNS"}{class="tN"}><a href="index.html?idpage=$form:idpage">Новости</a></td>
#	<td width="150" ^if($page==2){class="tNS"}{class="tN"}><a href="groups.html?idpage=$form:idpage">Темы новостей</a></td>
	<td width="150" ^if($page==3){class="tNS"}{class="tN"}><a href="search_date.html?idpage=$form:idpage">Поиск по дате</a></td>
</tr>
</table>
################################################################################
@script[]
<script type="text/javascript" src="panel_slide.js"></script>
<script type="text/javascript" src="/lib/dyndatetime/jquery.dynDateTime.js"></script>
<script type="text/javascript" src="/lib/dyndatetime/lang/calendar-en.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="/lib/dyndatetime/css/calendar-blue.css"  />
<script>
	jQuery(document).ready(function() {
		jQuery(".mouse_over").hover(
			function(){				
				jQuery(this).removeClass("tN");
				jQuery(this).addClass("tNS");				
			},
			function(){
				jQuery(this).removeClass("tNS");
				jQuery(this).addClass("tN");
			}		
		);	
	});
</script>
################################################################################
@print_row_news[table_news]
$datapr[^date::create[$table_news.date_news]]
$curr_photo[^table::sql{select * from news_gallery where news_id='$table_news.id'}[$.limit(1)]]		
<table border="0" width="100%" cellpadding="5" cellspacing="1" bgcolor="#999999" style="margin:5">
 <tr class="tN" ^if($table_news.visible == 1){style="background-color:#D5FFC6"}>
	<td align="center" valign="top" width="200">
	 $gallery_one[^news:GetGallery[$table_news.id;one]]
	 ^if(def $gallery_one.path){
		$small[/images/news/small/$gallery_one.path]
		$big[/images/news/big/$gallery_one.path]
   <img src="$small" title="$gallery_one.descript">						
	 }{<img src="images/no-photo.jpg" title="Нет изображения">	}
	 <br><br>
	 <table border="0" cellspacing="1" cellpadding="0" bgcolor="#999999">
    <tr class="tH">
     <td>
      <table border="0" cellspacing="0" cellpadding="10">
       <tr>
        <td>
         <p style="padding-top: 5"><a href="gallery.html?idpage=$form:idpage&news_id=$table_news.id">Фотогалерея</a></p>
        </td>
        <td>
         <p style="padding-top: 5"><a href="videogallery.html?idpage=$form:idpage&news_id=$table_news.id">Видеогалерея</a></p>
        </td>
       </tr>
			</table>
      <table border="0" cellspacing="0" cellpadding="10">
       <tr>
        <td>
         <p style="padding-top: 5"><a href="files.html?idpage=$form:idpage&news_id=$table_news.id">Файлы</a></p>
        </td>
        <td>
         <p style="padding-top: 5"><a href="attributes.html?idpage=$form:idpage&news_id=$table_news.id">SEO-Атрибуты записи</a></p>
        </td>
       </tr>
			</table>
		 </td>  
    </tr>
   </table> 	 	
  </td>
	<td valign="top" class="aL">
	 <table border="0" cellspacing="0" cellpadding="3">
    <tr>
     <td>
      <strong>Автор:</strong>
     </td>
     <td>
      ^string:sql{SELECT fio FROM auth_accounts WHERE user_id='$table_news.user_id'}[$.default{Администратор}]
     </td>
    </tr>
    <tr>
     <td>
      <strong>Дата:</strong>
     </td>
     <td>
      ^dtf:format[%d %h %Y^if($show_time==1){ %H:%M};$datapr;$dtf:rr-locale]
     </td>
    </tr>
    <tr>
     <td valign="top">
      <strong>Заголовок:</strong>
     </td>
     <td>
      $table_news.head
     </td>
    </tr>
		^if($show_body==1){
    <tr>
     <td valign="top">
      <strong>Анонс:</strong>
     </td>
     <td>
      ^untaint{$table_news.body}
     </td>
    </tr>
		}
    ^if($show_sticker){
    <tr>
     <td valign="top">
      <strong>Стикер:</strong>
     </td>
     <td>
      ^news:GetStickerName[$table_news.sticker_id]
     </td>
    </tr>
    }
	 </table>
  </td>
  <td align="center" valign="top" width="100">
	 <a href="javascript: if (confirm('Вы хотите удалить данную позицию?')){window.location.href='news_del.html?id=$table_news.id&idpage=$idpage'}">Удалить</a> <br><br> 
	 <a href="news_edit_form.html?idpage=$idpage&news_id=$table_news.id">Изменить</a><br><br>
	 ^if($table_news.visible == 1){<a href="hide.html?idpage=$idpage&news_id=$table_news.id">Скрыть</a>}{<a href="show.html?idpage=$idpage&news_id=$table_news.id">Утвердить</a>}<br><br>
	 ^if($show_sync eq 1){<a href="send_to_site_form.html?news_id=$table_news.id&idpage=$idpage">Дублировать</a><br><br>}
   ^if($show_main eq 1){<a href="set_main_news.html?news_id=$table_news.id&one=$show_main_one&id=$form:id&idpage=$form:idpage"^if($table_news.main eq 1){ class="bold green"}>^if($table_news.main eq 1){Главная}{Сделать главной}</a>}
#   ^if(def $show_main){<p id="$table_news.id" class="link^if($table_news.main eq 1){ bold green}" onclick='^$(this).setMainNewsClick()'>^if($table_news.main eq 1){Главная}{Сделать главной}</p>}
  </td>
 </tr>
</table>
<script>
^$.fn.setMainNewsClick = function(){
 var news_id = ^$(this).attr('id')^;
 ^$.post('set_main_news.html', { id: news_id, one: $show_main_one }, function(data){
  ^$('#'+news_id).removeClass()^;
  if(data>0)
  {^$('#'+news_id).text('Главная')^; ^$('#'+news_id).addClass('link bold green')^;}
  else
  {^$('#'+news_id).text('Сделать главной')^; ^$('#'+news_id).addClass('link')^;}
 })^;
}^;
</script>
################################################################################
@check_options[]
$table_opt[^int:sql{select count(*) from te_opt where id_te='$form:id'}[$.default{0}]]
^if($table_opt==0){
	^create_new_options[]
	}
#############################################################################
@create_new_options[]
$res[^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина превью','preview_width','220',0)}]
$res[^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота превью','preview_height','999',0)}]
$res[^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина','width','800',0)}]
$res[^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота','height','999',0)}]
#############################################################################