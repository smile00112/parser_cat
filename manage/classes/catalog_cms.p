################################################################################
@CLASS
catalog_cms
################################################################################
@USE
catalog.p
################################################################################
@BASE
catalog
################################################################################
# ---------- Проверить ----------
# Есть дублирующая функция @Delete[id], но не помню почему не удалил её.
# -------------------------------
@auto[]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.catalogTable.name]
		$.2[$self.catalogTextsTable.name]
		$.3[$self.catalogFilesTable.name]
		$.4[$self.catalogPricesTable.name]
		$.5[$self.catalogGalleryTable.name]
		$.6[$self.catalogExpandFieldsTable.name]
		$.7[$self.catalogFiltersTable.name]
		$.8[$self.catalogFilterFieldsTable.name]
		$.9[$self.catalogRelatedsTable.name]
		$.10[$self.catalogSizesTable.name]
		$.11[$self.catalogSizesRelationsTable.name]
		$.12[$self.catalogColorsTable.name]
		$.13[$self.catalogColorsRelationsTable.name]
		$.14[$self.catalogCurrenciesTable.name]
		$.15[$self.catalogStickersTable.name]
		$.16[$self.catalogStickersColorsTable.name]
		$.17[$self.catalogStickersRelationsTable.name]
	]
	$.superfluous[
		$.1[basket]
		$.2[shop_vitrina]
		$.3[shop_group]
		$.4[shop_order]
		$.5[class_catalog_gke]
		$.6[catalog_fields]
		$.7[catalog_field_types]
		$.8[catalog_accessories]
		$.9[catalog_gallery_second]
	]
	$.rename[
		$.cat_gallery[$self.catalogGalleryTable.name]
	]
	$.expandFields[$self.catalogExpandFieldsTable.name]
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
		$.elements_per_page[
			$.caption[Кол-во элементов на странице]
			$.value[$self.elementsPerPage]
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
		$.show_price[
			$.caption[Отображать цену]
			$.value[$self.settings.showPrice]
			$.type_field(1)
		]
		$.show_to_order[
			$.caption[Под заказ]
			$.value[$self.settings.showToOrder]
			$.type_field(1)
		]
		$.show_favorites[
			$.caption[Отображать избранное]
			$.value[$self.settings.showFavorites]
			$.type_field(1)
		]
		$.show_head[
			$.caption[Отображать описание]
			$.value[$self.settings.showHead]
			$.type_field(1)
		]
		$.show_folder_head[
			$.caption[Отображать описание раздела]
			$.value[$self.settings.showFolderHead]
			$.type_field(1)
		]
		$.set_text_head[
			$.caption[Описание текстом]
			$.value[$self.settings.setTextHead]
			$.type_field(1)
		]
		$.show_folder_actions[
			$.caption[Отображать действия для раздела]
			$.value[$self.settings.showFolderActions]
			$.type_field(1)
		]
		$.show_sync[
			$.caption[Отображать синхронизацию]
			$.value[$self.settings.showSync]
			$.type_field(1)
		]
		$.show_no_sync[
			$.caption[Отключение синхронизации]
			$.value[$self.settings.showNoSync]
			$.type_field(1)
		]
		$.show_comments[
			$.caption[Отображать комментарии]
			$.value[$self.settings.showComments]
			$.type_field(1)
		]
		$.show_parent[
			$.caption[Отображать родителя]
			$.value[$self.settings.showParent]
			$.type_field(1)
		]
		$.show_id[
			$.caption[Отображать id]
			$.value[$self.settings.showId]
			$.type_field(1)
		]
		$.show_parts[
			$.caption[Отображать части]
			$.value[$self.settings.showParts]
			$.type_field(1)
		]
		$.show_components[
			$.caption[Товары в товарах]
			$.value[$self.settings.showСomponents]
			$.type_field(1)
		]
		$.show_new[
			$.caption[Показать новинку]
			$.value[$self.settings.showNew]
			$.type_field(1)
		]
		$.show_stock[
			$.caption[Показать акцию]
			$.value[$self.settings.showStock]
			$.type_field(1)
		]
		$.show_all[
			$.caption[Выводить весь каталог]
			$.value[$self.settings.showAll]
			$.type_field(1)
		]
		$.show_filters[
			$.caption[Выводить фильтры]
			$.value[$self.settings.showFilters]
			$.type_field(1)
		]
		$.show_related[
			$.caption[Сопутствующие товары]
			$.value[$self.settings.showRelated]
			$.type_field(1)
		]
		$.show_step[
			$.caption[Шаг (для количества)]
			$.value[$self.settings.showStep]
			$.type_field(1)
		]
		$.save_childs_step[
			$.caption[Сохранять шаг для всех потомков]
			$.value[$self.settings.saveChildsStep]
			$.type_field(1)
		]
		$.show_expand_fields[
			$.caption[Отображать дополнительные поля]
			$.value[$self.settings.showExpandFields]
			$.type_field(1)
		]
		$.show_diagnostics[
			$.caption[Отображать диагностику]
			$.value[$self.settings.showDiagnostics]
			$.type_field(1)
		]
		$.show_colors[
			$.caption[Отображать цвета]
			$.value[$self.settings.showColors]
			$.type_field(1)
		]
		$.show_sizes[
			$.caption[Отображать размеры]
			$.value[$self.settings.showSizes]
			$.type_field(1)
		]
		$.show_stickers[
			$.caption[Отображать стикеры]
			$.value[$self.settings.showStickers]
			$.type_field(1)
		]
		$.show_currencies[
			$.caption[Отображать валюту]
			$.value[$self.settings.showCurrencies]
			$.type_field(1)
		]
		$.shipping_date[
			$.caption[Дата отгрузки]
			$.value[$self.settings.shippingDate]
			$.type_field(0)
		]
		$.shipping_date_min[
			$.caption[Дата отгрузки (min)]
			$.value[$self.settings.shippingDateMin]
			$.type_field(0)
		]
		$.shipping_date_max[
			$.caption[Дата отгрузки (max)]
			$.value[$self.settings.shippingDateMax]
			$.type_field(0)
		]
		$.show_services[
			$.caption[Отображать сервисы]
			$.value[$self.settings.showServices]
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
$self.elementsPerPage(^textext:GetOptionValue[elements_per_page;$self.blockId;$self.elementsPerPage])
$self.settings.showHead(^textext:GetOptionValue[show_head;$self.blockId;$self.settings.showHead])
$self.settings.showFolderHead(^textext:GetOptionValue[show_folder_head;$self.blockId;$self.settings.showFolderHead])
$self.settings.setTextHead(^textext:GetOptionValue[set_text_head;$self.blockId;$self.settings.setTextHead])
$self.settings.showFolderActions(^textext:GetOptionValue[show_folder_actions;$self.blockId;$self.settings.showFolderActions])
$self.settings.showPrice(^textext:GetOptionValue[show_price;$self.blockId;$self.settings.showPrice])
$self.settings.showFavorites(^textext:GetOptionValue[show_favorites;$self.blockId;$self.settings.showFavorites])
$self.settings.showToOrder(^textext:GetOptionValue[show_to_order;$self.blockId;$self.settings.showToOrder])
$self.settings.showSync(^textext:GetOptionValue[show_sync;$self.blockId;$self.settings.showSync])
$self.settings.showNoSync(^textext:GetOptionValue[show_no_sync;$self.blockId;$self.settings.showNoSync])
$self.settings.showComments(^textext:GetOptionValue[show_comments;$self.blockId;$self.settings.showComments])
$self.settings.joint(^textext:GetOptionValue[joint;$self.blockId;$self.settings.joint])
$self.settings.showAll(^textext:GetOptionValue[show_all;$self.blockId;$self.settings.showAll])
$self.settings.showParent(^textext:GetOptionValue[show_parent;$self.blockId;$self.settings.showParent])
$self.settings.showId(^textext:GetOptionValue[show_id;$self.blockId;$self.settings.showId])
$self.settings.showParts(^textext:GetOptionValue[show_parts;$self.blockId;$self.settings.showParts])
$self.settings.showСomponents(^textext:GetOptionValue[show_components;$self.blockId;$self.settings.showСomponents])
$self.settings.showNew(^textext:GetOptionValue[show_new;$self.blockId;$self.settings.showNew])
$self.settings.showStock(^textext:GetOptionValue[show_stock;$self.blockId;$self.settings.showStock])
$self.settings.showFilters(^textext:GetOptionValue[show_filters;$self.blockId;$self.settings.showFilters])
$self.settings.showRelated(^textext:GetOptionValue[show_related;$self.blockId;$self.settings.showRelated])
$self.settings.showStep(^textext:GetOptionValue[show_step;$self.blockId;$self.settings.showStep])
$self.settings.saveChildsStep(^textext:GetOptionValue[save_childs_step;$self.blockId;$self.settings.saveChildsStep])
$self.settings.showExpandFields(^textext:GetOptionValue[show_expand_fields;$self.blockId;$self.settings.showExpandFields])
$self.settings.showDiagnostics(^textext:GetOptionValue[show_diagnostics;$self.blockId;$self.settings.showDiagnostics])
$self.settings.showColors(^textext:GetOptionValue[show_colors;$self.blockId;$self.settings.showColors])
$self.settings.showSizes(^textext:GetOptionValue[show_sizes;$self.blockId;$self.settings.showSizes])
$self.settings.showStickers(^textext:GetOptionValue[show_stickers;$self.blockId;$self.settings.showStickers])
$self.settings.showCurrencies(^textext:GetOptionValue[show_currencies;$self.blockId;$self.settings.showCurrencies])
^if($self.settings.showColors){$self.colors[^self.GetColors[]]}
^if($self.settings.showSizes){$self.sizes[^self.GetSizes[]]}
^if($self.settings.showStickers){$self.stickers[^self.GetStickers[]]}
^if($self.settings.showCurrencies){$self.currencies[^self.GetCurrencies[]]}
$self.settings.shippingDate[^textext:GetOptionValue[shipping_date;$self.blockId;$self.settings.shippingDate]]
$self.settings.shippingDateMin[^textext:GetOptionValue[shipping_date_min;$self.blockId;$self.settings.shippingDateMin]]
$self.settings.shippingDateMax[^textext:GetOptionValue[shipping_date_max;$self.blockId;$self.settings.shippingDateMax]]
$self.settings.showServices(^textext:GetOptionValue[show_services;$self.blockId;$self.settings.showServices])
################################################################################
@Delete[id]
$result[^void:sql{DELETE FROM $self.catalogTable.name WHERE id=$id}]
################################################################################
@DeleteElement[element_id][childs]
^if(def $element_id){
	^try{
		$childs[^self.GetElements[$.parent($element_id)]]
		^if(def $childs){
			^childs.menu{
				$res[^self.DeleteElement[$childs.id]]
			}
		}
		$images[^self.GetImages[$element_id;$.limitCount(9999999)]]
		^if(def $images){
			^images.menu{
				$res[^self.DeleteImage[$images.id]]
			}
		}
		$files[^self.GetFiles[$element_id;$.limitCount(9999999)]]
		^if(def $files){
			^files.menu{
				$res[^self.DeleteFile[$files.id]]
			}
		}
		$videos[^video_cms:GetVideo[$.IDs($element_id)]]
		^if(def $videos){
			^videos.menu{
				$res[^video_cms:DeleteVideo[$videos.id]]
			}
		}
		$block_id(^int:sql{SELECT block_id FROM $self.catalogTable.name WHERE id=$element_id}[$.default(0)])
		^void:sql{DELETE FROM $self.catalogTable.name WHERE id=$element_id}
# Делаем запись в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$block_id]
			$.method[DeleteElement]
			$.description[Удаление елемента каталога]
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
@CropImage[image_id;params]
^if(def $image_id && def $params.width && def $params.height){
	^if(!def $params.x){$params.x(0)}
	^if(!def $params.y){$params.y(0)}
	^try{
		$image[^table::sql{SELECT element_id, name FROM $self.catalogGalleryTable.name WHERE id=$image_id}]
		^if(def $image){
			$root[${self.imagesFolder.root}/${image.name}]
			$src[${self.imagesFolder.src}/${image.name}]
			$small[${self.imagesFolder.small}/${image.name}]
			$big[${self.imagesFolder.big}/${image.name}]
			$res[^file:delete[$small;$.keep-empty-dirs(true)$.exception(false)]]
			$res[^file:delete[$big;$.keep-empty-dirs(true)$.exception(false)]]
			$res[^cms:ImageCrop[$src;$root;$params.x;$params.y;$params.width;$params.height]]
			$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
			$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;^eval($self.imagesWidth.big/$self.imagesAspectRatio)]]
			$res[^file:delete[$root;$.keep-empty-dirs(true)$.exception(false)]]
			$params[
				$.unit_id[$image_id]
				$.module[$self.className]
				$.module_id[$image.element_id]
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
@SaveElementProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.catalogTable.name SET $name='$value' WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@SetVisible[element_id;value;params][childs]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.recursively){$params.recursively(true)}
^try{
	^if(!def $value){
		$visible(^int:sql{SELECT visible FROM $self.catalogTable.name WHERE id=$element_id})
		^if($visible==1){$visible(0)}{$visible(1)}
	}{
		$visible($value)
	}
	$res[^void:sql{UPDATE $self.catalogTable.name SET visible=$visible WHERE id=$element_id}]
	^if($params.recursively){
		$childs[^self.GetElements[$.parent($element_id)]]
		^if(def $childs){
			^childs.menu{
				$res(^self.SetVisible[$childs.id;$visible;$params])
			}
		}
	}
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@SetImageVisible[id]
^try{
	$visible(^int:sql{SELECT visible FROM $self.catalogGalleryTable.name WHERE id=$id})
	^if($visible==1){$visible(0)}{$visible(1)}
	$res[^void:sql{UPDATE $self.catalogGalleryTable.name SET visible=$visible WHERE id=$id}]
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@SaveImageProperty[id;name;value]
^try{
	$res[^void:sql{UPDATE $self.catalogGalleryTable.name SET $name='$value' WHERE id=$id}]
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
	$element_id(^int:sql{SELECT element_id FROM $self.catalogGalleryTable.name WHERE id=$image_id})
# Получаем id главного изображения
	$main_id(^int:sql{SELECT id FROM $self.catalogGalleryTable.name WHERE element_id=$element_id AND main=1}[$.default(0)])
# Делаем его неглавным
	$res[^void:sql{UPDATE $self.catalogGalleryTable.name SET main=0 WHERE id=$main_id}]
# Делаем главным искомое изображение
	$res[^void:sql{UPDATE $self.catalogGalleryTable.name SET main=1 WHERE id=$image_id}]
# Делаем запись в лог
	$params[
		$.unit_id[$image_id]
		$.module[$self.className]
		$.module_id[$element_id]
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
@InsertImage[params]
^try{
# Если передаётся id новости и файлы
	^if(def $params.element_id && def $params.file){
		^if(!def $params.main){$params.main(0)}
		^if(!def $params.visible){$params.visible(0)}
# Получаем уникальное имя для изображения
		$imageName[^cms:GetImageName[$self.catalogGalleryTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
		$small[${self.imagesFolder.small}/${imageName}]
		$big[${self.imagesFolder.big}/${imageName}]
		$src[${self.imagesFolder.src}/${imageName}]
		$root[${self.imagesFolder.root}/${imageName}]
		$res(^params.file.save[binary;$root])
		$res[^cms:ImageResize[$root;$big;$self.imagesWidth.big;^eval($self.imagesWidth.big/$self.imagesAspectRatio)]]
		$res[^cms:ImageResize[$root;$small;$self.imagesWidth.small;^eval($self.imagesWidth.small/$self.imagesAspectRatio)]]
		$res[^cms:ImageResize[$root;$src;1024;9999999]]
		$res[^file:delete[$root]]
		$sortir(^eval(^int:sql{SELECT COUNT(id) FROM $self.catalogGalleryTable.name WHERE element_id=$params.element_id}*10+10))
		$res[^void:sql{
			INSERT INTO $self.catalogGalleryTable.name
				(element_id, name, descript, main, sortir, visible)
			VALUES
				($params.element_id, "$imageName", "$params.description", $params.main, $sortir, $params.visible)
		}]
# Делаем запись в лог
		$params[
			$.module[$self.className]
			$.module_id[$params.element_id]
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
	$image[^table::sql{SELECT element_id, name FROM $self.catalogGalleryTable.name WHERE id=$image_id}]
	^if(def $image){
		$res[^file:delete[${self.imagesFolder.src}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.big}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.small}/${image.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^void:sql{DELETE FROM $self.catalogGalleryTable.name WHERE id=$image_id}]
# Делаем запись в лог
		$params[
			$.unit_id[$image_id]
			$.module[$self.className]
			$.module_id[$image.element_id]
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
@InsertFile[params]
^try{
# Если передаётся id новости и файлы
	^if(def $params.element_id && def $params.file){
		^if(!def $params.visible){$params.visible(0)}
# Получаем уникальное имя для изображения
		$fileName[^cms:GetImageName[$self.catalogFilesTable.name;^cms:Translit[$params.file.name;$.filename(1)]]]
		$res(^params.file.save[binary;${self.filesFolder}/${params.element_id}/${fileName}])
		$sortir(^eval(^int:sql{SELECT COUNT(id) FROM $self.catalogFilesTable.name WHERE element_id=$params.element_id}*10+10))
		$res[^void:sql{
			INSERT INTO $self.catalogFilesTable.name
				(element_id, name, descript, sortir, visible)
			VALUES
				($params.element_id, '$fileName', '$params.description', $sortir, $params.visible)
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
	$file[^table::sql{SELECT element_id, name FROM $self.catalogFilesTable.name WHERE id=$file_id}]
	^if(def $file){
		$res[^file:delete[${self.filesFolder}/${file.element_id}/${file.name};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^void:sql{DELETE FROM $self.catalogFilesTable.name WHERE id=$file_id}]
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
	$res[^void:sql{UPDATE $self.catalogFilesTable.name SET $name="$value" WHERE id=$id}]
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
	$visible(^int:sql{SELECT visible FROM $self.catalogFilesTable.name WHERE id=$id})
	^if($visible==1){$visible(0)}{$visible(1)}
	$res[^void:sql{UPDATE $self.catalogFilesTable.name SET visible=$visible WHERE id=$id}]
	$result($visible)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@CreateElement[params]
^if(def $params.name && def $params.type){
	^if(!def $params.parent){$params.parent(0)}
	^try{
		^if(!def $params.sortir){
			$params.sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.catalogTable.name WHERE parent=$params.parent}+10))
		}
		^if(!def $params.visible){$params.visible(1)}
		$counter(0)
		$allFields[^params._keys[]]
		^allFields.menu{
			^counter.inc[]
			^if($counter==1){$fields[$allFields.key]}{$fields[${fields}, $allFields.key]}
			^if($counter==1){$values['$params.[$allFields.key]']}{$values[${values}, '$params.[$allFields.key]']}
		}
		$elementURL[^cms:ConvertUrl[^cms:Translit[^params.name.replace[ ;-];$.filename(1)]]]
		$res[^void:sql{INSERT INTO $self.catalogTable.name ($fields, url) VALUES ($values, "^cms:GetImageName[$self.catalogTable.name;^elementURL.lower[];;;url]")}]
# Делаем запись в лог
		$params[
			$.unit_id[]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[CreateElement]
			$.description[Создание элемента каталога]
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
#-------------------------------- Синхронизация --------------------------------
################################################################################
@GetExportText[block_id]
^if(!def $block_id){$block_id($self.blockId)}
$catalog[^table::sql{SELECT * FROM $self.catalogTable.name WHERE block_id=$block_id}]
^if(def $catalog){
	$fields[^table::sql{SHOW COLUMNS FROM $self.catalogTable.name WHERE Field != 'id'}]
	$text[id]
	^fields.menu{
		$text[$text	$fields.Field]
	}
	$text[$text^#0A]
	^catalog.menu{
		$values[$catalog.id]
		^fields.menu{
			$values[$values	^catalog.[$fields.Field].replace[^#0A;]]
		}
		$text[${text}$values^#0A]
	}
	$result[$text]
}{$result[]}
################################################################################
@GetExportXML[block_id]
^if(!def $block_id){$block_id($self.blockId)}
$catalog[^table::sql{SELECT * FROM $self.catalogTable.name WHERE block_id=$block_id}]
^if(def $catalog){
	$fields[^table::sql{SHOW COLUMNS FROM $self.catalogTable.name WHERE Field != 'id'}]
# Создаём XML-документ
	$document[^xdoc::create[catalog]]
# Создаём главный Тэг elements
	$elementsNode[^document.createElement[elements]]
# Пробегаем все элементы каталога
	^catalog.menu{
# Создаём Тэг element
		$elementNode[^document.createElement[element]]
# Прописываем ему id
		^elementNode.setAttribute[id;$catalog.id]
# Пробегаем все поля элемента
		^fields.menu{
# Создаём Тэг атрибута
		$attributeNode[^document.createElement[$fields.Field]]
# Прописываем значение атрибута
		$ValueElement[^document.createTextNode[$catalog.[$fields.Field]]]
# Добавляем значение атрибута
		$addedNode[^attributeNode.appendChild[$ValueElement]]
# Добавляем дочерний элемент
		$addedNode[^elementNode.appendChild[$attributeNode]]
		}
# Добавляем дочерний элемент
		$addedNode[^elementsNode.appendChild[$elementNode]]
	}
# Добавляем значение в документ
	$addedNode[^document.documentElement.appendChild[$elementsNode]]
# Выводим результат
	$result[^document.string[$.indent[yes]]]
}{$result[]}
################################################################################
@GetExportXLS[block_id]
$columnNumber(2)
$rowNumber(2)
^if(!def $block_id){$block_id($self.blockId)}
$catalog[^table::sql{SELECT * FROM $self.catalogTable.name WHERE block_id=$block_id}]
^if(def $catalog){
	$fields[^table::sql{SHOW COLUMNS FROM $self.catalogTable.name WHERE Field != 'id'}]
# Создаём XML-документ
	$document[^xdoc::create[Workbook]]
# ------------------------------ Настройки книги -------------------------------
	^document.documentElement.setAttribute[xmlns;urn:schemas-microsoft-com:office:spreadsheet]
	^document.documentElement.setAttribute[xmlns:o;urn:schemas-microsoft-com:office:office]
	^document.documentElement.setAttribute[xmlns:x;urn:schemas-microsoft-com:office:excel]
	^document.documentElement.setAttribute[xmlns:ss;urn:schemas-microsoft-com:office:spreadsheet]
	^document.documentElement.setAttribute[xmlns:html;http://www.w3.org/TR/REC-html40]
# ----------------------------------- Styles -----------------------------------
	$stylesNode[^document.createElement[Styles]]
	$addedNode[^document.documentElement.appendChild[$stylesNode]]
# ----------------------------------- Style ------------------------------------
	$styleNode[^document.createElement[Style]]
	^styleNode.setAttribute[ss:ID;Header]
	$alignmentNode[^document.createElement[Alignment]]
	^alignmentNode.setAttribute[ss:Horizontal;Center]
	^alignmentNode.setAttribute[ss:Vertical;Bottom]
	$bordersNode[^document.createElement[Borders]]
# ----------------------------------- Border -----------------------------------
	$borderNode[^document.createElement[Border]]
	^borderNode.setAttribute[ss:Position;Top]
	^borderNode.setAttribute[ss:LineStyle;Continuous]
	^borderNode.setAttribute[ss:Weight;2]
	$addedNode[^bordersNode.appendChild[$borderNode]]
	$borderNode[^document.createElement[Border]]
	^borderNode.setAttribute[ss:Position;Left]
	^borderNode.setAttribute[ss:LineStyle;Continuous]
	^borderNode.setAttribute[ss:Weight;2]
	$addedNode[^bordersNode.appendChild[$borderNode]]
	$borderNode[^document.createElement[Border]]
	^borderNode.setAttribute[ss:Position;Right]
	^borderNode.setAttribute[ss:LineStyle;Continuous]
	^borderNode.setAttribute[ss:Weight;2]
	$addedNode[^bordersNode.appendChild[$borderNode]]
	$borderNode[^document.createElement[Border]]
	^borderNode.setAttribute[ss:Position;Bottom]
	^borderNode.setAttribute[ss:LineStyle;Continuous]
	^borderNode.setAttribute[ss:Weight;2]
	$addedNode[^bordersNode.appendChild[$borderNode]]
# ------------------------------------------------------------------------------
	$addedNode[^bordersNode.appendChild[$borderNode]]
	$fontNode[^document.createElement[Font]]
	^fontNode.setAttribute[ss:Bold;1]
	$addedNode[^stylesNode.appendChild[$styleNode]]
	$addedNode[^styleNode.appendChild[$alignmentNode]]
	$addedNode[^styleNode.appendChild[$bordersNode]]
	$addedNode[^styleNode.appendChild[$fontNode]]
# --------------------------------- Worksheet ----------------------------------
	$worksheetNode[^document.createElement[Worksheet]]
	^worksheetNode.setAttribute[ss:Name;Лист1]
	$addedNode[^document.documentElement.appendChild[$worksheetNode]]
# ----------------------------------- Table ------------------------------------
	$tableNode[^document.createElement[Table]]
	$addedNode[^worksheetNode.appendChild[$tableNode]]
# ----------------------------------- Column -----------------------------------
	$columnNode[^document.createElement[Column]]
#	^columnNode.setAttribute[ss:Span;2]
# ------------------------------------ Row -------------------------------------
	$rowNode[^document.createElement[Row]]
	^rowNode.setAttribute[ss:Index;$rowNumber]
	$addedNode[^tableNode.appendChild[$rowNode]]
# --------------------------------- Заголовок ----------------------------------
	$counter(0)
	^fields.menu{
		^counter.inc[]
		$cellNode[^document.createElement[Cell]]
		^cellNode.setAttribute[ss:StyleID;Header]
		^if($counter==1){^cellNode.setAttribute[ss:Index;$columnNumber]}
		$dataNode[^document.createElement[Data]]
		$fieldElement[^document.createTextNode[$fields.Field]]
		^dataNode.setAttribute[ss:Type;String]
		$addedNode[^rowNode.appendChild[$cellNode]]
		$addedNode[^cellNode.appendChild[$dataNode]]
		$addedNode[^dataNode.appendChild[$fieldElement]]
	}
# --------------------------------- Тело ----------------------------------
	^catalog.menu{
# ------------------------------------ Row -------------------------------------
		$rowNode[^document.createElement[Row]]
		$addedNode[^tableNode.appendChild[$rowNode]]
		$counter(0)
		^fields.menu{
			^counter.inc[]
			$cellNode[^document.createElement[Cell]]
#			^cellNode.setAttribute[ss:StyleID;Cell]
			^if($counter==1){^cellNode.setAttribute[ss:Index;$columnNumber]}
			$dataNode[^document.createElement[Data]]
			$fieldElement[^document.createTextNode[$catalog.[$fields.Field]]]
			^dataNode.setAttribute[ss:Type;String]
			$addedNode[^rowNode.appendChild[$cellNode]]
			$addedNode[^cellNode.appendChild[$dataNode]]
			$addedNode[^dataNode.appendChild[$fieldElement]]
		}
	}
# ----------------------------------- Cell -------------------------------------
# ------------------------------------------------------------------------------
# Выводим результат
	$result[^document.string[$.indent[yes]]]
}{$result[]}
################################################################################
@ImportFile[file;block_id]
^if(!def $block_id){$block_id(0)}
^try{
	$counters[
		$.sync(0)
		$.insert(0)
		$.update(0)
	]
	$res[^file.save[text;export.tmp]]
	$catalog[^table::load[export.tmp]]
	^file:delete[export.tmp]
	^if(def $catalog){
		^void:sql{DELETE FROM $self.catalogTable.name WHERE block_id=$block_id}
		$id(^int:sql{SELECT MAX(id) FROM $self.catalogTable.name})
		^void:sql{ALTER TABLE $self.catalogTable.name AUTO_INCREMENT=^eval($id+1)}
		^catalog.menu{
			$parent(^int:sql{SELECT id FROM $self.catalogTable.name WHERE artikul='$catalog.parent'}[$.default(0)])
			$res[^void:sql{INSERT INTO $self.catalogTable.name (block_id, name, parent, price, visible, type, artikul) VALUES ($block_id, '$catalog.name', $parent, $catalog.price, ^if(def $catalog.visible){$catalog.visible}{1}, $catalog.type, '$catalog.artikul')}]
			^counters.insert.inc[]
			^counters.sync.inc[]
		}
		^make_rewrite[]
		$result[
			$.error(false)
			$.text[Синхронизация прошла успешно!]
			$.counters[$counters]
		]
	}{
		$result[
			$.error(true)
			$.text[Несоответствующий формат загружаемого файла]
		]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения]
		$.exception[$exception]
	]
}
################################################################################
@UpdateFile[file;block_id;params]
^if(!def $block_id){$block_id(0)}
#	Количество синхронизированных элементов за одну транзакцию
$transactionSyncCount(500)
#	Имя временного файла, в который сохраняем выгрузку
$tempFileName[import_file.tmp]
^try{
#	Если это первая транзакция
	^if(!def $params.count_sync){
#		Так как файл выгрузки приходит в кодироке WINDOWS-1251, приходится его переконвертировать
		$currentCharset[$request:charset]
		$request:charset[WINDOWS-1251]
		$res[^file.save[text;$tempFileName;$.charset[$currentCharset]]]
		$request:charset[$currentCharset]
#		Загружаем данные для синхронизации из файла
		$catalog[^table::load[$tempFileName]]
#		Если это соответствующий тип файла
		^if(def $catalog.id && def $catalog.name && def $catalog.parent && def $catalog.sortir && def $catalog.price && def $catalog.visible && def $catalog.type && def $catalog.artikul){
#			Делаем все элементы, помеченные для синхронизации, скрытыми (чтобы оставить видимыми только те, которые помечены в выгрузке)
			$res[^void:sql{UPDATE $self.catalogTable.name SET visible=0 WHERE no_sync=0}]
#			Определяем список единиц измерения, присутствующих в выгрузке
			$fileUnits[^hash::create[]]
			^catalog.menu{
				^if(!^fileUnits.contains[$catalog.ed]){
					$fileUnits.[$catalog.ed](true)
				}
			}
#			Получаем список имеющихся в базе единиц измерения
			$units[^self.GetUnits[]]
#			Инициализируем переменные для синхронизации единиц измерения
			$catalog_units_sql[INSERT INTO $self.catalogUnitsTable.name (name, point) VALUES]
			$missingUnitsCount(0)
#			Пробегаем все единицы измерения из файла
			^fileUnits.foreach[key;value]{
				^if(!^units.locate[name;$key] && $key ne "0"){
					$catalog_units_sql[$catalog_units_sql ("$key", 0),]
					^missingUnitsCount.inc[]
				}
			}
#			Если есть те единицы, которые нужно добавить
			^if($missingUnitsCount>0){
#				Добавляем их
				^void:sql{^catalog_units_sql.trim[right;,]}
			}
#			Возвращаем ответ
			$result[
				$.error(false)
				$.text[Начало синхронизации]
				$.counters[
					$.count_sync(0)
				]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестный формат файла]
			]
		}
	}{
#		Инициализируем счётчики
		$counters[
			$.count_sync(^params.count_sync.int(0))
			$.sync(^params.sync.int(0))
			$.insert(^params.insert.int(0))
			$.update(^params.update.int(0))
			$.errors(^params.errors.int(0))
		]
#		Если это последняя транзакция
		^if($params.lastTransaction){
#			Удаляем временные файлы
			^file:delete[$tempFileName]
#			Пересчитываем цены у тех элементов, которые состоят из частей
			$partsElements[^table::sql{SELECT id, parts FROM $self.catalogTable.name WHERE LENGTH(parts)>0}]
			$answer[^self.RecalcPartsPrices[$.elements[$partsElements]]]
#			Заносим изменения в .htaccess
			^make_rewrite[]
#			Возвращаем ответ
			^if($params.count_sync<1){
				$result[
					$.error(true)
					$.text[Нет элементов для синхронизации]
				]
			}{
				$answer[
					$.error(false)
					$.text[Синхронизировано $params.count_sync записей]
					$.endTransaction(true)
					$.counters[$counters]
				]
				^if($counters.sync<1){
					$answer.text[Не найдены элементы для синхронизации]
				}
				$result[$answer]
			}
		}{
#			По умолчанию считаем эту транзакцию последней
			$lastTransaction(true)
#			Инициализируем переменные для цен в городах
			$catalog_prices_sql[INSERT INTO $self.catalogPricesTable.name ( element_id, price, currency_id, discount, city_id) VALUES]
			$catalog_prices_delete_sql[DELETE FROM $self.catalogPricesTable.name WHERE element_id IN( 0]
#			Загружаем данные для синхронизации из файла
			$catalog[^table::load[$tempFileName]]
			$catalog[^catalog.select($catalog.type > -1)[$.offset($counters.count_sync)]]
#			Получаем список регионов
			$catalog_regions[^self.GetFileRegions[$.columns[^catalog.columns[]]]]
#			Получаем список имеющихся в базе единиц измерения
			$units[^self.GetUnits[]]
#			Получаем список имеющихся в базе валют
			$currencies[^self.GetCurrencies[]]
			$currencies[^currencies.hash[char_code]]
#			Получаем список кодов городов
			$cities[^contacts:GetCities[]]
			$cities[^cities.hash[code]]
#			Получаем все элементы каталога
			$allElements[^table::sql{SELECT id, no_sync, artikul FROM $self.catalogTable.name}]
#			Перебираем данные для синхронизации
			^catalog.menu{
				^counters.count_sync.inc[]
				^try{
					$element[^allElements.select($allElements.artikul eq '$catalog.artikul')]
					$parentElement[^allElements.select($allElements.artikul eq '$catalog.parent')]
					^if(def $parentElement){$parent($parentElement.id)}{$parent(0)}
					^if(^units.locate[name;$catalog.ed] && $catalog.ed ne "0"){
						$currentUnitId($units.id)
					}{
						$currentUnitId(1)
					}
					^if(def $element){
						$catalog_prices_delete_sql[$catalog_prices_delete_sql, $element.id]
						^void:sql{UPDATE $self.catalogTable.name SET ^if($element.no_sync==0){name='$catalog.name', visible=^if(def $catalog.visible){$catalog.visible}{1}, }price=$catalog.price, parent=$parent, unit_id=$currentUnitId^if(def $catalog.title){, title='$catalog.title'}^if(def $catalog.keywords){, keywords='$catalog.keywords'}^if(def $catalog.description){, description='$catalog.description'} WHERE artikul='$catalog.artikul'}
						^counters.update.inc[]
					}{
						^void:sql{INSERT INTO $self.catalogTable.name (block_id, name, parent, price, visible, type, artikul, unit_id, title, keywords, description) VALUES ($block_id, '$catalog.name', $parent, $catalog.price, ^if(def $catalog.visible){$catalog.visible}{1}, $catalog.type, '$catalog.artikul', $currentUnitId, '$catalog.title', '$catalog.keywords', '$catalog.description')}
						^counters.insert.inc[]
					}
					^catalog_regions.foreach[key;value]{
						^if($catalog.[price_${key}]>0 && def $element.id){
							$catalog_prices_sql[$catalog_prices_sql ($element.id, $catalog.[price_${key}], $currencies.[^catalog.[currency_${key}].upper[]].id, $catalog.[discount_${key}], ^if(def $cities.[^key.trim[left;0]].id){$cities.[^key.trim[left;0]].id}{0}),]
						}
					}
					^counters.sync.inc[]
				}{
					$exception.handled(true)
					^counters.errors.inc[]
				}
				^if(^math:frac(^eval($counters.count_sync/$transactionSyncCount))==0){
					$lastTransaction(false)
					^break[]
				}
			}
#			Удаляем цены из таблицы
			$res[^void:sql{${catalog_prices_delete_sql})}]
#			Добавляем цены в таблицу
			$res[^void:sql{^catalog_prices_sql.trim[right;,]}]
#			Выводим ответ
			$answer[
				$.error(false)
				$.text[Идёт синхронизация. Обработано $counters.count_sync элементов.]
				$.counters[$counters]
			]
			^if($lastTransaction){$answer.lastTransaction($lastTransaction)}
			$result[$answer]
		}
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения]
		$.exception[$exception]
	]
}
################################################################################
@GetFileRegions[params]
$catalog_regions[^hash::create[]]
^params.columns.menu{
	$parts[^params.columns.column.split[_;lh]]
	^switch[$parts.0]{
		^case[price]{
			^if(def $parts.1){
				$catalog_regions.[$parts.1][]
			}
		}
		^case[DEFAULT]{}
	}
}
$result[$catalog_regions]
################################################################################
@GetCatalogInfo[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.block_id){$params.block_id($self.blockId)}
^if(!def $params.parent){$params.parent(0)}
^try{
	$answer[^hash::sql{
		SELECT
			"stat",
			COUNT(id) AS allCount,
			(SELECT COUNT(id) FROM $self.catalogTable.name WHERE block_id=$params.block_id AND parent=$params.parent AND visible=1) AS visibleChildsCount,
			(SELECT COUNT(id) FROM $self.catalogTable.name WHERE block_id=$params.block_id AND parent=$params.parent AND visible=0) AS hiddenChildsCount
		FROM $self.catalogTable.name
		WHERE block_id=$params.block_id AND type=1
	}]
	$answer.stat.allChildsCount(^eval($answer.stat.visibleChildsCount+$answer.stat.hiddenChildsCount))
	$answer.error(false)
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка выполнения]
	]
}
$result[$answer]
################################################################################
@UpdateFieldByFile[field;file;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.block_id){$params.block_id($self.blockId)}
^if(!def $params.parent){$params.parent(0)}
^if(!def $params.sync_type){$params.sync_type[new]}
^if(!def $params.sync_region){$params.sync_region[current]}
^if(!def $params.orderField){$params.orderField[sortir]}
^if(!def $params.order){$params.order[ASC]}
^if(def $field && def $file){
	^try{
		^if(^file:justext[$file.name] eq 'txt'){
			$update_sql[UPDATE $self.catalogTable.name SET $field = CASE id]
			$params.sync_field[$field]
			$elements[^self.GetElementsWithChilds[$params]]
			$values[^file.text.split[^#0A][lv]]
			$counter(-1)
			^elements.foreach[pos;row]{
				^counter.inc[]
				^values.offset($counter)
				$update_sql[$update_sql WHEN $row.id THEN "$values.piece"]
			}
			$update_sql[$update_sql ELSE $field END]
			$res[^void:sql{$update_sql}]
			$answer[
				$.error(false)
				$.text[Синхронизировано поле <span style="color: red^;">$field</span> у <span style="color: green^;">^elements.count[]</span> элементов]
			]
		}{
			$answer[
				$.error(true)
				$.text[Неизвестный тип файла]
			]
		}
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[В процессе импорта произошла ошибка]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@GenerateHtaccessRules[]
# Инициализируем хэш ответа
$hAnswer[
	$.htaccess[]
	$.sitemap[^hash::create[]]
]
$now[^date::now[]]
$pages[^structure:GetPagesByBlockName[$self.className]]
^if($pages){
	^pages.menu{
		$elements[^self.GetElements[$.block_id(^textext:GetBlockIdByPageId[$pages.id;$self.className])$.visible(1)$.limitCount(-1)]]
		^if($elements){
			^elements.menu{
				^if(def $elements.url){$end_url[$elements.url]}{$end_url[$elements.id]}
				$parentId($elements.parent)
				$parent[^elements.select($elements.id==$parentId)]
				^if($elements.parent eq 0 || !$parent.type){
					^if(def $elements.redirect){
						$hAnswer.htaccess[${hAnswer.htaccess}^#0ARewriteRule ^^$pages.uri/${end_url}/^$ $elements.redirect [L,R=301]]
					}{
						$hAnswer.htaccess[${hAnswer.htaccess}^#0ARewriteRule ^^$pages.uri/${end_url}/^$ index.html?p=${pages.id}&idc=${elements.id} [L,QSA]^#0A]
						$hAnswer.sitemap.[${elements.id}_${self.className}][^hash::create[]]
						$hAnswer.sitemap.[${elements.id}_${self.className}].loc[${env:REQUEST_SCHEME}://$env:SERVER_NAME/$pages.uri/$end_url/]
#						$hAnswer.sitemap.[${elements.id}_${self.className}].lastmod[${now.year}-^now.month.format[%02d]-^now.day.format[%02d]]
					}
				}{
					^if(def $parent.url){$parent_url[$parent.url]}{$parent_url[$parent.id]}
					^if(def $elements.redirect){
						$hAnswer.htaccess[${hAnswer.htaccess}^#0ARewriteRule ^^$pages.uri/${end_url}/^$ $elements.redirect [L,R=301]]
					}{
						$hAnswer.htaccess[${hAnswer.htaccess}^#0ARewriteRule ^^$pages.uri/${end_url}/^$ $pages.uri/${parent_url}/ [L,R=301]^#0A]
					}
				}
			}
		}
	}
}
$result[$hAnswer]
################################################################################
@ToggleFilter[element_id;filter]
^if(^element_id.int(0) > 0 && def $filter){
	^try{
# Хэш для записи в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$block_id]
			$.method[ToggleFilter]
		]
		^if(^int:sql{SELECT COUNT(element_id) FROM $self.catalogFiltersTable.name WHERE element_id=$element_id AND filter="$filter"} > 0){
			^void:sql{DELETE FROM $self.catalogFiltersTable.name WHERE element_id=$element_id AND filter="$filter"}
			$answer[
				$.error(false)
				$.text[Фильтр удалён]
			]
			$params.description[Удаление фильтра "$filter" для товара (id=$element_id)]
		}{
			^void:sql{INSERT INTO $self.catalogFiltersTable.name (element_id, filter) VALUES ($element_id, "$filter")}
			$answer[
				$.error(false)
				$.text[Фильтр добавлен]
			]
			$params.description[Добавление фильтра "$filter" для товара (id=$element_id)]
		}
# Делаем запись в лог
		$res[^cms:InsertIntoLog[$params]]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[В процессе выполнения произошла ошибка]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@ToggleRelated[element_id;related_id]
^if(^element_id.int(0) > 0 && ^related_id.int[] > 0){
	^try{
# Хэш для записи в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$block_id]
			$.method[ToggleRelated]
		]
		^if(^int:sql{SELECT COUNT(related_id) FROM $self.catalogRelatedsTable.name WHERE element_id=$element_id AND related_id=$related_id} > 0){
			^void:sql{DELETE FROM $self.catalogRelatedsTable.name WHERE element_id=$element_id AND related_id=$related_id}
			$answer[
				$.error(false)
				$.text[Товар удалён]
			]
			$params.description[Удаление сопутствующего товара (id=$related_id) для товара (id=$element_id)]
		}{
			^void:sql{INSERT INTO $self.catalogRelatedsTable.name (element_id, related_id) VALUES ($element_id, $related_id)}
			$answer[
				$.error(false)
				$.text[Товар добавлен]
			]
			$params.description[Добавление сопутствующего товара (id=$related_id) для товара (id=$element_id)]
		}
# Делаем запись в лог
		$res[^cms:InsertIntoLog[$params]]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[В процессе выполнения произошла ошибка]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@RemoveAllRelateds[element_id]
^if(^element_id.int(0) > 0){
	^try{
		^void:sql{DELETE FROM $self.catalogRelatedsTable.name WHERE element_id=$element_id}
		$answer[
			$.error(false)
			$.text[Товар удалён]
		]
# Делаем запись в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[RemoveAllRelateds]
			$.description[Удаление всех сопутствующих товаров]
		]
		$res[^cms:InsertIntoLog[$params]]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[В процессе выполнения произошла ошибка]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Не передан ID элемента]
	]
}
$result[$answer]
################################################################################
@RecalcPartsPrices[params]
^if(def $params.elements || def $params.ids){
	^if(!def $params.elements){$params.elements[^table::sql{SELECT id, parts FROM $self.catalogTable.name WHERE id IN ($params.ids)}]}
	^if(def $params.elements){
		$rAnswer[
			$.prices[^hash::create[]]
		]
		^params.elements.menu{
			$rAnswer.prices.[$params.elements.id](0)
			$str[]
			$parts[^self.ParseParts[$params.elements.parts]]
			$subElements[^self.GetElements[$.element_ids[$parts.ids]]]
			^if(def $subElements){
				^subElements.menu{
					$rAnswer.prices.[$params.elements.id](^eval($rAnswer.prices.[$params.elements.id]+$subElements.price*$parts.[$subElements.id]))
				}
			}
			$rAnswer.prices.[$params.elements.id](^math:round($rAnswer.prices.[$params.elements.id]))
			$res[^self.SaveElementProperty[$params.elements.id;price;$rAnswer.prices.[$params.elements.id]]]
		}
		^if(^rAnswer.prices.count[]==1){
			$rAnswer.price($rAnswer.prices.[$params.ids])
			$rAnswer.text[Цена изменена]
		}{
			$rAnswer.text[Цены изменены]
		}
		$rAnswer.error(false)
# Делаем запись в лог
		$params[
			$.unit_id[$params.ids]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[RecalcPartsPrices]
			$.description[Пересчёт цен для частей элементов]
		]
		$res[^cms:InsertIntoLog[$params]]
	}{
		$rAnswer[
			$.error(true)
			$.text[Элементы не найдены]
		]
	}
}{
	$rAnswer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$rAnswer]
################################################################################
@SaveElementText[element_id;position;value]
^if(def $element_id && def $position && def $value){
	$element[^table::sql{SELECT id FROM $self.catalogTable.name WHERE id=$element_id}]
	^if(def $element){
		^if(^int:sql{SELECT COUNT(id) FROM $self.catalogTextsTable.name WHERE element_id=$element_id}){
			^void:sql{UPDATE $self.catalogTextsTable.name SET ${position}_text='$form:value' WHERE element_id=$element_id}
		}{
			^void:sql{INSERT INTO $self.catalogTextsTable.name (element_id, ${position}_text) VALUES ($element_id, '$value')}
		}
		$answer[
			$.error(false)
			$.text[^if($position eq top){Верхний}{Нижний} текст сохранён]
		]
# Делаем запись в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[SaveElementText]
			$.description[Сохранение ^if($position eq top){верхнего}{нижнего} текста]
		]
		$res[^cms:InsertIntoLog[$params]]
	}{
		$res[^void:sql{DELETE FROM $self.catalogTextsTable.name WHERE element_id=$element_id}]
		$answer[
			$.error(true)
			$.text[Элемент не найден]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@InsertExpandField[params]
^if(def $params.field && def $params.title){
	$fieldName[^cms:Translit[$params.field;$.filename(1)]]
	^if(!def $params.type_id){$params.type_id(1)}
	$isUnique(true)
	$table_info[^table::sql{SHOW COLUMNS FROM $self.catalogTable.name}]
	^table_info.menu{
		^if($table_info.Field eq $fieldName){
			$isUnique(false)
			^break[]
		}
	}
	^if($isUnique){
		^try{
			$res[^void:sql{INSERT INTO $self.catalogExpandFieldsTable.name (field, title, type_id) VALUES ("$fieldName", "$params.title", $params.type_id)}]
			$res[^void:sql{ALTER TABLE $self.catalogTable.name ADD `${fieldName}` ${cms:MySQLfieldTypes.[$params.type_id].type}(${cms:MySQLfieldTypes.[$params.type_id].size})^if(def $cms:MySQLfieldTypes.[$params.type_id].attribute){ $cms:MySQLfieldTypes.[$params.type_id].attribute} $cms:MySQLfieldTypes.[$params.type_id].null}]
#			$res[^void:sql{INSERT INTO $self.catalogTable.name ($fields, url) VALUES ($values, "^cms:GetImageName[$self.catalogTable.name;^cms:ConvertUrl[^cms:Translit[^params.name.replace[ ;-];$.filename(1)]];;;url]")}]
# Делаем запись в лог
			$params[
				$.module[$self.className]
				$.method[InsertExpandField]
				$.description[Создание дополнительного поля каталога]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer[
				$.error(false)
				$.text[Поле создано]
			]
		}{
			$exception.handled(true)
			$answer[
				$.error(true)
				$.text[Поле не создано]
			]
		}
	}{
		$answer[
			$.error(true)
			$.text[Поле не уникально]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@DeleteExpandField[field]
^if(def $field){
	^try{
		$res[^void:sql{DELETE FROM $self.catalogExpandFieldsTable.name WHERE field="$field"}]
		$res[^void:sql{ALTER TABLE $self.catalogTable.name DROP COLUMN $field}]
# Делаем запись в лог
		$params[
			$.unit_id[$field]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[DeleteExpandField]
			$.description[Удаление доп. поля каталога]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer[
			$.error(false)
			$.text[Поле удалено]
		]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[Ошибка удаления поля]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Не передано имя доп. поля]
	]
}
$result[$answer]
################################################################################
@SaveElementStep[element_id;value;params]
^try{
	$element_id(^element_id.int(0))
	^if($element_id>0){
		^if(!def $params){$params[^hash::create[]]}
		^if(!def $params.withChilds){$withChilds(true)}{$withChilds($params.withChilds)}
		^params.delete[withChilds]
		$params.element_ids($element_id)
		^if($withChilds){
			$elements[^self.GetElementsWithChilds[$params]]
		}{
			$elements[^self.GetElements[$params]]
		}
		$ids[]
		^elements.menu{
			$ids[${ids}, $elements.id]
		}
		^void:sql{UPDATE $self.catalogTable.name SET step='$value' WHERE id IN (^ids.trim[left;, ])}
# Делаем запись в лог
		$params[
			$.unit_id[$element_id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[SaveElementStep]
			$.description[Сохранение шага для элемента каталога с ID=${element_id}^if($withChilds){ и всех его потомков}]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer[
			$.error(false)
			$.text[Шаг для элемента каталога^if($withChilds){ и всех его потомков} сохранён]
		]
	}{
		$answer[
			$.error(true)
			$.text[Неизвестный ID элемента каталога]
		]
	}
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка сохранения шага для элемента каталога]
		$.exception[$exception]
	]
}
$result[$answer]
################################################################################
@DeleteBlock[blockId]
^try{
# Определяем id блока, который будем удалять
	^if(!def $blockId){$blockId($self.blockId)}
# Получаем список родительских элементов блока
	$elements[^self.GetElements[$.parent(0)]]
# Для каждого родительского элемента
	^elements.menu{
# Удаляем элемент (и всех его детей рекурсивно)
		$res[^self.DeleteElement[$elements.id]]
	}
# Удаляем настройки блока
	$res[^textext:DeleteOptions[$blockId]]
# Удаляем блок
	$res[^textext:Delete[$blockId]]
# Делаем запись в лог
	$params[
		$.unit_id[]
		$.module[$self.className]
		$.module_id[$blockId]
		$.method[DeleteBlock]
		$.description[Удаление блока каталога с ID=${blockId}]
	]
	$res[^cms:InsertIntoLog[$params]]
# Возвращаем результат
	$answer[
		$.error(false)
		$.text[Блок удалён]
	]
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка удаления блока каталога]
		$.exception[$exception]
	]
}
################################################################################
@LinkElement[elementIDs;parentID]
^if(def $elementIDs && def $parentID){
	^try{
		^if($elementIDs.CLASS_NAME eq hash){
			$stringIDs[]
			^elementIDs.foreach[key;value]{
				$stringIDs[${stringIDs},${value}]
			}
			$elementIDs[^stringIDs.trim[left;,]]
		}
		^void:sql{UPDATE $self.catalogTable.name SET parent=^parentID.int(0) WHERE id IN ($elementIDs)}
		$parent[^self.GetElements[$.element_id[^parentID.int(0)]]]
		$result[
			$.error(false)
			$.text[^if(def $parent){Привязка}{Отвязка} завершена]
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
@RedirectElement[elementIDs;redirectValue;params][params]
^if(!def $params){$params[^hash::create[]]}
^if(def $elementIDs){
	^try{
		^if($elementIDs.CLASS_NAME eq hash){
			$stringIDs[]
			^elementIDs.foreach[key;value]{
				$stringIDs[${stringIDs},${value}]
			}
			$elementsCount(^elementIDs.count[])
			$elementIDs[^stringIDs.trim[left;,]]
		}
		^if($params.withChilds){
			$allElements[^self.GetElementsWithChilds[$.element_ids[$elementIDs]]]
			$stringIDs[]
			^allElements.menu{
				$stringIDs[${stringIDs},${allElements.id}]
			}
			$elementsCount(^allElements.count[])
			$elementIDs[^stringIDs.trim[left;,]]
		}{
			^if(!def $elementsCount){
				$allElementIDs[^explode[,;$elementIDs]]
				$elementsCount(^allElementIDs.count[])
			}
		}
		^void:sql{UPDATE $self.catalogTable.name SET redirect='$redirectValue' WHERE id IN ($elementIDs)}
		$result[
			$.error(false)
			$.elementsCount($elementsCount)
			$.text[Редирект сохранён]
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
@SaveSizes[element_id;sizeIDs;params]
^try{
	^if(def $element_id && def $sizeIDs){
		$elementID(^element_id.int(0))
		^if($elementID>0){
			^void:sql{DELETE FROM $self.catalogSizesRelationsTable.name WHERE element_id=$elementID}
			^if($sizeIDs.CLASS_NAME ne hash){
				$sizeIDs[^explode[,;$sizeIDs]]
			}
			^sizeIDs.foreach[key;value]{
				^if(!def $params){$params[^hash::create[]]}
				$sizeID(^value.int(0))
				^if($sizeID>0){
					^if(^int:sql{SELECT COUNT(*) FROM $self.catalogSizesRelationsTable.name WHERE element_id=$elementID AND size_id=$sizeID}>0){
						$answer[
							$.error(false)
							$.text[Эта связь была сохранена ранее]
						]
					}{
						^void:sql{INSERT INTO $self.catalogSizesRelationsTable.name (element_id, size_id) VALUES ($elementID, $sizeID)}
						$answer[
							$.error(false)
							$.text[Связь сохранена]
						]
					}
				}{
					^if(^params.contains[deleteByZero]){
						^if($params.deleteByZero){
							^void:sql{DELETE FROM $self.catalogSizesRelationsTable.name WHERE element_id=$elementID}
							$answer[
								$.error(false)
								$.text[Связь удалена]
							]
						}{
							$answer[
								$.error(false)
								$.text[Действие проигнорировано]
							]
						}
					}{
						$answer[
							$.error(false)
							$.text[Действие проигнорировано]
						]
					}
				}
#		Делаем запись в лог
				$params[
					$.unit_id[$element_id]
					$.module[$self.className]
					$.module_id[$self.blockId]
					$.method[SaveSizes]
					$.description[Привязка размеров товара]
				]
				$res[^cms:InsertIntoLog[$params]]
				$result[$answer]
			}
		}{
			$result[
				$.error(true)
				$.text[Неизвестный элемент]
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
@SaveColors[element_id;colorIDs;params]
^try{
	^if(def $element_id && def $colorIDs){
		$elementID(^element_id.int(0))
		^if($elementID>0){
			^void:sql{DELETE FROM $self.catalogColorsRelationsTable.name WHERE element_id=$elementID}
			^if($colorIDs.CLASS_NAME ne hash){
				$colorIDs[^explode[,;$colorIDs]]
			}
			^colorIDs.foreach[key;value]{
				^if(!def $params){$params[^hash::create[]]}
				$colorID(^value.int(0))
				^if($colorID>0){
					^if(^int:sql{SELECT COUNT(*) FROM $self.catalogColorsRelationsTable.name WHERE element_id=$elementID AND color_id=$colorID}>0){
						$answer[
							$.error(false)
							$.text[Эта связь была сохранена ранее]
						]
					}{
						^void:sql{INSERT INTO $self.catalogColorsRelationsTable.name (element_id, color_id) VALUES ($elementID, $colorID)}
						$answer[
							$.error(false)
							$.text[Связь сохранена]
						]
					}
				}{
					^if(^params.contains[deleteByZero]){
						^if($params.deleteByZero){
							^void:sql{DELETE FROM $self.catalogColorsRelationsTable.name WHERE element_id=$elementID}
							$answer[
								$.error(false)
								$.text[Связь удалена]
							]
						}{
							$answer[
								$.error(false)
								$.text[Действие проигнорировано]
							]
						}
					}{
						$answer[
							$.error(false)
							$.text[Действие проигнорировано]
						]
					}
				}
#		Делаем запись в лог
				$params[
					$.unit_id[$element_id]
					$.module[$self.className]
					$.module_id[$self.blockId]
					$.method[SaveSizes]
					$.description[Привязка цветов товара]
				]
				$res[^cms:InsertIntoLog[$params]]
				$result[$answer]
			}
		}{
			$result[
				$.error(true)
				$.text[Неизвестный элемент]
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
@InsertSize[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.sortir){$params.sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.catalogSizesTable.name}+10))}
^if(!def $params.visible){$params.visible(1)}
^if(def $params.name){
	^try{
		$fields[]
		$values[]
		^params.foreach[key;value]{
			$fields[${fields},$key]
			$values[${values},'$value']
		}
		$res[^void:sql{INSERT INTO $self.catalogSizesTable.name (^fields.trim[left;,]) VALUES (^values.trim[left;,])}]
#	Делаем запись в лог
		$params[
			$.module[$self.className]
			$.method[InsertSize]
			$.description[Добавление размера]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Размер добавлен]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка добавления размера]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не указано название размера]
	]
}
################################################################################
@SetSizeVisible[id]
$id(^id.int(0))
^if($id>0){
	^try{
		$visible(^int:sql{SELECT visible FROM $self.catalogSizesTable.name WHERE id=$id})
		^if($visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.catalogSizesTable.name SET visible=$visible WHERE id=$id}]
		$result[
			$.error(false)
			$.text[^if($visible){Размер показан}{Размер скрыт}]
			$.visible($visible)
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка изменения видимости размера]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Неизвестный ID размера]
	]
}
################################################################################
@DeleteSize[id]
^try{
	$size_id(^int:sql{SELECT id FROM $self.catalogSizesTable.name WHERE id=$id}[$.default(0)])
	^if($size_id>0){
		$res[^void:sql{DELETE FROM $self.catalogSizesTable.name WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[DeleteSize]
			$.description[Удаление размера]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Размер удалён]
		]
	}{
		$result[
			$.error(true)
			$.text[Неизвестный ID размера]
		]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка удаления размера]
		$.exception[$exception]
	]
}
################################################################################
@SaveSizeProperty[id;name;value]
^if(def $id && def $name){
	^try{
		$res[^void:sql{UPDATE $self.catalogSizesTable.name SET $name='$value' WHERE id=$id}]
		$result[
			$.error(false)
			$.text[Значение сохранено]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка сохранения свойства размера]
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
@InsertColor[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.sortir){$params.sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.catalogColorsTable.name}+10))}
^if(!def $params.visible){$params.visible(1)}
^if(def $params.name){
	^try{
		$fields[]
		$values[]
		^params.foreach[key;value]{
			$fields[${fields},$key]
			$values[${values},'$value']
		}
		$res[^void:sql{INSERT INTO $self.catalogColorsTable.name (^fields.trim[left;,]) VALUES (^values.trim[left;,])}]
#	Делаем запись в лог
		$params[
			$.module[$self.className]
			$.method[InsertColor]
			$.description[Добавление цвета]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Цвет добавлен]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка добавления цвета]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не указано название цвета]
	]
}
################################################################################
@SetColorVisible[id]
$id(^id.int(0))
^if($id>0){
	^try{
		$visible(^int:sql{SELECT visible FROM $self.catalogColorsTable.name WHERE id=$id})
		^if($visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.catalogColorsTable.name SET visible=$visible WHERE id=$id}]
		$result[
			$.error(false)
			$.text[^if($visible){Цвет показан}{Цвет скрыт}]
			$.visible($visible)
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка изменения видимости цвета]
			$.exception[$exception]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Неизвестный ID цвета]
	]
}
################################################################################
@DeleteColor[id]
^try{
	$color_id(^int:sql{SELECT id FROM $self.catalogColorsTable.name WHERE id=$id}[$.default(0)])
	^if($color_id>0){
		$res[^void:sql{DELETE FROM $self.catalogColorsTable.name WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[DeleteColor]
			$.description[Удаление цвета]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Цвет удалён]
		]
	}{
		$result[
			$.error(true)
			$.text[Неизвестный ID цвета]
		]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка удаления цвета]
		$.exception[$exception]
	]
}
################################################################################
@SaveColorProperty[id;name;value]
^if(def $id && def $name){
	^try{
		$res[^void:sql{UPDATE $self.catalogColorsTable.name SET $name='$value' WHERE id=$id}]
		$result[
			$.error(false)
			$.text[Значение сохранено]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка сохранения свойства цвета]
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
@CreateSticker[params]
^if(!def $params){$params[^hash::create[]]}
^if(def $params.name && def $params.color_id){
	^try{
		^if(!def $params.sortir){$params.sortir(^int:sql{SELECT MAX(sortir) FROM $self.catalogStickersTable.name})}
		$fields[]
		$values[]
		^params.foreach[key;value]{
			$fields[${fields},$key]
			$values[${values},'$value']
		}
		$res[^void:sql{INSERT INTO $self.catalogStickersTable.name (^fields.trim[left;,]) VALUES (^values.trim[left;,])}]
# Делаем запись в лог
		$params[
			$.module[$self.className]
			$.method[CreateSticker]
			$.description[Добавление стикера]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Стикер добавлен]
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка добавления стикера]
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
@SaveStickerField[element_id;field;value]
^try{
	$sticker[^self.GetStickers[$.IDs($element_id)]]
	^if($sticker.CLASS_NAME ne table){
		$result[$sticker]
	}{
		^if(def $sticker){
			$res[^void:sql{UPDATE $self.catalogStickersTable.name SET $field='$value' WHERE id=$sticker.id}]
# Делаем запись в лог
			$params[
				$.module[$self.className]
				$.method[SaveStickerField]
				$.description[Сохранение значения "$value" поля "$field" стикера]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Значение сохранено]
			]
		}{
			$result[
				$.error(true)
				$.text[Неизвестный стикер]
			]
		}
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
@DeleteSticker[id]
^try{
	$sticker_id(^int:sql{SELECT id FROM $self.catalogStickersTable.name WHERE id=$id}[$.default(0)])
	^if($sticker_id>0){
		$res[^void:sql{DELETE FROM $self.catalogStickersTable.name WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[DeleteSticker]
			$.description[Удаление стикера]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Стикер удалён]
		]
	}{
		$result[
			$.error(true)
			$.text[Неизвестный ID стикера]
		]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка удаления стикера]
		$.exception[$exception]
	]
}
################################################################################
@SaveStickers[element_id;stickerIDs;params]
^try{
	^if(def $element_id && def $stickerIDs){
		$elementID(^element_id.int(0))
		^if($elementID>0){
			^void:sql{DELETE FROM $self.catalogStickersRelationsTable.name WHERE element_id=$elementID}
			^if($stickerIDs.CLASS_NAME ne hash){
				$stickerIDs[^explode[,;$stickerIDs]]
			}
			^stickerIDs.foreach[key;value]{
				^if(!def $params){$params[^hash::create[]]}
				$stickerID(^value.int(0))
				^if($stickerID>0){
					^if(^int:sql{SELECT COUNT(*) FROM $self.catalogStickersRelationsTable.name WHERE element_id=$elementID AND sticker_id=$stickerID}>0){
						$answer[
							$.error(false)
							$.text[Эта связь была сохранена ранее]
						]
					}{
						^void:sql{INSERT INTO $self.catalogStickersRelationsTable.name (element_id, sticker_id) VALUES ($elementID, $stickerID)}
						$answer[
							$.error(false)
							$.text[Связь сохранена]
						]
					}
				}{
					^if(^params.contains[deleteByZero]){
						^if($params.deleteByZero){
							^void:sql{DELETE FROM $self.catalogStickersRelationsTable.name WHERE element_id=$elementID}
							$answer[
								$.error(false)
								$.text[Связь удалена]
							]
						}{
							$answer[
								$.error(false)
								$.text[Действие проигнорировано]
							]
						}
					}{
						$answer[
							$.error(false)
							$.text[Действие проигнорировано]
						]
					}
				}
#		Делаем запись в лог
				$params[
					$.unit_id[$element_id]
					$.module[$self.className]
					$.module_id[$self.blockId]
					$.method[SaveStickers]
					$.description[Привязка стикеров товара]
				]
				$res[^cms:InsertIntoLog[$params]]
				$result[$answer]
			}
		}{
			$result[
				$.error(true)
				$.text[Неизвестный элемент]
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
@UpdateYML[params]
^if(!def $params){$params[^hash::create[]]}
^try{
#	Если это первая транзакция (формирование каталога)
	^if(!def $params.transaction_count){
#		Пересчитываем цены у тех элементов, которые состоят из частей
		$partsElements[^table::sql{SELECT id, parts FROM $self.catalogTable.name WHERE LENGTH(parts)>0}]
		$answer[^self.RecalcPartsPrices[$.elements[$partsElements]]]
#	Получаем правильный каталог (без потерянных элементов)
		$catalog[^self.GetElementsWithoutLost[^hash::create[$params]]]
#		Если каталог не пуст
		^if(def $catalog){
#			Определяем список ID элементов для выборки изображений
			$elementsIDs[]
			^catalog.foreach[key;value]{
				$elementsIDs[${elementsIDs},${value.id}]
			}
#			Получаем хэш с данными изображений
			$images[^catalog:GetMainImage[^elementsIDs.trim[,];$.resultType[hash]]]
#			Сохраняем хэш с данными изображений в файл
			$images[^json:string[$images]]
			^images.save[${self.tmpFolder}/images.json]
#			Сохраняем категории в файл
			$categories[^catalog.select($catalog.type==0)]
			$categories[^json:string[^categories.hash[id]]]
			^categories.save[${self.tmpFolder}/categories.json]
#			Сохраняем товары в файл
			$goods[^catalog.select($catalog.type==1)]
			$goods[^json:string[^goods.hash[id]]]
			^goods.save[${self.tmpFolder}/goods.json]
#			Возвращаем ответ
			$result[
				$.error(false)
				$.text[Начало синхронизации]
				$.last_transaction(false)
				$.counters[
					$.transaction_count(0)
				]
			]
		}{
			$result[
				$.error(false)
				$.text[Нет элементов для экспорта]
				$.last_transaction(true)
			]
		}
#	Если это не первая транзакция
	}{
		$settings[^self.GetYMLSettings[]]
		$settings[^settings.hash[name]]
#	Если это вторая транзакция (Подсчёт цен)
		^if($params.transaction_count==0){
		$goodsFile[^file::load[text;${self.tmpFolder}/goods.json]]
		$goods[^json:parse[^taint[as-is][$goodsFile.text]]]
#		Определяем цены
			$priceParams[$.element[$goods]]
			^if($settings.convert.value>0){
				$priceParams.convert(true)
				$priceParams.exchange[^exchange::create[]]
				$priceParams.toCurrency[$settings.currency.value]
			}
			^if($settings.cityPrice.value>0){
				$priceParams.cityPrice(true)
				$priceParams.cityID($settings.cityID.value)
				$priceParams.defaultCityID($settings.defaultCityID.value)
			}
			$prices[^json:string[^self.GetPrice[^hash::create[$priceParams]]]]
			^prices.save[${self.tmpFolder}/prices.json]
#			Возвращаем ответ
			$result[
				$.error(false)
				$.text[Цены посчитаны]
				$.last_transaction(false)
				$.counters[
					$.transaction_count(1)
				]
			]
#	Если это третья транзакция
		}{
			$categoriesFile[^file::load[text;${self.tmpFolder}/categories.json]]
			$categories[^json:parse[^taint[as-is][$categoriesFile.text]]]
			$goodsFile[^file::load[text;${self.tmpFolder}/goods.json]]
			$goods[^json:parse[^taint[as-is][$goodsFile.text]]]
			$imagesFile[^file::load[text;${self.tmpFolder}/images.json]]
			$images[^json:parse[^taint[as-is][$imagesFile.text]]]
			$pricesFile[^file::load[text;${self.tmpFolder}/prices.json]]
			$prices[^json:parse[^taint[as-is][$pricesFile.text]]]
			$orderBefore(^settings.orderBefore.value.int(0))
			$siteURL[${env:REQUEST_SCHEME}://${env:SERVER_NAME}]
#			Инициализируем шапку YML-документа
			$document[<?xml version="1.0" encoding="$request:charset"?>
<!DOCTYPE yml_catalog SYSTEM "shops.dtd">
<yml_catalog date="^site:currentDate.sql-string[date] ${site:currentDate.hour}:${site:currentDate.minute}">
	<shop>
		<name>^if(def $settings.name.value){$settings.name.value}{$site:name}</name>
		<company>^if(def $settings.company.value){$settings.company.value}{$site:name}</company>
		<url>${siteURL}/</url>
		<currencies>
			<currency id="$settings.currency.value" rate="1" plus="0"/>
		</currencies>^if($settings.delivery.value){^#0A		<delivery-options>
			<option cost="$settings.deliveryСost.value" days="$settings.days.value"^if($orderBefore>0){ order-before="$orderBefore"}/>
		</delivery-options>}
		<categories>
^categories.foreach[key;value]{			<category id="$key"^if($value.parent>0){ parentId="$value.parent"}>$value.name</category>^#0A}		</categories>
		<offers>^#0A]
#		Определяем товары, для которых нужно указывать мин. цену
		$allElements[^self.GetElements[^if(def $params.visible){$.visible($params.visible)}]]
		$minPrices[^hash::create[]]
		^goods.foreach[key;value]{
			^if($prices.[$key].price==0){
				$parents[^allElements.select($allElements.parent==$key)]
				^if(def $parents){
					$minPrice($prices.[$parents.id].price)
					^parents.menu{
						^if($prices.[$parents.id].price<$minPrice){$minPrice($prices.[$parents.id].price)}
					}
					^if($minPrice>0){$minPrices.[$key]($minPrice)}
				}
			}
		}
#		Пробегаем все товары
		^goods.foreach[key;value]{
#			Если товар, имеет дочерние товары с ценами
			^if($minPrices.[$key]>0){
				$categoryId($goods.[$value.parent].parent)
				$prices.[$key].price($minPrices.[$key])
			}{
				$categoryId($value.parent)
			}
#			Определяем текущее фото, так как для товаров в товарах берём фото родителя
			$currentImage[]
			^if(^images.contains[$key]){
				$currentImage[^hash::create[$images.[$key]]]
			}{
				^if(^images.contains[$value.parent]){
					$currentImage[^hash::create[$images.[$value.parent]]]
				}
			}
#			Выводим, если есть цена
			^if($prices.[$key].price>0){
				$document[$document			<offer id="$key" available="true">
				<name>$value.name</name>
				<url>${siteURL}^self.GetElementUrl[$.element[$value]$.page_id(^textext:GetPageIdByBlockId[$value.block_id])$.skip_main(true)]</url>
				<price^if($minPrices.[$key]>0){ from="true"}>$prices.[$key].price</price>
				<currencyId>$settings.currency.value</currencyId>
				<categoryId>$categoryId</categoryId>
				^if($currentImage.CLASS_NAME eq 'hash'){<picture>${siteURL}${self.imagesFolder.src}/$currentImage.name</picture>}
				<delivery>^if($settings.delivery.value){true}{false}</delivery>
				<pickup>^if($settings.pickup.value){true}{false}</pickup>
				<store>^if($settings.store.value){true}{false}</store>
				<description><!^[CDATA^[^CutString[$value.content;3000]^]^]></description>
				<sales_notes>$settings.salesNotes.value</sales_notes>
			</offer>^#0A]
			}
		}
		$document[$document		</offers>
	</shop>
</yml_catalog>]
#			Удаляем временные файлы
			^file:delete[${self.tmpFolder}/categories.json]
			^file:delete[${self.tmpFolder}/goods.json]
			^file:delete[${self.tmpFolder}/images.json]
			^file:delete[${self.tmpFolder}/prices.json]
#			Сохраняем результат
			^document.save[$settings.filePath.value]
			$result[
				$.error(false)
				$.text[Файл обновлён]
				$.last_transaction(true)
			]
		}
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения]
		$.last_transaction(true)
		$.exception[$exception]
	]
}
################################################################################
@GetYMLSettings[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[id]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$sql[
		SELECT *
		FROM $self.ymlSettingsTable.name
		WHERE 1=1
					^if(def $params.IDs){ AND id IN ($params.IDs)}
					^if(def $params.excludeIDs){ AND id NOT IN ($params.excludeIDs)}
		ORDER BY $params.order $params.orderType
	]
	^if($params.resultType eq hash){
		$result[^hash::sql{$sql}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
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
@SaveYMLSetting[setting;value]
^try{
	^if(def $setting){
		$res[^void:sql{UPDATE $self.ymlSettingsTable.name SET value='$value' WHERE name='$setting'}]
# Делаем запись в лог
		$params[
			$.unit_id[$responce.id]
			$.module[$self.className]
			$.module_id[$responce.block_id]
			$.method[SaveYMLSetting]
			$.description[Сохранение настройки "$setting" YML - файла]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Значение сохранено]
		]
	}{
		$result[
			$.error(true)
			$.text[Не указана настройка]
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