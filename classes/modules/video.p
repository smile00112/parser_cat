################################################################################
@CLASS
video
################################################################################
@OPTIONS
locals
################################################################################
@auto[]
$self.classVersion[3.01]
$self.classBuildDate[22.02.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[video]
$self.classDescription[Класс модуля "Видео"]
$self.classModuleDescription[Видео]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Доработана функция <font color="red">^@ShowLastVideos</font>[videosPageId^;count^;tmpl^;link]. Теперь получение видео из базы происходит в ней.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.0 (29.08.2017):</u></strong>
		<ol>
			<li>Переименована функция <font color="red">^@GetVideos</font>[params] в функцию <font color="red">^@GetVideo</font>[params] и переделана так, что теперь принимает все переменные через хэш <strong>params</strong>. также в неё добавлен доп. функционал.</li>
			<li>Удалена функция <font color="red">^@GetCountAllVideos</font>[block_id^;params], так как теперь её функция включена в <font color="red">^@GetVideos</font>[params].</li>
			<li>Изменён принцип загрузки шаблона в функциях <font color="red">^@Show</font>[block_id] и <font color="red">^@ShowLastVideos</font>[videosPageId^;count^;tmpl^;link]</li>
			<li>Удалена переменная <font color="red">self.order</font>.</li>
			<li>Удалена переменная <font color="red">self.orderType</font>.</li>
			<li>Переменная <font color="red">self.videosPerPage</font> переименована в <font color="red">self.perPage</font>.</li>
			<li>Удалена переменная <font color="red">self.userWidth</font>.</li>
			<li>Удалена переменная <font color="red">self.userHeight</font>.</li>
			<li>Переделана функция <font color="red">^@InsertVideo</font>[params]. Теперь она возвращает hash.</li>
			<li>Переделана функция <font color="red">^@DeleteVideo</font>[video_id]. Теперь она возвращает hash.</li>
			<li>Переделана функция <font color="red">^@SetVisible</font>[video_id^;value]. Теперь она возвращает hash и умеет инициализировать видимость значением <strong>value</strong>.</li>
			<li>Функция <font color="red">^@SaveProperty</font>[video_id^;name^;value] переименована в <font color="red">^@SaveField</font>[video_id^;field^;value] и переделана. Теперь она возвращает hash.</li>
			<li>Переделана функция <font color="red">^@DeleteBlock</font>[block_id]. Теперь она возвращает hash.</li>
			<li>Для всех транзакционных функций добавлена запись в лог.</li>
			<li>Добавлена переменная <font color="red">self.hosters</font>, содержащая данные о поддерживаемых видеохостингах.</li>
			<li>Добавлена функция <font color="red">^@GenerateLink</font>[hoster^;link^;params][params], генерирующая блок видео из шаблона хостера <strong>hoster</strong> на основании ссылки <strong>link</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetElementUrl</font>[params], возвращающая URL элемента.</li>
			<li>Добавлена функция <font color="red">^@GenerateHtaccessRules</font>[], генерирующая правила для файла <strong>.htaccess</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.0 (21.01.2016):</u></strong>
		<ol>
			<li>Переписан алгоритм получения идентификатора видео для видеохостинга <strong>YouTube</strong> (через регулярное выражение).</li>
			<li>Добавлена поддержка видеохостинга <strong>RuTube</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetCountAllVideos</font>[block_id^;params], которая возвращает количество всех видео для блока <strong>block_id</strong>.</li>
			<li>Добавлены переменные для системы проверки работоспособности модуля.</li>
			<li>Модуль переписан под новую версию CMS (на сегодня это 2.23 :).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.3 (07.09.2015):</u></strong>
		<ol>
			<li>Удалены (или перенесены в video_cms.p) лишние функции.</li>
			<li>Функция <font color="red">^@GetVideos</font>[block_id^;params] теперь принимает все переменные через хэш <strong>params</strong>, кроме <strong>block_id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.2 (28.01.2014):</u></strong>
		<ol>
			<li>Класс переписан в соответствии с обновлёнными стандартами.</li>
			<li>Добавлена функция <font color="red">^@Show</font>[block_id], которая выводит содержимое шаблона видеогалереи.</li>
			<li>Добавлена функция <font color="red">^@ShowLastVideos</font>[videosPageId^;count^;tmpl^;link], которая выводит последние count видео из видеогалереи.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (30.07.2013):</u></strong>
		<ol>
			<li>Объявлен базовый класс <strong>site.p</strong>.</li>
			<li>Переписан метод <font color="red">^@Insert</font>[name^;code^;user_id^;module^;sortir].</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (11.07.2013):</u></strong>
		<ol>
			<li>Создан класс <strong>video.p</strong> для работы с видеозаписями.</li>
		</ol>
	</p>
]
# Таблица "Видео"
$self.videoTable[
	$.name[videos]
	$.file[videos.table]
]
# Хэш хостеров
$self.hosters[
	$.youtube[
		$.image[//img.youtube.com/vi/-IDENTIFIER-/hqdefault.jpg]
		$.video[//www.youtube.com/embed/-IDENTIFIER-]
#		Не уверен, для всех ли видео есть вариант hqdefault (скорее для всех всё же), поэтому подстраховка '0' стоит
		$.defaultImageNames[
			$.1[maxresdefault.jpg]
			$.2[sddefault.jpg]
			$.3[hqdefault.jpg]
			$.4[0.jpg]
		]
	]
	$.rutube[
		$.image[]
		$.video[]
	]
	$.facebook[
		$.image[]
		$.video[]
	]
]
# Ширина видео
$self.width[
	$.small(320)
	$.big(640)
	$.src(1024)
]
# Соотношение сторон видео
$self.aspectRatio(640/480)
# Высота видео
$self.height[
	$.small(^math:floor($self.width.small/$self.aspectRatio))
	$.big(^math:floor($self.width.big/$self.aspectRatio))
	$.src(^math:floor($self.width.src/$self.aspectRatio))
]
# Хэш типов элементов
$self.elementTypes[
	$.0[
		$.title[видеогалерея]
		$.titleRE[видеогалереи]
		$.titleDE[видеогалерее]
		$.titleRM[видеогалерей]
		$.name[videogallery]
	]
	$.1[
		$.title[видео]
		$.titleRE[видео]
		$.titleDE[видео]
		$.titleRM[видео]
		$.name[video]
	]
]
# Количество видео на странице
$self.perPage(10)
# Путь к шаблону
$self.folders[
	$.template[/$self.className]
	$.images[
		$.root[/images/${self.className}]
		$.small[/images/${self.className}/small]
		$.big[/images/${self.className}/big]
		$.src[/images/${self.className}/src]
	]
]
# Настройки модуля
$self.settings[
	$.template[]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.perPage(^textext:GetOptionValue[per_page;$self.blockId;$self.perPage])
^self.height.foreach[key;value]{
	$self.width.[$key](^textext:GetOptionValue[${key}_width;$self.blockId;$self.width.[$key]])
}
$self.aspectRatio(^textext:GetOptionValue[aspect_ratio;$self.blockId;$self.aspectRatio])
^self.width.foreach[key;value]{
	$self.height.[$key]($value/$self.aspectRatio)
}
$self.settings.template[^textext:GetOptionValue[template;$self.blockId;$self.settings.template]]
^if(def $self.settings.template){
	$self.folders.template[${self.folders.template}/${self.settings.template}]
}
################################################################################
@GetClassInfo[]
$result[
	$.version[$self.classVersion]
	$.build_date[$self.classBuildDate]
	$.developer[$self.classDeveloper]
	$.module_name[$self.className]
	$.module_description[$self.classModuleDescription]
	$.history[$self.classHistory]
]
################################################################################
@GetVideo[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	^if(!def $params.count){$params.count(false)}
	^if($params.count){
		$sql[
			$.fields[COUNT(*)]
			$.order[]
		]
	}{
		$sql[
			$.fields[*]
			$.order[ORDER BY $params.order $params.orderType]
		]
	}
	$sql[
		SELECT $sql.fields
		FROM $self.videoTable.name
		WHERE 1=1
					^if(def $params.IDs){ AND id IN ($params.IDs)}
					^if(def $params.excludeIDs){ AND id NOT IN ($params.excludeIDs)}
					^if(def $params.parentIDs){ AND parent IN ($params.parentIDs)}
					^if(def $params.blockIDs){ AND block_id IN ($params.blockIDs)}
					^if(def $params.blockName){ AND block_name="$params.blockName"}
					^if(def $params.visible){ AND visible=$params.visible}
					^if(def $params.type){ AND type=$params.type}
		$sql.order
	]
	^if($params.count){
		$result(^int:sql{$sql})
	}{
		$result[^table::sql{$sql}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GenerateLink[hoster;link;params][params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(def $hoster && def $link){
		^if(!def $params.source){$params.source[site]}
		$templatesFolder[/video-templates]
		^if($params.source eq site){
			$path[${site:templateFolder}${self.folders.template}${templatesFolder}/${hoster}.html]
		}{
			$path[^file:dirname[$env:PATH_INFO]${templatesFolder}/${hoster}.html]
		}
		^if(-f "$path"){
			^use[$path]
			^try{
				$result[
					$.error(false)
					$.text[Ссылка на видео сгенерирована $path]
					$.link[^ShowVideoTemplate[$hoster;$link;$params]]
				]
			}{
				$result[
					$.error(true)
					$.text[Ошибка загрузки шаблона]
				]
			}
		}{
			$result[
				$.error(true)
				$.text[Невозможно найти шаблон "$path"]
				$.debug[]
			]
		}
	}{
		$result[
			$.error(true)
			$.text[Недостаточно параметров]
		]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@Show[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $form:page){$cpage(1)}{$cpage($form:page)}
^if(!def $params.id && def $form:video_id){$params.id($form:video_id)}
^if(def $params.id){$gallery_id($params.id)}{$gallery_id(0)}
$params[
	$.blockIDs($self.blockId)
	$.parentIDs($gallery_id)
	$.visible(1)
	$.offsetCount(^eval(($cpage-1)*$self.perPage))
]
$videos[^self.GetVideo[$params]]
^if($gallery_id>0){$currentElement[^self.GetVideo[$.IDs($gallery_id)]]}
$params.count(true)
$videosCount[^self.GetVideo[$params]]
^if($videos.type == 0){
	^use[${site:templateFolder}${self.folders.template}/videogalleries.html]
	^try{^ShowVideogalleriesTemplate[$videos;$videosCount;$currentElement]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{
	^use[${site:templateFolder}${self.folders.template}/videos.html]
	^try{^ShowVideosTemplate[$videos;$videosCount]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}
################################################################################
@ShowLastVideos[videosPageId;count;tmpl;link]
^if(!def $tmpl){$tmpl[lastVideo.html]}
^if(-f "${site:templateFolder}${self.folders.template}/${tmpl}"){
$params[
	$.blockIDs(^textext:GetBlockIdByPageId[$videosPageId;$self.className])
	$.type(1)
	$.visible(1)
	$.orderType[DESC]
	$.limitCount(^count.int($self.perPage))
]
$videos[^self.GetVideo[$params]]
	^use[${site:templateFolder}$self.folders.template/${tmpl}]
	^try{^ShowLastVideosTemplate[$videos;$link]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.folders.template/${tmpl}"</p>}
################################################################################
@GetElementUrl[params]
# Если не передан весь элемент
^if(!def $params.element){
# Если передан ID элемента
	^if(def $params.video_id){
		$params.element[^self.GetVideo[$.IDs($params.video_id)]]
	}{
# Генерируем поля ошибки
		$result[
			$.error(true)
			$.text[Переданы не все параметры]
		]
	}
}
# Если не передан URL страницы
^if(!def $params.page_url){
	^if(!def $params.page_id){$params.page_id($site:currentPage.id)}
	$params.page_url[^site:GetPageUrlById[$params.page_id;^if(def $params.skip_main){$params.skip_main}]]
}
# Генерируем URL и возвращаем его
^if(def $params.element.url){
	$result[/$params.page_url/$params.element.url/]
}{
	$result[/$params.page_url/$params.element.id/]
}
################################################################################
@GetBreadcrumbs[pageUrl][video]
^if(def $form:video_id){
	$breadcrumbs[^hash::create[]]
	$counter(1)
	$video[^self.GetVideo[$.IDs($form:video_id)]]
	$breadcrumbs.[$counter][
		$.name[$video.name]
		$.url[^self.GetElementUrl[$.element[$video]]]
		$.module[$self.CLASS_NAME]
		$.opened(true)
	]
	^while($video.parent>0){
		^counter.inc[]
		$video[^self.GetVideo[$.IDs($video.parent)]]
		$breadcrumbs.[$counter][
			$.name[$video.name]
			$.url[^self.GetElementUrl[$.element[$video]]]
			$.module[$self.CLASS_NAME]
		]
	}
	$result[$breadcrumbs]
}
################################################################################