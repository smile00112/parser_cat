################################################################################
@CLASS
video_cms
################################################################################
@USE
video.p
################################################################################
@BASE
video
################################################################################
@auto[]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.videoTable.name]
	]
]
$self.moduleOptions[
	$.main[
		$.small_width[
			$.caption[Ширина малого изображения]
			$.value($self.width.small)
			$.type_field(0)
		]
		$.big_width[
			$.caption[Ширина большого изображения]
			$.value[$self.width.big]
			$.type_field(0)
		]
		$.aspect_ratio[
			$.caption[Соотношение сторон]
			$.value[$self.aspectRatio]
			$.type_field(0)
		]
		$.per_page[
			$.caption[Кол-во элементов на странице]
			$.value[$self.perPage]
			$.type_field(0)
		]
		$.template[
			$.caption[Шаблон]
			$.value[$self.settings.template]
			$.type_field(0)
		]
	]
	$.rename[
	]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.perPage(^textext:GetOptionValue[per_page;$self.blockId;$self.perPage])
^self.height.foreach[key;value]{
	$self.width.[$key](^textext:GetOptionValue[${key}_width;$self.blockId;$self.width.[$key]])
}
$AspectRatio[^textext:GetOptionValue[aspect_ratio;$self.blockId;$self.aspectRatio]]
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
^self.width.foreach[key;value]{
	$self.height.[$key](^math:floor($value/$self.aspectRatio))
}
################################################################################
@LoadImage[url;params][answer]
^if(!def $params){^hash::create[$params]}
^if(def $url){
	^try{
		^curl:options[$.library[libcurl.so.4]]
		^if(!def $params.fileName){$params.fileName[noname.jpg]}
		$protocols[
			$.1[http:]
			$.2[https:]
		]
		^if(^url.pos[$protocols.1] == 0){
			^protocols.delete[2]
		}{
			^if(^url.pos[$protocols.2] == 0){
				^protocols.delete[1]
			}
		}
		^protocols.foreach[key;protocol]{
			^try{
				$answer[^curl:load[
					$.url[${protocol}${url}]
					$.name[$params.fileName]
					$.mode[binary]
					$.timeout(10)
				]]
			}{
				$exception.handled(true)
				$lastException[$exception]
			}
			^if($answer.CLASS_NAME eq 'file'){^break[];}
		}
		^if(def $lastException){
			^if($lastException.type eq 'curl.host'){
				$answer[
					$.error(true)
					$.text[Файл не найден]
				]
			}{
				$answer[
					$.error(true)
					$.text[Ошибка выполнения функции]
					$.exception[$lastException]
				]
			}
		}
		$result[$answer]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передан URL изображения]
	]
}
################################################################################
@GetYoutubeInfo[url][answer]
^if(def $url){
	^try{
		$res[^url.match[(?:.+?)?(?:\/v\/|watch\/|\?v=|\&v=|youtu\.be\/|\/v=|^^youtu\.be\/)([a-zA-Z0-9_-]{11})+][']]
		^if(^res.1.length[]>0){
			$answer[
				$.identifier[$res.1]
			]
			^self.hosters.youtube.defaultImageNames.foreach[key;imageName]{
				$answer.image[//img.youtube.com/vi/${answer.identifier}/${imageName}]
				$answer.imageFile[^self.LoadImage[$answer.image;$.fileName[${answer.identifier}.jpg]]]
				^if($answer.imageFile.CLASS_NAME eq 'file'){^break[];}
			}
			$result[$answer]
		}{
			$result[
				$.error(true)
				$.text[Идентификатор видео не найден]
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
}{
	$result[
		$.error(true)
		$.text[Не передана ссылка на видео]
	]
}
################################################################################
@GetRutubeInfo[url]
^if(def $url){
	^try{
		$rutubeInfo[^xdoc::load[http://rutube.ru/api/oembed/?url=$url&format=xml]]
		$res[^rutubeInfo.select[/root]]
		$videoString[^res.0.selectString[string(html)]]
		$keyString[//rutube.ru/play/embed/]
		$pos(^videoString.pos[$keyString])
		^if($pos > -1){
			$videoString[^videoString.mid(^eval($pos+^keyString.length[]))]
			$pos(^videoString.pos["])
			^if($pos > -1){
				$result[
					$.identifier[^videoString.mid(0;^eval($pos))]
					$.image[^res.0.selectString[string(thumbnail_url)]]
				]
			}{
				$result[
					$.error(true)
					$.text[Идентификатор видео не найден]
				]
			}
		}{
			$result[
				$.error(true)
				$.text[Идентификатор видео не найден]
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
}{
	$result[
		$.error(true)
		$.text[Не передана ссылка на видео]
	]
}
################################################################################
@GetFacebookInfo[url]
^if(def $url){
	^try{
		$result[
			$.identifier[$url]
			$.image[]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передана ссылка на видео]
	]
}
################################################################################
@ParseURL[src][src]
^if(def $src){
	$answer[^hash::create[]]
# Если источник видео - youtube
	^if(^src.pos[youtube.com]>-1 || ^src.pos[youtu.be]>-1){
		$answer.hoster[youtube]
		$answer.videoInfo[^self.GetYoutubeInfo[$src]]
	}
# Если источник видео - rutube
	^if(^src.pos[rutube.ru]>-1){
		$answer.hoster[rutube]
		$answer.videoInfo[^self.GetRutubeInfo[$src]]
	}
# Если источник видео - facebook
	^if(^src.pos[facebook.com]>-1){
		$answer.hoster[facebook]
		$answer.videoInfo[^self.GetFacebookInfo[$src]]
	}
# Если это видео не поддерживается
	^if(!def $answer.hoster || $answer.videoInfo.identifier eq "-1"){
		$result[
			$.error(true)
			$.text[Этот источник видео не поддерживается]
		]
	}{
		$result[$answer]
	}
}{
	$result[
		$.error(true)
		$.text[Не передана ссылка на видео]
	]
}
################################################################################
@InsertVideo[params]
^if(!def $params.type){$params.type(1)}
^if(def $params.src || $params.type<1){
	^try{
		^if(!def $params.blockID){$params.blockID[$self.blockId]}
		^if(!def $params.blockName){$params.blockName[$self.className]}
		^if(!def $params.userID){$params.userID(0)}
		^if(!def $params.visible){$params.visible(1)}
		^if(!def $params.parent){$params.parent(0)}
		^if(!def $params.sortir){$params.sortir(^int:sql{SELECT MAX(sortir) FROM $self.videoTable.name WHERE block_id=$params.blockID AND parent=$params.parent}+1)}
		$addFlag(true)
		$videoURL[^cms:ConvertUrl[^cms:Translit[^params.name.replace[ ;-];$.filename(1)]]]
		$fields[block_id, block_name, user_id, name, visible, sortir, type, parent, url, title, keywords, description, create_date]
		$values[$params.blockID, '$params.blockName', $params.userID, '$params.name', $params.visible, $params.sortir, $params.type, $params.parent, "^cms:GetImageName[$self.videoTable.name;^videoURL.lower[];;;url]",'$params.name', '$params.name', '$params.name', '^site:currentDate.sql-string[]']
		^if($params.type){
			$answer[^self.ParseURL[$params.src]]
			^if(!$answer.error){
				$fields[${fields}, hoster, src]
				$values[${values}, '$answer.hoster', '$answer.videoInfo.identifier']
			}{
				$addFlag(false)
			}
		}
		^if($addFlag){
# Добавляем видео в базу данных
			^void:sql{INSERT INTO $self.videoTable.name ($fields) VALUES ($values)}
# Получаем ID вставленного видео
			$videoID(^int:sql{SELECT id FROM $self.videoTable.name WHERE create_date='^site:currentDate.sql-string[]'}[$.default(0)])
			^if($params.type>0){
# Сохраняем картинку для видео
				^if($videoID>0 && $answer.videoInfo.imageFile.CLASS_NAME eq 'file'){
					$answer[^self.AddImage[$videoID;$answer.videoInfo.imageFile]]
				}
			}
# Делаем запись в лог
			$logParams[
				$.unit_id[$videoID]
				$.module[$params.blockName]
				$.module_id[$params.blockID]
				$.method[InsertVideo]
				$.description[Добавление ^if($params.type){видео}{видеогалереи}]
			]
			$res[^cms:InsertIntoLog[$logParams]]
			$result[
				$.error(false)
				$.text[^if($params.type){Видео добавлено}{Видеогалеря добавлена}]
			]
		}{
			$result[$answer]
		}
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передана ссылка на видео]
	]
}
################################################################################
@DeleteVideo[video_id]
^try{
	$video[^self.GetVideo[$.IDs($video_id)]]
	^if($video.CLASS_NAME eq table){
		^if(def $video){
			$answer[^self.DeleteImage[$video.id]]
			^void:sql{DELETE FROM $self.videoTable.name WHERE id=$video.id}
# Делаем запись в лог
			$params[
				$.unit_id[$video.id]
				$.module[$video.block_name]
				$.module_id[$video.block_id]
				$.method[DeleteVideo]
				$.description[Удаление видео]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Видео удалено]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестное видео]
			]
		}
	}{
		$result[^hash::create[$video]]
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
@SetVisible[video_id;value]
^try{
	$video[^self.GetVideo[$.IDs($video_id)]]
	^if($video.CLASS_NAME eq table){
		^if(def $video){
			^if(!def $value){
				$visible(^int:sql{SELECT visible FROM $self.videoTable.name WHERE id=$video.id})
				^if($visible==1){$visible(0)}{$visible(1)}
			}{
				$visible($value)
			}
			^void:sql{UPDATE $self.videoTable.name SET visible=$visible WHERE id=$video.id}
# Делаем запись в лог
			$params[
				$.unit_id[$video.id]
				$.module[$video.block_name]
				$.module_id[$video.block_id]
				$.method[SetVisible]
				$.description[Установка видимости видео]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.visible($visible)
				$.text[Видимость изменена]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестное видео]
			]
		}
	}{
		$result[^hash::create[$video]]
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
@SaveField[video_id;field;value]
^try{
	$video[^self.GetVideo[$.IDs($video_id)]]
	^if($video.CLASS_NAME eq table){
		^if(def $video){
			$res[^void:sql{UPDATE $self.videoTable.name SET $field='$value' WHERE id=$video.id}]
# Делаем запись в лог
			$params[
				$.unit_id[$video.id]
				$.module[$video.block_name]
				$.module_id[$video.block_id]
				$.method[SaveField]
				$.description[Сохранение значения "$value" поля "$field" видео]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Значение сохранено]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестное видео]
			]
		}
	}{
		$result[^hash::create[$video]]
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
@DeleteBlock[block_id]
^try{
	$res[^void:sql{DELETE FROM $self.videoTable.name WHERE block_id=$block_id}]
	$res[^textext:DeleteOptions[$block_id]]
	$res[^textext:Delete[$block_id]]
# Делаем запись в лог
	$params[
		$.unit_id[$block_id]
		$.module[$self.className]
		$.module_id[$block_id]
		$.method[DeleteBlock]
		$.description[Удаление блока]
	]
	$res[^cms:InsertIntoLog[$params]]
	$result[
		$.error(false)
		$.text[Блок удалён]
	]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@AddImage[video_id;image][answer]
$video_id(^video_id.int(0))
# Если передан id видео
^if($video_id>0){
	^if(def $image){
		^try{
# Получаем уникальное имя для изображения
			$imageName[^cms:GetImageName[$self.videoTable.name;^cms:Translit[$image.name;$.filename(1)];;;image]]
			$small[${self.folders.images.small}/${imageName}]
			$big[${self.folders.images.big}/${imageName}]
			$src[${self.folders.images.src}/${imageName}]
			$root[${self.folders.images.root}/${imageName}]
			$res(^image.save[binary;$root])
			$res[^cms:ImageResize[$root;$big;$self.width.big]]
			$res[^cms:ImageResize[$root;$small;$self.width.min]]
			$res[^cms:ImageResize[$root;$src;$self.width.src]]
			$res[^file:delete[$root]]
			^void:sql{UPDATE $self.videoTable.name SET image='$imageName' WHERE id=$video_id}
# Делаем запись в лог
			$params[
				$.module[$self.className]
				$.module_id[$params.block_id]
				$.method[AddImage]
				$.description[Добавление изображения]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Изображение добавлено]
			]
		}{
			$exception.handled(true)
			$result[
				$.error(true)
				$.text[Ошибка выполнения скрипта]
				$.exception[$exception]
			]
		}
	}{
		$result[
			$.error(true)
			$.text[Не передано изображение]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передан ID видео]
	]
}
################################################################################
@CropImage[element_id;params]
^if(def $element_id && def $params.width && def $params.height){
	^if(!def $params.x){$params.x(0)}
	^if(!def $params.y){$params.y(0)}
	^try{
		$element[^table::sql{SELECT * FROM $self.videoTable.name WHERE id=$element_id}]
		^if(def $element){
			$root[${self.folders.images.root}/${element.image}]
			$src[${self.folders.images.src}/${element.image}]
			$big[${self.folders.images.big}/${element.image}]
			$small[${self.folders.images.small}/${element.image}]
			$deleteParams[$.keep-empty-dirs(true)$.exception(false)]
			^file:delete[$big;$deleteParams]
			^file:delete[$small;$deleteParams]
			$res[^cms:ImageCrop[$src;$root;$params.x;$params.y;$params.width;$params.height]]
			$res[^cms:ImageResize[$root;$big;$self.width.big]]
			$res[^cms:ImageResize[$root;$small;$self.width.small]]
			$res[^file:delete[$root;$deleteParams]]
			$params[
				$.unit_id[$element_id]
				$.module[$self.className]
				$.module_id[$element.block_id]
				$.method[CropImage]
				$.description[Обрезка изображения]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Изображение обрезано]
			]
		}{
			$result[
				$.error(true)
				$.text[Элемент не найден]
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
}{
	$result[
		$.error(true)
		$.text[Не переданы данные об изображении]
	]
}
################################################################################
@DeleteImage[video_id]
^try{
	$video[^self.GetVideo[$.IDs($video_id)]]
	^if($video.CLASS_NAME eq table){
		^if(def $video){
			$delParams[$.keep-empty-dirs(true)$.exception(false)]
			^file:delete[${self.folders.images.src}/${video.image};$delParams]
			^file:delete[${self.folders.images.big}/${video.image};$delParams]
			^file:delete[${self.folders.images.small}/${video.image};$delParams]
			^void:sql{UPDATE $self.videoTable.name SET image='' WHERE id=$video.id}
# Делаем запись в лог
			$params[
				$.unit_id[$video.id]
				$.module[$video.block_name]
				$.module_id[$video.block_id]
				$.method[DeleteImage]
				$.description[Удаление изображения для видео с ID=$video_id]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Изображение удалено]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестное видео]
			]
		}
	}{
		$result[^hash::create[$video]]
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
@GenerateHtaccessRules[]
# Инициализируем хэш ответа
$answer[
	$.htaccess[]
	$.sitemap[^hash::create[]]
]
$blocks[^structure:GetBlocksByBlockName[$self.className]]
^if($blocks){
	^blocks.menu{
		$elements[^self.GetVideo[$blockIDs($blocks.id)$.visible(1)$.type(0)$.blockName[$self.className]]]
		^if($elements.CLASS_NAME eq table){
			$params[$.page_url[^site:GetPageUrlById[$blocks.page_id;skip_main]]]
			^elements.menu{
				$params.element[$elements.fields]
				$element_url[^self.GetElementUrl[$params]]
				$answer.htaccess[${answer.htaccess}^#0ARewriteRule ^^^element_url.trim[left;/]^$ index.html?p=${blocks.page_id}&video_id=${elements.id} [L,QSA]^#0A]
				$answer.sitemap.[${elements.id}_${self.className}][^hash::create[]]
				$answer.sitemap.[${elements.id}_${self.className}].loc[${env:REQUEST_SCHEME}://${env:SERVER_NAME}${element_url}]
			}
		}
	}
}
$result[$answer]
################################################################################
@ChangeParent[elementIDs;parentID]
^if(def $elementIDs && def $parentID){
	^try{
		^if($elementIDs.CLASS_NAME eq hash){
			$stringIDs[]
			^elementIDs.foreach[key;value]{
				$stringIDs[${stringIDs},${value}]
			}
			$elementIDs[^stringIDs.trim[left;,]]
		}
		^void:sql{UPDATE $self.videoTable.name SET parent=^parentID.int(0) WHERE id IN ($elementIDs)}
		$result[
			$.error(false)
			$.text[Привязка завершена]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Недостаточно параметров]
	]
}
################################################################################