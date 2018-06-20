################################################################################
@CLASS
news
################################################################################
@auto[]
$self.classVersion[1.50]
$self.classBuildDate[09.12.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[news]
$self.classDescription[Новости]
$self.classModuleDescription[Новости]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetSEOData</font>[], инициализирующая переменную <strong>^$site.currentPage</strong> данными SEO полей.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.49 (09.10.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetOpenGraphData</font>[params], возвращающая массив (hash) с данными OpenGraph разметки блока текущей страницы.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.48 (15.07.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetBreadcrumbs</font>[pageUrl], возвращающая массив (hash) с хлебными крошками блока текущей страницы.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.47 (10.09.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetNewsByUrl</font>[url^;params], которая возвращает новость по её url (создана для работы через ajax).</li>
			<li>В функцию <font color="red">^@Show</font>[params], добавлен параметр <strong>params</strong>, для передачи через них параметров, которые в обычном случае передаются через GET-параметры.</li>
			<li>В функцию <font color="red">^@GetNewsById</font>[id^;params], добавлен параметр <strong>params</strong>, для передачи через них параметров, управляющих выдачей данных. Это сделано после идентификации следующей ошибки: не отображаются CEO данные о новости, если она скрыта.li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.46 (05.06.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GenerateHtaccessRules</font>[], которая добавляет записи блока в файл <strong>.htaccess</strong>.</li>
			<li>Добавлена переменная <strong>self.settings.showDate</strong>, которая отвечает за отображение даты публикации новости на сайте.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.45 (18.04.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@ShowAllNews</font>[], которая отображает все новости сразу.</li>
			<li>Добавлена функция <font color="red">^@GetCountAllNews</font>[params], которая возвращает количество всех новостей в зависимости от параметров <strong>params</strong>.</li>
			<li>В функцию <font color="red">^@GetNews</font>[pageId^;params] добавлен параметр <strong>exclude</strong> и обработана ситуация, когда <strong>pageId</strong> не передаётся.</li>
			<li>В функцию <font color="red">^@GetMainImage</font>[news_id^;params] добавлен параметр <strong>params</strong> и обработана ситуация, когда передаётся <strong>params.visible</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.44 (02.03.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetNewsTitle</font>[id], которая возвращает заголовок новости <strong>id</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetNewsKeywords</font>[id], которая возвращает ключевые слова новости <strong>id</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetNewsDescription</font>[id], которая возвращает описание новости <strong>id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.43 (10.02.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@SetMainImages</font>[block_id], которая проставляет флаг главного изображения для всех новостей блока <strong>block_id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.42 (30.11.2015):</u></strong>
		<ol>
			<li>Функция <font color="red">^@SetDefaultBlockOptions</font>[block_id^;params] перенесена в класс <strong>textext.p</strong>.</li>
			<li>В функции <font color="red">^@SetMainImage</font>[image_id], исправлена ошибка, появляющаяся при условии отстутствия главного изображения.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.41 (25.11.2015):</u></strong>
		<ol>
			<li>Добавлены переменные для проверки класса разделом <strong>check</strong> модуля <strong>siteclass</strong>.</li>
			<li>Переделана работа функции <font color="red">^@SetDefaultBlockOptions</font>[block_id^;params] класса <strong>news_cms.p</strong> и в неё добавлен параметр <strong>^$params</strong> (хэш), инициализирующий значения опций по умолчанию.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.4 (04.09.2014):</u></strong>
		<ol>
			<li>Функции редактирования перенесены в класс news_cms.</li>
			<li>Удалена ф-я <font color="red">^@GetMainNews</font>[pageId^;limitCount^;offsetCount^;order^;orderType].</li>
			<li>Удалена ф-я <font color="red">^@GetGallery</font>[newsId^;one^;offset].</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.3 (08.04.2014):</u></strong>
		<ol>
			<li>Класс переделан под новый формат.</li>
			<li>Добавлена функция <font color="red">^@GetNewsNameById</font>[newsId], которая возвращает название новости.</li>
			<li>Добавлена функция <font color="red">^@ShowStickerNews</font>[stickerId^;count^;tmpl^;link], которая возвращает новости по стикеру.</li>
			<li>Добавлена функция <font color="red">^@ShowMainNews</font>[count^;tmpl^;link], которая возвращает главные новости.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.2 (01.10.2013):</u></strong>
		<ol>
			<li>В функцию <font color="red">^@ShowLastNews</font> добавлены 2 параметра: <strong>tmpl</strong> (шаблон) и <strong>link</strong> (ссылка).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (06.09.2013):</u></strong>
		<ol>
			<li>Добавлен календарь событий.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (31.07.2013):</u></strong>
		<ol>
			<li>Создан класс <strong>news.p</strong> для работы с новостями.</li>
		</ol>
	</p>
]
# Таблица "Новости"
$self.newsTable[
	$.name[news]
	$.file[news.table]
]
# Таблица "Галерея Новостей"
$self.newsGalleryTable[
	$.name[news_gallery]
	$.file[news_gallery.table]
]
# Таблица "Файлы Новостей"
$self.newsFilesTable[
	$.name[news_files]
	$.file[news_files.table]
]
# Таблица "Стикеры Новостей"
$self.newsStickersTable[
	$.name[news_stickers]
	$.file[news_stickers.table]
]
# Таблица "Типы Новостей"
$self.newsTypesTable[
	$.name[news_types]
	$.file[news_types.table]
]
# Таблица "Тексты Новостей"
$self.newsTextsTable[
	$.name[news_text]
	$.file[news_text.table]
]
# Папка Новостей
$self.newsFolder[/news]
# Путь к файлам новостей
$self.filesFolder[/files/news]
# Путь к иконкам файлов
$self.fileIconsFolder[/images/file_icons]
# Путь к изображениям новостей
$self.imagesFolder[
	$.root[/images/news]
	$.src[/images/news/src]
	$.big[/images/news/big]
	$.small[/images/news/small]
]
# Ширина изображений
$self.imagesWidth[
	$.small(220)
	$.big(800)
]
# Соотношение сторон изображения
$self.imagesAspectRatio(^eval(800/600))
# Ширина видео
$self.videosWidth[
	$.small(200)
	$.big(510)
]
# Сортировка по умолчанию
$self.order[date_news]
# Тип сортировки по умолчанию
$self.orderType[DESC]
# Количество новостей на странице
$self.newsPerPage(10)
# Количество изображений в строке
$self.imagesInRow(3)
# Настройки модуля
$self.settings[
	$.showSticker(0)
	$.showTime(0)
	$.showBody(1)
	$.showMain(0)
	$.oneMain(0)
	$.showType(0)
	$.showSync(0)
	$.showAuthor(0)
	$.setTextBody(1)
	$.template[]
	$.joint(0)
	$.showDate(1)
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
$self.imagesWidth.small(^textext:GetOptionValue[small_images_width;$self.blockId;$self.imagesWidth.small])
$self.imagesWidth.big(^textext:GetOptionValue[big_images_width;$self.blockId;$self.imagesWidth.big])
$AspectRatio[^textext:GetOptionValue[aspect_ratio;$self.blockId;$self.imagesAspectRatio]]
$AspectRatio[^AspectRatio.replace[\;/]]
$AspectRatio[^AspectRatio.replace[,;.]]
^try{
	^if(^AspectRatio.pos[/] == -1){
		$self.imagesAspectRatio($AspectRatio)
	}{
		$parts[^AspectRatio.split[/;lh]]
		$self.imagesAspectRatio(^eval($parts.0/$parts.1))
	}
}{
	$exception.handled(true)
}
$self.newsPerPage(^textext:GetOptionValue[news_per_page;$self.blockId;$self.newsPerPage])
$self.settings.showSticker(^textext:GetOptionValue[show_sticker;$self.blockId;$self.settings.showSticker])
$self.settings.showTime(^textext:GetOptionValue[show_time;$self.blockId;$self.settings.showTime])
$self.settings.showBody(^textext:GetOptionValue[show_body;$self.blockId;$self.settings.showBody])
$self.settings.showMain(^textext:GetOptionValue[show_main;$self.blockId;$self.settings.showMain])
$self.settings.oneMain(^textext:GetOptionValue[one_main;$self.blockId;$self.settings.oneMain])
$self.settings.showSync(^textext:GetOptionValue[show_sync;$self.blockId;$self.settings.showSync])
$self.settings.showType(^textext:GetOptionValue[show_type;$self.blockId;$self.settings.showType])
$self.settings.showAuthor(^textext:GetOptionValue[show_author;$self.blockId;$self.settings.showAuthor])
$self.settings.setTextBody(^textext:GetOptionValue[set_text_body;$self.blockId;$self.settings.setTextBody])
$self.settings.template[^textext:GetOptionValue[template;$self.blockId;$self.settings.template]]
^if(def $self.settings.template){
	$self.newsFolder[${self.newsFolder}/${self.settings.template}]
}
$self.settings.joint(^textext:GetOptionValue[joint;$self.blockId;$self.settings.joint])
$self.settings.showDate(^textext:GetOptionValue[show_date;$self.blockId;$self.settings.showDate])
################################################################################
@GetClassInfo[]
$result[
	$.version[$self.classVersion]
	$.build_date[$self.classBuildDate]
	$.developer[$self.classDeveloper]
	$.module_name[$self.className]
	$.module_description[$self.classDescription]
	$.history[$self.classHistory]
]
################################################################################
@GetNewsNameById[newsId]
$result[^string:sql{SELECT head FROM $self.newsTable.name WHERE id='$newsId'}]
################################################################################
@GetNewsUrl[news]
^if(def $news.url){$result[$news.url]}{$result[$news.id]}
################################################################################
@GetNews[pageId;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[$self.order]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.newsPerPage)}
	$result[^table::sql{
		SELECT n.id, n.date_news AS date, n.head, n.body, n.visible, s.name AS sticker, u.id AS author_id, u.first_name AS author, n.id_page, n.url, n.sticker_id, n.type_id, n.full_text, n.main
		FROM $self.newsTable.name AS n
		LEFT JOIN $site:siteUsersTable.name AS u ON n.user_id=u.id
		LEFT JOIN $self.newsStickersTable.name AS s ON n.sticker_id=s.id
		WHERE 1=1
			^if(^pageId.int(0)>0){ AND n.id_page=$pageId}
			^if(def $params.exclude){ AND n.id_page NOT IN ($params.exclude)}
			^if(def $params.visible){ AND n.visible=$params.visible}
			^if(def $params.main){ AND n.main=$params.main}
			^if(def $params.begin && def $params.end){ AND date_news BETWEEN '$params.begin' AND '$params.end'}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.debug[
			<p>Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
			<p>Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
		]
	]
}
################################################################################
@GetCountAllNews[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	$result(^int:sql{
		SELECT COUNT(*)
		FROM $self.newsTable.name
		WHERE 1=1
			^if(def $params.visible){ AND visible=$params.visible}
			^if(def $params.exclude){ AND id_page NOT IN ($params.exclude)}
	})
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetFiles[news_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.newsPerPage)}
	$result[^table::sql{
		SELECT id, name, descript, sortir, visible
		FROM $self.newsFilesTable.name
		WHERE news_id=$news_id^if(def $params.visible){ AND visible=$params.visible}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetNewsById[id;params]
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE id=$id^if(def $params.visible){ AND visible=$params.visible}}]
################################################################################
@GetNewsByUrl[url;params]
if(def $params.visible){$visible($params.visible)}{$visible(1)}
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE url="$url" AND visible=$visible}]
################################################################################
@GetNewsBySticker[id;limitCount;offsetCount;order;orderType]
^if(!def $order){$order[$self.order]}
^if(!def $orderType){$orderType[$self.orderType]}
^if(!def $limitCount){$limitCount($self.newsPerPage)}
^if(!def $offsetCount){$offsetCount(0)}
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE sticker_id=$id AND visible=1 ORDER BY $order $orderType}[$.limit($limitCount) $.offset($offsetCount)]]
################################################################################
@ShowLastNews[newsPageId;count;tmpl;link]
^if(!def $tmpl){$tmpl[lastNews.html]}
^if(-f "${site:templateFolder}${self.newsFolder}/${tmpl}"){
	^site:ShowTemplate[${site:templateFolder}$self.newsFolder/${tmpl}]
	^try{^site:ShowLastNewsTemplate[$newsPageId;$count;$link]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.newsFolder/${tmpl}"</p>}
################################################################################
@ShowAllNews[]
$tmpl[allNews.html]
^if(-f "${site:templateFolder}${self.newsFolder}/${tmpl}"){
	^site:ShowTemplate[${site:templateFolder}$self.newsFolder/${tmpl}]
	^try{^site:ShowAllNewsTemplate[$self]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.newsFolder/${tmpl}"</p>}

^try{^site:ShowTemplate[${site:templateFolder}$self.newsFolder/allNews.html]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@GetCountAllPageNews[page_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	$result(^int:sql{
		SELECT COUNT(*)
		FROM $self.newsTable.name
		WHERE id_page=$page_id
					^if(def $params.visible){			AND visible=$params.visible}
					^if(def $params.main){				AND main=$params.main}
					^if(def $params.sticker_id){	AND sticker_id=$params.sticker_id}
	})
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@GetCountAllPageNewsByDate[pageId;begin;end]
$result(^int:sql{SELECT COUNT(*) FROM $self.newsTable.name WHERE id_page=$pageId AND date_news BETWEEN '$begin' AND '$end'})
################################################################################
@GetPrewNews[pageId;id;limit]
^if(!def $limit){$limit(1)}
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE visible=1 ^if(def $pageId){AND id_page=$pageId} AND date_news<(SELECT date_news FROM $self.newsTable.name WHERE id=$id ^if(def $pageId){AND id_page=$pageId}) ORDER BY date_news DESC}[$.limit($limit)]]
################################################################################
@GetNextNews[pageId;id;count]
^if(!def $limit){$limit(1)}
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE visible=1 ^if(def $pageId){AND id_page=$pageId} AND date_news>(SELECT date_news FROM $self.newsTable.name WHERE id=$id ^if(def $pageId){AND id_page=$pageId}) ORDER BY date_news ASC}[$.limit($limit)]]
################################################################################
@Show[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.id && def $form:id){$params.id($form:id)}
^if($self.settings.joint){
	^if(def $form:day && def $form:month && def $form:year){
		$begin[^date::create[${form:year}-${form:month}-${form:day}]]
		$end[^date::create[${form:year}-${form:month}-${form:day}]]
		^end.roll[day](1)
		$allNewsCount(^self.GetCountAllPageNewsByDate[$site:currentPage.id;^begin.sql-string[];^end.sql-string[]])
		$params[
			$.visible(1)
			$.begin[^begin.sql-string[]]
			$.end[^end.sql-string[]]
		]
		$tb_news[^self.GetNews[$site:currentPage.id;$params]]
		$template[date.html]
	}{
		$params[
			$.visible(1)
		]
		^if(def $params.id){
			$cpage(^self.GetNewsPageCount[$params.id;$site:currentPage.id;$params])
		}{
			^if(def $form:page){$cpage($form:page)}{$cpage(1)}
		}
		$params.offsetCount(^eval(($cpage-1)*$self.newsPerPage))
		$tb_news[^self.GetNews[$site:currentPage.id;$params]]
		$allNewsCount(^self.GetCountAllPageNews[$site:currentPage.id])
	}
	^if(def $template){
		^use[${site:templateFolder}$self.newsFolder/$template]
	}{
		^use[${site:templateFolder}$self.newsFolder/jointNews.html]
	}
	^ShowJointNews[$tb_news;$cpage;$allNewsCount]
}{
	^use[${site:classesFolder}/scroller.p;$.replace(true)]
	^if(def $params.id){
		$tb_news[^self.GetNewsById[$params.id]]
		^use[${site:templateFolder}${self.newsFolder}/oneNews.html]
		^ShowOneNews[$tb_news]
	}{
		^if(def $form:page){$cpage($form:page)}{$cpage(1)}
		^if(def $form:day && def $form:month && def $form:year){
			$begin[^date::create[${form:year}-${form:month}-${form:day}]]
			$end[^date::create[${form:year}-${form:month}-${form:day}]]
			^end.roll[day](1)
			$allNewsCount(^self.GetCountAllPageNewsByDate[$site:currentPage.id;^begin.sql-string[];^end.sql-string[]])
			$params[
				$.visible(1)
				$.begin[^begin.sql-string[]]
				$.end[^end.sql-string[]]
			]
			$tb_news[^self.GetNews[$site:currentPage.id;$params]]
			$template[date.html]
		}{
			$allNewsCount(^self.GetCountAllPageNews[$site:currentPage.id])
			$params[
				$.visible(1)
				$.offsetCount(^eval(($cpage-1)*$self.newsPerPage))
			]
			$tb_news[^self.GetNews[$site:currentPage.id;$params]]
		}
		^if($allNewsCount==1 && def $params.id){
			^use[${site:templateFolder}$self.newsFolder/oneNews.html]
			^ShowOneNews[$tb_news]
		}{
			^if(def $template){
				^use[${site:templateFolder}$self.newsFolder/$template]
			}{
				^use[${site:templateFolder}$self.newsFolder/news.html]
			}
			^ShowNews[$tb_news;$allNewsCount]
		}
	}
}
################################################################################
@ShowStickerNews[stickerId;count;tmpl;link]
^if(!def $tmpl){$tmpl[sticker.html]}
^if(-f "${site:templateFolder}${self.newsFolder}/${tmpl}"){
 $tb_news[^self.GetNewsBySticker[$stickerId;$count]]
 ^site:ShowTemplate[${site:templateFolder}$self.newsFolder/${tmpl}]
 ^try{^site:ShowStickerTemplate[$tb_news;$link]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.newsFolder/${tmpl}"</p>}
################################################################################
@ShowMainNews[page_id;tmpl;link]
^if(!def $tmpl){$tmpl[main.html]}
^if(-f "${site:templateFolder}${self.newsFolder}/${tmpl}"){
	$params[
		$.limitCount(99999)
		$.main(1)
		$.visible(1)
	]
	$tb_news[^self.GetNews[$page_id;$params]]
	^site:ShowTemplate[${site:templateFolder}$self.newsFolder/${tmpl}]
	^try{^site:ShowMainNewsTemplate[$tb_news;$link;$self]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.newsFolder/${tmpl}"</p>}
################################################################################
@ShowPrewNextNews[id]
^site:ShowTemplate[${site:templateFolder}$self.newsFolder/prewNextNews.html]
^site:ShowPrewNextNewsTemplate[$id]
################################################################################
@ShowSliderNews[]
^site:ShowTemplate[${site:templateFolder}$self.newsFolder/sliderNews.html]
################################################################################
@ShowNeighbourNews[id;neighbour]
^if($neighbour eq 'prew' || $neighbour eq 'next'){
 ^site:ShowTemplate[${site:templateFolder}$self.newsFolder/neighbourNews.html]
 ^site:ShowNeighbourNewsTemplate[$id;$neighbour]
}
################################################################################
@ShowComments[url;name]
$comments[^project_comments::init[
	$.add_field[$url]
	$.obj_name[$name]
	$.rewrite[]
	$.project[$self.className]
	$.id_obj[$form:id]
	$.user_name[$site.user.fio]
	$.user_id[$auth.session.user_id]
	$.uri[$request:uri]
	$.show_rating[yes]
	$.after_rating_function[]
	$.after_add_comment_function[]
	$.after_delete_function[]
	$.show_podch_comment[yes]
]]
^comments.show[]
################################################################################
@ShowCalendar[pageId;month;year]
$now[^date::now[]]
^if(def $month){$show_month($month)}{$show_month($now.month)}
^if(def $year){$show_year($year)}{$show_year($now.year)}
$calendar[^date:calendar[rus]($show_year;$show_month)]
$begin[^date::create[${show_year}-${show_month}]]
$end[^date::create[${show_year}-${show_month}]]
^end.roll[month](1)
$news[^self.GetNewsByDate[$pageId;^begin.sql-string[];^end.sql-string[]]]
$pageUrl[^site:GetPageUrlById[$pageId]]
^use[${site:templateFolder}$self.newsFolder/calendar.html]
^ShowCalendarTemplate[$calendar;$news;$month;$year]
################################################################################
@GetSticker[id]
$result[^table::sql{SELECT * FROM $self.newsStickersTable.name WHERE id=$id}]
################################################################################
@GetStickers[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.newsPerPage)}
	$result[^table::sql{
		SELECT id, name, sortir
		FROM $self.newsStickersTable.name
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetStickerName[id]
$result[^string:sql{SELECT name FROM $self.newsStickersTable.name WHERE id=$id}[$.default[Нет]]]
################################################################################
@GetSearchedNews[searchString;cpage]
$result[^table::sql{SELECT * FROM $self.newsTable.name WHERE visible=1 AND (head like '%$searchString%' OR body like '%$searchString%' OR full_text like '%$searchString%') ORDER BY date_news}[$.limit($self.newsPerPage) $.offset(^eval($cpage*$self.newsPerPage-$self.newsPerPage))]]
################################################################################
################################################################################
################################################################################
@GetMainImage[news_id;params]
$result[^table::sql{
	SELECT id, name, descript, visible
	FROM $self.newsGalleryTable.name
	WHERE
		news_id=$news_id
		AND main=1
		^if(def $params.visible){ AND visible=$params.visible}
}]
################################################################################
@GetImages[news_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(99999)}
	$result[^table::sql{
		SELECT id, name, descript, main, sortir, visible
		FROM $self.newsGalleryTable.name
		WHERE news_id=$news_id
					^if(def $params.visible){ AND visible=$params.visible}
					^if(def $params.main){ AND main=$params.main}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetTypes[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.newsPerPage)}
	$result[^table::sql{
		SELECT id, name, sortir
		FROM $self.newsTypesTable.name
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetNewsPageCount[newsId;pageId;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[$self.order]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	$RowNumber(^int:sql{
		SELECT RowNumber FROM (
			SELECT id, CONCAT(RowNumber, id) AS RowNumber, body
			FROM $self.newsTable.name, (SELECT @i:=0) AS `RowNumberTable`
			WHERE
				id_page=$pageId
				^if(def $params.main){				AND main=$params.main}
				^if(def $params.visible){			AND visible=$params.visible}
				^if(def $params.sticker_id){	AND sticker_id=$params.sticker_id}
			ORDER BY $params.order $params.orderType
		) AS val
		WHERE id=$newsId
	})
	$val(^eval($RowNumber/$self.newsPerPage))
	$trunc(^math:trunc($val))
	^if(^math:frac($val)>0){$result(^eval($trunc+1))}{$result($trunc)}
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetNewsTitle[id]
$result[^string:sql{SELECT title FROM $self.newsTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetNewsKeywords[id]
$result[^string:sql{SELECT keywords FROM $self.newsTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetNewsDescription[id]
$result[^string:sql{SELECT description FROM $self.newsTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetBreadcrumbs[pageUrl]
^if(def $form:id){
	$currentNews[^self.GetNewsById[$form:id]]
	$breadcrumbs[
		$.1[
			$.name[$currentNews.head]
			$.url[${pageUrl}^if(^currentNews.url.length[]>0){$currentNews.url}{$currentNews.id}/]
			$.module[$self.CLASS_NAME]
			$.opened(true)
		]
	]
	$result[$breadcrumbs]
}
################################################################################
@GetOpenGraphData[params][answer]
^if(def $form:id){
	$currentNews[^self.GetNewsById[$form:id]]
	$newsDate[^date::create[$currentNews.date_news]]
	$answer[
		$.og[
			$.type[article]
		]
		$.article[
			$.published_time[^newsDate.sql-string[date]T^newsDate.sql-string[time]]
			$.section[$site:currentPage.name]
		]
	]
	$keywords[^currentNews.keywords.replace[, ;,]]
	$keywords[^keywords.split[,]]
	^if(def $keywords){
		$counter(0)
		$answer.article.tag[^hash::create[]]
		^keywords.menu{
			$answer.article.tag.[$counter][$keywords.piece]
			^counter.inc[]
		}
	}
	$images[^self.GetImages[$form:id;$.visible(1)]]
	^if($images.CLASS_NAME eq table){
		$NConvert[^NConvert::create[]]
		$answer.og.image[^hash::create[]]
		$counter(0)
		^images.menu{
			$imageURL[${self.imagesFolder.big}/$images.name]
			$image[^NConvert.info[$imageURL]]
			^counter.inc[]
			$answer.og.image.[$counter][
				$.url[${env:REQUEST_SCHEME}://${site:domain}${imageURL}]
				$.width($image.iWidth)
				$.height($image.iHeight)
				$.type[$NConvert.mimeTypes.[$image.sFormat]]
				$.alt[^if(def $images.descript){$images.descript}{$currentNews.head}]
			]
		}
	}
	$result[$answer]
}
################################################################################
@GetSEOData[]
$ID(^form:id.int(0))
^if($ID>0){
	$news[^self.GetNewsById[$ID]]
	$SEOData[
		$.header[$news.head]
		$.fullUrl[${site:currentPage.url}^if(def $news.url){$news.url}{$news.id}/]
		$.title[$news.title]
		$.keywords[$news.keywords]
		$.description[$news.description]
	]
	^if($site:currentPage.mainPageFlag && $ID>0){$SEOData.mainPageFlag(false)}
}
$result[$SEOData]
################################################################################