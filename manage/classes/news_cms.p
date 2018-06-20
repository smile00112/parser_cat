################################################################################
@CLASS
news_cms
################################################################################
@USE
news.p
################################################################################
@BASE
news
################################################################################
@auto[]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.newsTable.name]
		$.2[$self.newsGalleryTable.name]
		$.3[$self.newsFilesTable.name]
		$.4[$self.newsStickersTable.name]
		$.5[$self.newsTypesTable.name]
		$.6[$self.newsTextsTable.name]
	]
	$.superfluous[
		$.1[news_group]
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
		$.news_per_page[
			$.caption[Кол-во новостей на странице]
			$.value[$self.newsPerPage]
			$.type_field(0)
		]
		$.template[
			$.caption[Шаблон]
			$.value[$self.settings.template]
			$.type_field(0)
		]
		$.joint[
			$.caption[Совмещённый вид]
			$.value[$self.settings.joint]
			$.type_field(1)
		]
		$.show_sticker[
			$.caption[Отображать стикеры]
			$.value[$self.settings.showSticker]
			$.type_field(1)
		]
		$.show_time[
			$.caption[Отображать время]
			$.value[$self.settings.showTime]
			$.type_field(1)
		]
		$.show_body[
			$.caption[Отображать анонс]
			$.value[$self.settings.showBody]
			$.type_field(1)
		]
		$.show_main[
			$.caption[Главная новость]
			$.value[$self.settings.showMain]
			$.type_field(1)
		]
		$.one_main[
			$.caption[Главная новость (только одна)]
			$.value[$self.settings.oneMain]
			$.type_field(1)
		]
		$.show_type[
			$.caption[Новости по типу]
			$.value[$self.settings.showType]
			$.type_field(1)
		]
		$.show_sync[
			$.caption[Синхронизация]
			$.value[$self.settings.showSync]
			$.type_field(1)
		]
		$.show_author[
			$.caption[Отображать автора]
			$.value[$self.settings.showAuthor]
			$.type_field(1)
		]
		$.set_text_body[
			$.caption[Анонс текстом]
			$.value[$self.settings.setTextBody]
			$.type_field(1)
		]
		$.show_date[
			$.caption[Отображать дату (на сайте)]
			$.value[$self.settings.showDate]
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
$self.settings.joint(^textext:GetOptionValue[joint;$self.blockId;$self.settings.joint])
$self.settings.showDate(^textext:GetOptionValue[show_date;$self.blockId;$self.settings.showDate])
################################################################################
@SaveNewsProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.newsTable.name SET $name='$value' WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@GetAuthors[]
^try{
	$result[^table::sql{SELECT user_id AS id, fio AS name FROM $site:siteUsersTable.name ORDER BY user_id}]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@InsertImage[params]
^try{
# Если передаётся id новости и файлы
	^if(def $params.news_id && def $params.file){
		^if(!def $params.main){$params.main(0)}
		^if(!def $params.visible){$params.visible(0)}
# Получаем уникальное имя для изображения
		$imageName[^cms:GetImageName[$self.newsGalleryTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
		$small[${self.imagesFolder.small}/${imageName}]
		$big[${self.imagesFolder.big}/${imageName}]
		$src[${self.imagesFolder.src}/${imageName}]
		$root[${self.imagesFolder.root}/${imageName}]
		$res(^params.file.save[binary;$root])
#		$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;^eval($self.imagesWidth.big/$self.imagesAspectRatio)]]
#		$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
		$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;99999]]
		$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;99999]]
		$res[^cms:ImageResize[$root;$src;1024;9999999]]
		$res[^file:delete[$root]]
		$sortir(^eval(^int:sql{SELECT COUNT(id) FROM $self.newsGalleryTable.name WHERE news_id=$params.news_id}*10+10))
		$res[^void:sql{
			INSERT INTO $self.newsGalleryTable.name
				(news_id, name, descript, main, sortir, visible)
			VALUES
				($params.news_id, "$imageName", "$params.description", $params.main, $sortir, $params.visible)
		}]
# Делаем запись в лог
		$params[
			$.module[$self.className]
			$.module_id[$params.news_id]
			$.method[InsertImage]
			$.description[Добавление изображения]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result(1)
	}{
		$result(-1)
	}
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteImage[image_id]
^try{
	$image[^table::sql{SELECT news_id, name FROM $self.newsGalleryTable.name WHERE id=$image_id}]
	^if(def $image){
		$res[^file:delete[${self.imagesFolder.src}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.big}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.small}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^void:sql{DELETE FROM $self.newsGalleryTable.name WHERE id=$image_id}]
# Делаем запись в лог
		$params[
			$.unit_id[$image_id]
			$.module[$self.className]
			$.module_id[$image.news_id]
			$.method[DeleteImage]
			$.description[Удаление изображения]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result(1)
	}{
		$result(0)
	}
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
################################################################################
################################################################################
@SetVisible[news_id]
^try{
	$visible(^int:sql{SELECT visible FROM $self.newsTable.name WHERE id=$news_id})
	^if($visible==1){$visible(0)}{$visible(1)}
	$res[^void:sql{UPDATE $self.newsTable.name SET visible=$visible WHERE id=$news_id}]
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@CreateNews[params]
^if(def $params.date_news && def $params.head){
	^try{
		^if(!def $params.visible){$params.visible(1)}
		$counter(0)
		$allFields[^params._keys[]]
		^allFields.menu{
			^counter.inc[]
			^if($counter==1){$fields[$allFields.key]}{$fields[${fields}, $allFields.key]}
			^if($counter==1){$values['$params.[$allFields.key]']}{$values[${values}, '$params.[$allFields.key]']}
		}
		$newsURL[^cms:ConvertUrl[^cms:Translit[^params.head.replace[ ;-];$.filename(1)]]]
		$res[^void:sql{INSERT INTO $self.newsTable.name ($fields, url) VALUES ($values, "^cms:GetImageName[$self.newsTable.name;^newsURL.lower[];;;url]")}]
# Делаем запись в лог
		$params[
			$.unit_id[]
			$.module[$self.className]
			$.module_id[]
			$.method[CreateNews]
			$.description[Создание новости]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@SaveDate[params]
^if(def $params.id && (def $params.date || def $params.time) ){
	^try{
		$newsDate[^date::create[^string:sql{SELECT date_news FROM $self.newsTable.name WHERE id=$params.id}]]
		^if(def $params.date){$date[$params.date]}{$date[${newsDate.year}-${newsDate.month}-${newsDate.day}]}
		^if(def $params.time){$time[$params.time]}{$time[${newsDate.hour}:${newsDate.minute}:${newsDate.second}]}
		$res[^void:sql{UPDATE $self.newsTable.name SET date_news='$date $time' WHERE id=$params.id}]
		$result(1)
	 }{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteNews[news_id]
^if(def $news_id){
	^try{
		$images[^self.GetImages[$news_id;$.limitCount(9999999)]]
		^if(def $images){
			^images.menu{
				$res[^self.DeleteImage[$images.id]]
			}
		}
		$files[^self.GetFiles[$news_id;$.limitCount(9999999)]]
		^if(def $files){
			^files.menu{
				$res[^self.DeleteFile[$files.id]]
			}
		}
		^use[video_cms.p]
		$videos[^video_cms:GetVideo[$.IDs($news_id)]]
		^if(def $videos){
			^videos.menu{
				$res[^video_cms:DeleteVideo[$videos.id]]
			}
		}
		$res[^void:sql{DELETE FROM $self.newsTable.name WHERE id=$news_id}]
# Делаем запись в лог
		$params[
			$.unit_id[$news_id]
			$.module[$self.className]
			$.module_id[$news_id]
			$.method[DeleteNews]
			$.description[Удаление новости]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@SetMain[news_id;value;one]
^try{
	^if(def $one && $value==1){
		$res[^void:sql{UPDATE $self.newsTable.name SET main=0}]
	}
	$res[^void:sql{UPDATE $self.newsTable.name SET main=$value WHERE id=$news_id}]
# Делаем запись в лог
	$params[
		$.unit_id[$news_id]
		$.module[$self.className]
		$.module_id[$news_id]
		$.method[SetMain]
		$.description[Определение новости как главной]
	]
	$res[^cms:InsertIntoLog[$params]]
	$result($value)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@SetImageVisible[id]
^try{
	$visible(^int:sql{SELECT visible FROM $self.newsGalleryTable.name WHERE id=$id})
	^if($visible==1){$visible(0)}{$visible(1)}
	$res[^void:sql{UPDATE $self.newsGalleryTable.name SET visible=$visible WHERE id=$id}]
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@SaveImageProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.newsGalleryTable.name SET $name='$value' WHERE id=$id}]
# Возвращаем результат
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@SetMainImage[image_id]
^try{
# Получаем id новости
	$news_id(^int:sql{SELECT news_id FROM $self.newsGalleryTable.name WHERE id=$image_id})
# Получаем id главного изображения
	$main_id(^int:sql{SELECT id FROM $self.newsGalleryTable.name WHERE news_id=$news_id AND main=1}[$.default(0)])
# Делаем его неглавным
	$res[^void:sql{UPDATE $self.newsGalleryTable.name SET main=0 WHERE id=$main_id}]
# Делаем главным искомое изображение
	$res[^void:sql{UPDATE $self.newsGalleryTable.name SET main=1 WHERE id=$image_id}]
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
@InsertSticker[params]
^if(def $params.name){
	^try{
		$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.newsStickersTable.name}+10))
		$tmp[^void:sql{INSERT INTO $self.newsStickersTable.name (name, sortir) VALUES ('$params.name', $sortir)}]
		$result(^int:sql{SELECT id FROM $self.newsStickersTable.name WHERE name="$params.name"})
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@SaveStickerProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.newsStickersTable.name SET $name="$value" WHERE id=$id}]
# Возвращаем результат
	$result(1)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(0)
}
################################################################################
@DeleteSticker[id]
^try{
	$result[^void:sql{DELETE FROM $self.newsStickersTable.name WHERE id=$id}]
	$result(1)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(0)
}
################################################################################
@InsertType[params]
^if(def $params.name){
	^try{
		$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.newsTypesTable.name}+10))
		$tmp[^void:sql{INSERT INTO $self.newsTypesTable.name (name, sortir) VALUES ('$params.name', $sortir)}]
		$result(^int:sql{SELECT id FROM $self.newsTypesTable.name WHERE name="$params.name"})
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@SaveTypeProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.newsTypesTable.name SET $name="$value" WHERE id=$id}]
# Возвращаем результат
	$result(1)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(0)
}
################################################################################
@DeleteType[id]
^try{
	$res[^void:sql{DELETE FROM $self.newsTypesTable.name WHERE id=$id}]
# Возвращаем результат
	$result(1)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(0)
}
################################################################################
@InsertFile[params]
^try{
# Если передаётся id новости и файлы
	^if(def $params.news_id && def $params.file){
		^if(!def $params.visible){$params.visible(0)}
# Получаем уникальное имя для изображения
		$fileName[^cms:GetImageName[$self.newsFilesTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
		$res(^params.file.save[binary;${self.filesFolder}/${params.news_id}/${fileName}])
		$sortir(^eval(^int:sql{SELECT COUNT(id) FROM $self.newsFilesTable.name WHERE news_id=$params.news_id}*10+10))
		$res[^void:sql{
			INSERT INTO $self.newsFilesTable.name
				(news_id, name, descript, sortir, visible)
			VALUES
				($params.news_id, '$fileName', '$params.description', $sortir, $params.visible)
		}]
		$result(1)
	}{
		$result(-1)
	}
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteFile[file_id]
^try{
	$file[^table::sql{SELECT news_id, name FROM $self.newsFilesTable.name WHERE id=$file_id}]
	^if(def $file){
		$res[^file:delete[${self.filesFolder}/${file.news_id}/${file.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^void:sql{DELETE FROM $self.newsFilesTable.name WHERE id=$file_id}]
		$result(1)
	}{
		$result(0)
	}
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@SaveFileProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.newsFilesTable.name SET $name="$value" WHERE id=$id}]
# Возвращаем результат
	$result(1)
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result(0)
}
################################################################################
@SetFileVisible[id]
^try{
	$visible(^int:sql{SELECT visible FROM $self.newsFilesTable.name WHERE id=$id})
	^if($visible==1){$visible(0)}{$visible(1)}
	$res[^void:sql{UPDATE $self.newsFilesTable.name SET visible=$visible WHERE id=$id}]
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@CropImage[image_id;params]
^if(def $image_id && def $params.width && def $params.height){
	^if(!def $params.x){$params.x(0)}
	^if(!def $params.y){$params.y(0)}
	^try{
		$image[^table::sql{SELECT news_id, name FROM $self.newsGalleryTable.name WHERE id=$image_id}]
		^if(def $image){
			$root[${self.imagesFolder.root}/${image.name}]
			$src[${self.imagesFolder.src}/${image.name}]
			$small[${self.imagesFolder.small}/${image.name}]
			$res[^file:delete[$small;$.keep-empty-dirs(true)$.exception(false)]]
			$res[^cms:ImageCrop[$src;$root;$params.x;$params.y;$params.width;$params.height]]
			$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
			$res[^file:delete[$root;$.keep-empty-dirs(true)$.exception(false)]]
			$params[
				$.unit_id[$image_id]
				$.module[$self.className]
				$.module_id[$image.news_id]
				$.method[CropImage]
				$.description[Обрезка изображения]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result(1)
		}{
			$result(-2)
		}
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteBlock[blockId]
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
@SetMainImages[block_id]
^try{
# Инициализируем id блока
	^if(def $block_id){$blockId($block_id)}{$blockId($self.blockId)}
# Инициализируем id страницы
	$page_id(^textext:GetPageIdByBlockId[$blockId])
# Инициализируем Хэш статистики
	$stat[
		$.set[^hash::create[]]
		$.unset[^hash::create[]]
	]
# Получаем список id новостей
	$news_ids[^table::sql{SELECT id FROM $self.newsTable.name WHERE id_page=$page_id}]
# Если что-то есть
	^if($news_ids){
# Пробегаем массив
		^news_ids.menu{
# Получаем id главного изображения
			$main_id(^int:sql{SELECT COUNT(id) FROM $self.newsGalleryTable.name WHERE news_id=$news_ids.id AND main=1})
# Если главное изображение не найдено
			^if($main_id < 1){
# Получаем id для будущего главного изображения
				$main_id(^int:sql{SELECT id FROM $self.newsGalleryTable.name WHERE news_id=$news_ids.id ORDER BY id LIMIT 0 , 1}[$.default(0)])
# Делаем изображение главным
				$res[^self.SetMainImage[$main_id]]
# Записываем его в статистику
				$stat.unset.[$news_ids.id][$main_id]
			}{
# Записываем его в статистику
				$stat.set.[$news_ids.id][$main_id]
			}
		}
	}
# Делаем запись в лог
	$params[
		$.unit_id[$image_id]
		$.module[$self.className]
		$.module_id[$block_id]
		$.method[SetMainImages]
		$.description[Определение всех главных изображений блока]
	]
	$res[^cms:InsertIntoLog[$params]]
# Возвращаем массив с id
	$result[$stat]
}{
# Отключаем ошибки
	$exception.handled(true)
# Возвращаем ошибку
	$result[$exception]
}
################################################################################
@GenerateHtaccessRules[]
# Инициализируем хэш ответа
$answer[
	$.htaccess[]
	$.sitemap[^hash::create[]]
]
$now[^date::now[]]
$pages[^structure:GetPagesByBlockName[$self.className]]
^if($pages){
	^pages.menu{
		$elements[^self.GetNews[$pages.id;$.visible(1)$.limitCount(-1)]]
		^if($elements.CLASS_NAME eq table){
			^elements.menu{
				^if(def $elements.url){$end_url[$elements.url]}{$end_url[$elements.id]}
				$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^$pages.uri/${end_url}/^$ index.html?p=${pages.id}&id=${elements.id} [L,QSA]^#0A]
				$answer.sitemap.[${elements.id}_${self.className}][^hash::create[]]
				$answer.sitemap.[${elements.id}_${self.className}].loc[${env:REQUEST_SCHEME}://$env:SERVER_NAME/$pages.uri/$end_url/]
#				$answer.sitemap.[${elements.id}_${self.className}].lastmod[${now.year}-^now.month.format[%02d]-^now.day.format[%02d]]
			}
		}
	}
}
$result[$answer]
################################################################################