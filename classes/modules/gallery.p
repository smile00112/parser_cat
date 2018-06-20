################################################################################
@CLASS
gallery
################################################################################
@auto[]
$self.classVersion[2.02]
$self.classBuildDate[03.02.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[gallery]
$self.classDescription[Класс модуля галереи]
$self.classModuleDescription[Галерея]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Функция <font color="red">^@GetElementUrl</font>[params], теперь возвращает URL элемента с учётом родительских URL.</li>
			<li>Функция <font color="red">^@GetBreadcrumbs</font>[pageUrl] переделана под новую архитектуру CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.01 (07.12.2017):</u></strong>
		<ol>
			<li>Добавлена поддержка ссылок для изображений.</li>
			<li>Добавлена функция <font color="red">^@GetBreadcrumbs</font>[gallery_id^;params], возвращающая хлебные крошки для галереи с id <strong>^$gallery_id</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetSEOData</font>[], инициализирующая переменную <strong>^$site.currentPage</strong> данными SEO полей.</li>
			<li>В функции <font color="red">^@GetElements</font>[params], оставлена только 1 переменная <strong>params</strong> для универсальности работы.</li>
			<li>Удалена функция <font color="red">^@GetCountElements</font>[params], так как теперь её функционал перенесён в функцию <strong>^@GetElements</strong>.</li>
			<li>Удалена функция <font color="red">^@GetElementById</font>[id^;params], так как теперь её функционал перенесён в функцию <strong>^@GetElements</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetOpenGraphData</font>[], возвращающая массив (hash) с данными OpenGraph разметки блока текущей страницы.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.0 (22.11.2016):</u></strong>
		<ol>
			<li>Класс переделан в соответствии с требованиями для новых блоков CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (28.01.2014):</u></strong>
		<ol>
			<li>Создан класс для модуля "Галерея"</li>
		</ol>
	</p>
]
# Таблица "Оглавление галереи"
$self.galleryTable[
	$.name[gallery]
	$.file[gallery.table]
]
# Хэш типов элементов
$self.elementTypes[
	$.0[
		$.title[Галерея]
		$.titleRE[Галереи]
		$.titleRM[Галерей]
		$.titleDM[Галереям]
		$.name[gallery]
	]
	$.1[
		$.title[Изображение]
		$.titleRE[Изображения]
		$.titleRM[Изображений]
		$.titleDM[Изображениям]
		$.name[image]
	]
]
# Путь к шаблону
$self.galleryFolder[/$self.className]
# Пути к изображениям
$self.imagesFolder[
	$.root[/images/${self.className}]
	$.small[/images/${self.className}/small]
	$.big[/images/${self.className}/big]
	$.src[/images/${self.className}/src]
]
# Ширина изображений
$self.imagesWidth[
	$.small(180)
	$.big(800)
	$.src(1024)
]
# Соотношение сторон изображения
$self.imagesAspectRatio(^eval(800/600))
# Сортировка по умолчанию
$self.order[sortir]
# Тип сортировки по умолчанию
$self.orderType[DESC]
# Количество изображений на странице
$self.perPage(10)
# Настройки модуля
$self.settings[
	$.template[]
	$.showLinks(0)
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
$self.imagesHeight[
	$.small(^math:floor(^eval($self.imagesWidth.small/$self.imagesAspectRatio)))
	$.big(^math:floor(^eval($self.imagesWidth.big/$self.imagesAspectRatio)))
]
$self.settings.template[^textext:GetOptionValue[template;$self.blockId;$self.settings.template]]
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
@Show[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $form:page){$cpage(1)}{$cpage($form:page)}
^if(!def $params.id && def $form:idg){$params.id($form:idg)}
^if(def $params.id){$idg($params.id)}{$idg(0)}
$params[
	$.blockID($self.blockId)
	$.parent($idg)
	$.visible(1)
	$.offsetCount(^eval(($cpage-1)*$self.perPage))
]
$elements[^self.GetElements[$params]]
$params.count(true)
$allElementsCount(^self.GetElements[$params])
^if($elements.type == 0){
	^use[${site:templateFolder}$self.galleryFolder/^if(def $self.settings.template){${self.settings.template}/}galleries.html]
	^try{^ShowGalleriesTemplate[$elements;$allElementsCount;^self.GetElements[$.IDs($idg)]]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{
	^use[${site:templateFolder}$self.galleryFolder/^if(def $self.settings.template){${self.settings.template}/}gallery.html]
	^try{^ShowGalleryTemplate[$elements;$allElementsCount;^self.GetElements[$.IDs($idg)]]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}
################################################################################
@GetElements[params]
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
		FROM $self.galleryTable.name
		WHERE 1=1
					^if(def $params.IDs){ AND id IN ($params.IDs)}
					^if(def $params.blockID){ AND block_id=$params.blockID}
					^if(def $params.parent){ AND parent=$params.parent}
					^if(def $params.type){ AND type=$params.type}
					^if(def $params.visible){ AND visible=$params.visible}
					^if(def $params.main){ AND main=$params.main}
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
		$.text[Во время выполнения произошла ошибка]
		$.exception[$exception]
	]
}
################################################################################
@GetElementUrl[params]
# Если не передан весь элемент
^if(!def $params.element){
# Если передан ID элемента
	^if(def $params.element_id){
		$params.element[^table::sql{SELECT id, url, parent FROM $self.galleryTable.name WHERE id=$params.element_id}]
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
	^if(!def $params.page_id){$params.page_id($site:currentPageId)}
	$params.page_url[^site:GetPageUrlById[$params.page_id;^if(def $params.skip_main){$params.skip_main}]]
}
# Генерируем URL галереи
^if(def $params.element.url){
	$elementUrl[$params.element.url]
}{
	$elementUrl[$params.element.id]
}
$elementParentId($params.element.parent)
^while($elementParentId>0){
	$parentElement[^table::sql{SELECT id, url, parent FROM $self.galleryTable.name WHERE id=$elementParentId}]
	$elementParentId($parentElement.parent)
	^if(def $params.element.url){
		$elementUrl[${parentElement.url}/${elementUrl}]
	}{
		$elementUrl[${parentElement.id}/${elementUrl}]
	}
}
$result[/${params.page_url}/${elementUrl}/]
################################################################################
@GetBreadcrumbs[pageUrl]
$breadcrumbs[^hash::create[]]
$IDg(^form:idg.int(0))
^if($IDg>0){
	$gallery[^self.GetElements[$.IDs($IDg)]]
	$counter(1)
	$breadcrumbs.[$counter][
		$.name[$gallery.description]
		$.url[^self.GetElementUrl[$.element[$gallery]$.page_url[$pageUrl]]]
		$.module[$self.CLASS_NAME]
		$.opened(true)
	]
	$parent[^self.GetElements[$.IDs($gallery.parent)]]
	^while(^parent.id.int(0)>0){
		^counter.inc[]
		$breadcrumbs.[$counter][
			$.name[$parent.description]
			$.url[^self.GetElementUrl[$.element[$parent]$.page_url[$pageUrl]]]
			$.module[$self.CLASS_NAME]
		]
		$parent[^self.GetElements[$.IDs($parent.parent)]]
	}
}
$result[$breadcrumbs]
################################################################################
@GetSEOData[]
$IDg(^form:idg.int(0))
^if($IDg>0){
	$gallery[^self.GetElements[$.IDs($IDg)]]
	$SEOData[
		$.header[$gallery.description]
		$.fullUrl[${site:currentPage.url}^if(def $gallery.url){$gallery.url}{$gallery.id}/]
		$.title[$gallery.seo_title]
		$.keywords[$gallery.seo_keywords]
		$.description[$gallery.seo_description]
	]
	^if($site:currentPage.mainPageFlag && $IDg>0){$SEOData.mainPageFlag(false)}
}
$result[$SEOData]
################################################################################
@GetOpenGraphData[params][answer]
$IDg(^form:idg.int(0))
^if($IDg>0){
	$image[^self.GetElements[$.IDs($IDg)]]
}
^if(def $image && $image.CLASS_NAME eq table){
	$NConvert[^NConvert::create[]]
	$imageURL[${self.imagesFolder.big}/$image.name]
	$imageInfo[^NConvert.info[$imageURL]]
	$result[
		$.og[
			$.image[
				$.url[${env:REQUEST_SCHEME}://${site:domain}${imageURL}]
				$.width($imageInfo.iWidth)
				$.height($imageInfo.iHeight)
				$.type[$NConvert.mimeTypes.[$imageInfo.sFormat]]
				$.alt[^if(def $images.description){$images.description}{$site:currentPage.title}]
			]
		]
	]
}
################################################################################