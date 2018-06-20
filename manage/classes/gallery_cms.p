################################################################################
@CLASS
gallery_cms
################################################################################
@USE
gallery.p
################################################################################
@BASE
gallery
################################################################################
@auto[]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.galleryTable.name]
	]
	$.superfluous[
		$.1[te_gallery]
	]
]
$self.moduleOptions[
	$.main[
		$.small_images_width[
			$.caption[Ширина малого изображения]
			$.value($self.imagesWidth.small)
			$.type_field(0)
		]
		$.big_images_width[
			$.caption[Ширина большого изображения]
			$.value[$self.imagesWidth.big]
			$.type_field(0)
		]
		$.aspect_ratio[
			$.caption[Соотношение сторон]
			$.value[$self.imagesAspectRatio]
			$.type_field(0)
		]
		$.per_page[
			$.caption[Кол-во изображений на странице]
			$.value[$self.perPage]
			$.type_field(0)
		]
		$.template[
			$.caption[Шаблон]
			$.value[$self.settings.template]
			$.type_field(0)
		]
		$.show_links[
			$.caption[Отображать ссылки]
			$.value[$self.settings.showLinks]
			$.type_field(1)
		]
	]
	$.rename[
		$.preview_width[small_images_width]
		$.width[big_images_width]
	]
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
$self.perPage(^textext:GetOptionValue[per_page;$self.blockId;$self.perPage])
$self.settings.showLinks(^textext:GetOptionValue[show_links;$self.blockId;$self.settings.showLinks])
################################################################################
# Элемент (изображение или галерея)
################################################################################
@SaveProperty[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		^switch[$name]{
			^case[sortir]{
				$element[^table::sql{SELECT block_id, parent FROM $self.galleryTable.name WHERE id=$id}]
				^if(!^int:sql{SELECT 1 FROM $self.galleryTable.name WHERE $name=$value AND block_id=$element.block_id AND parent=$element.parent}[$.default(0)]){
					$res[^void:sql{UPDATE $self.galleryTable.name SET $name='$value' WHERE id=$id}]
				}{
					$answer.error(true)
					$answer.text[Это значение уже используется!]
				}
			}
			^case[DEFAULT]{
				$res[^void:sql{UPDATE $self.galleryTable.name SET $name='$value' WHERE id=$id}]
			}
		}
		^if(!$answer.error){
# Делаем запись в лог
			$params[
				$.unit_id[$id]
				$.module[$self.className]
				$.module_id[$self.blockId]
				$.method[SaveProperty]
				$.description[Поле "$name" изменено]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.text[Значение сохранено]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Переданы не все параметры]
}
$result[$answer]
################################################################################
@InsertElement[params]
$answer[^hash::create[]]
^try{
# Если передаётся id блока и файлы
	^if(def $params.block_id){
		^if(!def $params.main){$params.main(0)}
		^if(!def $params.visible){$params.visible(1)}
		^if(!def $params.parent){$params.parent(0)}
		^if(!def $params.type){$params.type(1)}
		^if(def $params.file){
# Получаем уникальное имя для изображения
			$imageName[^cms:GetImageName[$self.galleryTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
			$small[${self.imagesFolder.small}/${imageName}]
			$big[${self.imagesFolder.big}/${imageName}]
			$src[${self.imagesFolder.src}/${imageName}]
			$root[${self.imagesFolder.root}/${imageName}]
			$res(^params.file.save[binary;$root])
#			$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;^eval($self.imagesWidth.big/$self.imagesAspectRatio)]]
#			$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
			$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;99999]]
			$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;99999]]
			$res[^cms:ImageResize[$root;$src;$self.imagesWidth.src;9999999]]
			$res[^file:delete[$root]]
		}
		$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.galleryTable.name WHERE block_id=$params.block_id AND parent=$params.parent}+10))
		$res[^void:sql{
			INSERT INTO $self.galleryTable.name
				(block_id, name, description, main, sortir, visible, parent, type)
			VALUES
				($params.block_id, "$imageName", "$params.description", $params.main, $sortir, $params.visible, $params.parent, $params.type)
		}]
# Делаем запись в лог
		$params[
			$.module[$self.className]
			$.module_id[$params.block_id]
			$.method[InsertImage]
			$.description[Добавление изображения]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.error(false)
		$answer.text[Элемент добавлен]
	}{
		$answer.error(true)
		$answer.text[Не хватает параметров]
	}
}{
	$exception.handled(true)
	$answer.error(true)
	$answer.text[Ошибка выполнения скрипта]
	$answer.detail[
		<p align="center">Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
		<p align="center">Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
	]
}
$result[$answer]
################################################################################
@DeleteElement[image_id][image_id;element;childs]
$answer[^hash::create[]]
^if(def $image_id){
	^try{
		$element[^table::sql{SELECT block_id, name, type FROM $self.galleryTable.name WHERE id=$image_id}]
		^if(def $element){
			$childs[^table::sql{SELECT id FROM $self.galleryTable.name WHERE parent=$image_id}]
			^if(def $childs){
				^childs.menu{
					$res[^self.DeleteElement[$childs.id]]
				}
			}
			$res[^file:delete[${self.imagesFolder.src}/${element.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[${self.imagesFolder.big}/${element.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[${self.imagesFolder.small}/${element.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^void:sql{DELETE FROM $self.galleryTable.name WHERE id=$image_id}]
	# Делаем запись в лог
			$params[
				$.unit_id[$image_id]
				$.module[$self.className]
				$.module_id[$element.block_id]
				$.method[DeleteImage]
				$.description[Удаление ^if($element.type){изображения}{галереи}]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.visible($visible)
			$answer.error(false)
			$answer.text[^if($element.type){Изображение удалено}{^if(def $childs){Галерея и все её внутренние элементы удалены}{Галерея удалена}}]
		}{
			$answer.error(true)
			$answer.text[Элемент с ID=$image_id не найден]
		}
	}{
#		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID элемента]
}
$result[$answer]
################################################################################
@SetElementVisible[id]
$answer[^hash::create[]]
^if(def $id){
	^try{
		$visible(^int:sql{SELECT visible FROM $self.galleryTable.name WHERE id=$id})
		^if($visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.galleryTable.name SET visible=$visible WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[SetImageVisible]
			$.description[^if($visible){Отображение}{ Скрытие} изображения]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.visible($visible)
		$answer.error(false)
		$answer.text[Изображение^if($visible){ отображено}{ скрыто}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID изображения]
}
$result[$answer]
################################################################################
# Только изображение
################################################################################
@DeleteImage[image_id;params]
$answer[^hash::create[]]
^if(def $image_id || def $params.name){
	^try{
		$image[^table::sql{SELECT id, name FROM $self.galleryTable.name WHERE ^if(def $image_id){id=$image_id}{name="$params.name"}}]
		^if(def $image){
			$res[^file:delete[${self.imagesFolder.src}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[${self.imagesFolder.big}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[${self.imagesFolder.small}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
			$res[^void:sql{UPDATE $self.galleryTable.name SET name="" WHERE id=$image.id}]
# Делаем запись в лог
			$params[
				$.unit_id[$image.id]
				$.module[$self.className]
				$.module_id[$image.id]
				$.method[DeleteImage]
				$.description[Удаление изображения галереи]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[Изображение удалено]
		}{
			$answer.error(true)
			$answer.text[Изображение не найдено]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID или имя изображения]
}
$result[$answer]
################################################################################
@CropImage[image_id;params]
$answer[^hash::create[]]
^if(def $image_id && def $params.width && def $params.height){
	^if(!def $params.x){$params.x(0)}
	^if(!def $params.y){$params.y(0)}
	^try{
		$image[^table::sql{SELECT id, name FROM $self.galleryTable.name WHERE id=$image_id}]
		^if(def $image){
			$root[${self.imagesFolder.root}/${image.name}]
			$src[${self.imagesFolder.src}/${image.name}]
			$big[${self.imagesFolder.big}/${image.name}]
			$small[${self.imagesFolder.small}/${image.name}]
			$res[^file:delete[$big;$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[$small;$.keep-empty-dirs(true)$.exception(false)]]
			$res[^cms:ImageCrop[$src;$root;$params.x;$params.y;$params.width;$params.height]]
			$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;^eval($self.imagesWidth.big/$self.imagesAspectRatio)]]
			$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
			$res[^file:delete[$root;$.keep-empty-dirs(true)$.exception(false)]]
			$params[
				$.unit_id[$image_id]
				$.module[$self.className]
				$.module_id[$image.id]
				$.method[CropImage]
				$.description[Обрезка изображения]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[Изображение обрезано]
		}{
			$answer.error(true)
			$answer.text[Изображение не найдено]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не переданы данные об изображении]
}
$result[$answer]
################################################################################
@InsertGalleryImage[params]
$answer[^hash::create[]]
^try{
# Если передаётся id новости и файлы
	^if(def $params.element_id && def $params.file){
# Получаем уникальное имя для изображения
		$imageName[^cms:GetImageName[$self.galleryTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
		$small[${self.imagesFolder.small}/${imageName}]
		$big[${self.imagesFolder.big}/${imageName}]
		$src[${self.imagesFolder.src}/${imageName}]
		$root[${self.imagesFolder.root}/${imageName}]
		$res(^params.file.save[binary;$root])
		$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;99999]]
		$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;99999]]
		$res[^cms:ImageResize[$root;$src;$self.imagesWidth.src;9999999]]
		$res[^file:delete[$root]]
		$res[^void:sql{UPDATE $self.galleryTable.name SET name="$imageName" WHERE id=$params.element_id}]
# Делаем запись в лог
		$params[
			$.unit_id[$params.element_id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[InsertGalleryImage]
			$.description[Добавление изображения галереи]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.error(false)
		$answer.text[Изображение добавлено]
	}{
		$answer.error(true)
		$answer.text[Не хватает параметров]
	}
}{
#	$exception.handled(true)
	$answer.error(true)
	$answer.text[Ошибка выполнения функции]
}
$result[$answer]
################################################################################
@NotEnd___SetGalleryImage[image_id]
^try{
# Получаем id новости
	$news_id(^int:sql{SELECT news_id FROM $self.galleryTable.name WHERE id=$image_id})
# Получаем id главного изображения
	$main_id(^int:sql{SELECT id FROM $self.galleryTable.name WHERE news_id=$news_id AND main=1}[$.default(0)])
# Делаем его неглавным
	$res[^void:sql{UPDATE $self.galleryTable.name SET main=0 WHERE id=$main_id}]
# Делаем главным искомое изображение
	$res[^void:sql{UPDATE $self.galleryTable.name SET main=1 WHERE id=$image_id}]
# Делаем запись в лог
	$params[
		$.unit_id[$image_id]
		$.module[$self.className]
		$.module_id[$news_id]
		$.method[SetMainImage]
		$.description[Определение изображения главным]
	]
	$res[^cms:InsertIntoLog[$params]]
# Возвращаем id изображения, которое до этого было главным
	$result($main_id)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(-1)
}
################################################################################
@NotEnd___DeleteBlock[blockId]
^try{
# Определяем id блока, который будем удалять
	^if(!def $blockId){$blockId($self.blockId)}
# Определяем id страницы, к которой этот блок привязан
	$pageId(^textext:GetPageIdByBlockId[$blockId])
# Получаем список новостей этого блока
	$news[^self.GetNews[$pageId;$.limitCount(-1)]]
# Для каждой новости
	^news.menu{
# Удаляем новость
		$res[^self.DeleteNews[$news.id]]
	}
# Удаляем настройки блока
	$res[^textext:DeleteOptions[$blockId]]
# Удаляем блок
	$res[^textext:Delete[$blockId]]
# Возвращаем результат
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@GenerateHtaccessRules[]
# Инициализируем хэш ответа
$answer[
	$.htaccess[]
	$.sitemap[^hash::create[]]
]
$blocks[^structure:GetBlocksByBlockName[$self.className]]
^if($blocks){
	^blocks.menu{
		$elements[^self.GetElements[$.blockID($blocks.id)$.visible(1)$.type(0)]]
		^if($elements.CLASS_NAME eq table){
			$params[$.page_url[^site:GetPageUrlById[$blocks.page_id;skip_main]]]
			^elements.menu{
				$params.element[$elements.fields]
				$element_url[^self.GetElementUrl[$params]]
				$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^^element_url.trim[left;/]^$ index.html?p=${blocks.page_id}&idg=${elements.id} [L,QSA]^#0A]
				$answer.sitemap.[${elements.id}_${self.className}][^hash::create[]]
				$answer.sitemap.[${elements.id}_${self.className}].loc[${env:REQUEST_SCHEME}://${env:SERVER_NAME}${element_url}]
			}
		}
	}
}
$result[$answer]
################################################################################
@SaveElementProperty[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		^switch[$name]{
			^case[sortir]{
				$parent[^string:sql{SELECT parent FROM $self.galleryTable.name WHERE id=$id}]
				^if(!^int:sql{SELECT 1 FROM $self.galleryTable.name WHERE $name=$value AND parent=$parent}[$.default(0)]){
					$res[^void:sql{UPDATE $self.galleryTable.name SET $name='$value' WHERE id=$id}]
				}{
					$answer.error(true)
					$answer.text[Это значение уже используется!]
				}
			}
			^case[DEFAULT]{
				$res[^void:sql{UPDATE $self.galleryTable.name SET $name='$value' WHERE id=$id}]
			}
		}
		^if(!$answer.error){
# Делаем запись в лог
			$params[
				$.unit_id[$id]
				$.module[$self.className]
				$.module_id[]
				$.method[SaveElementProperty]
				$.description[Поле "$name" изменено]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.text[Значение сохранено]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
		$answer.exception[$exception]
	}
}{
	$answer.error(true)
	$answer.text[Переданы не все параметры]
}
$result[$answer]
################################################################################