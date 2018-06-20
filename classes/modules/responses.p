################################################################################
@CLASS
responses
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[18.03.2014]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[responses]
$self.classDescription[Класс модуля отзывы]
$self.classModuleDescription[Отзывы]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.0 (18.03.2014):</u></strong>
  <ol>
   <li>Создан класс для модуля "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# Таблица отзывов
$self.responsesTable[
 $.name[responses]
 $.file[responses.table]
]
# Ширина изображений
$self.imagesWidth[
 $.small(80)
 $.big(300)
]
# Высота изображений
$self.imagesHeight[
 $.small(80)
 $.big(80)
]
# Пути к изображениям
$self.imagesPath[
 $.root[/images/${self.className}]
 $.small[/images/${self.className}/small]
 $.big[/images/${self.className}/big]
 $.src[/images/${self.className}/src]
]
# Название изображения по умолчанию
$self.noImage[$self.imagesPath.root/no-image.png]
# Путь к шаблону
$self.responsesFolder[/$self.className]
# Сортировка по умолчанию
$self.order[sortir]
# Тип сортировки по умолчанию
$self.orderType[DESC]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
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
@GetResponses[blockId;limitCount;offsetCount;order;orderType;all]
^if(!def $order){$order[$self.order]}
^if(!def $orderType){$orderType[$self.orderType]}
^if(!def $limitCount){$limitCount(-1)}
^if(!def $offsetCount){$offsetCount(0)}
$result[^table::sql{SELECT * FROM $self.responsesTable.name WHERE block_id=$blockId ^if(!def $all){AND visible=1 }ORDER BY $order $orderType}[$.limit($limitCount) $.offset($offsetCount)]]
################################################################################
@GetResponse[id]
$result[^table::sql{SELECT * FROM $self.responsesTable.name WHERE id=$id}]
################################################################################
@Insert[last_name;first_name;organisation;post;site;opinion;visible]
$site[^site.trim[left;http:]]
$site[^site.trim[left;/]]
$site[^site.trim[right;/]]
$site[^site.trim[left;www.]]
^if(!def $visible){$visible(1)}
$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.responsesTable.name WHERE block_id=$self.blockId}+10))
$result[^void:sql{INSERT INTO $self.responsesTable.name (block_id, first_name, last_name, organisation, post, site, opinion, sortir, visible) VALUES ($self.blockId, '$first_name', '$last_name', '$organisation', '$post', '$site', '$opinion', $sortir, $visible)}]
################################################################################
@Update[id;first_name;last_name;organisation;post;site;opinion]
$result[^void:sql{UPDATE $self.responsesTable.name SET first_name='$first_name', last_name='$last_name', organisation='$organisation', post='$post', site='$site', opinion='$opinion' WHERE id=$id}]
################################################################################
@Delete[id]
# Удаляем запись в таблице
$result[^void:sql{DELETE FROM $self.responsesTable.name WHERE id='$id'}]
# Удаляем изображения сотрудника
$imageExt[^site:GetImageExtention[${self.imagesPath.src}/;$id]]
^try{^file:delete[${self.imagesPath.small}/${id}.${imageExt}]}{$exception.handled(1)}
^try{^file:delete[${self.imagesPath.big}/${id}.${imageExt}]}{$exception.handled(1)}
^try{^file:delete[${self.imagesPath.src}/${id}.${imageExt}]}{$exception.handled(1)}
################################################################################
@ChangePosition[block_id;id;up]
$curentPosition(^int:sql{SELECT sortir FROM $self.responsesTable.name WHERE block_id=$block_id AND id=$id}[$.default(1000)])
^if(def $up){
 $changeId(^int:sql{SELECT id FROM $self.responsesTable.name WHERE block_id=$block_id AND sortir>$curentPosition ORDER BY sortir LIMIT 1}[$.default(1000)])
}{
 $changeId(^int:sql{SELECT id FROM $self.responsesTable.name WHERE block_id=$block_id AND sortir<$curentPosition ORDER BY sortir DESC LIMIT 1}[$.default(1000)])
}
$changePosition(^int:sql{SELECT sortir FROM $self.responsesTable.name WHERE block_id=$block_id AND id=$changeId}[$.default(1001)])
^void:sql{UPDATE $self.responsesTable.name SET sortir=$changePosition WHERE block_id=$block_id AND id=$id}
^void:sql{UPDATE $self.responsesTable.name SET sortir=$curentPosition WHERE block_id=$block_id AND id=$changeId}
################################################################################
@SaveImage[id;image]
$oImg[^NConvert::create[$.sScriptPath[/cgi-bin/]$.sScriptName[nconvert]]]
$imageExt[^file:justext[$image.name]]
$big[$self.imagesPath.big/${id}.${imageExt}]
$small[$self.imagesPath.small/${id}.${imageExt}]
$sbig[$self.imagesPath.src/${id}.${imageExt}]
^try{
 $res[^image.save[binary;$sbig]]
	$res[^cms:ImageResize[$sbig;$big;$self.imagesWidth.big;9999]]
	$res[^cms:ImageResize[$sbig;$small;$self.imagesWidth.small;9999]]
# $res[^file:delete[$sbig]]
}{
 $exception.handled(1)
 $result(-1)
}
$result(0)
################################################################################
@DelImage[id]
$imageExt[^site:GetImageExtention[${self.imagesPath.big}/;$id]]
$big[$self.imagesPath.big/${id}.${imageExt}]
$small[$self.imagesPath.small/${id}.${imageExt}]
$sbig[$self.imagesPath.src/${id}.${imageExt}]
^try{
 ^if(-f $big){$res[^file:delete[$big]]}
 ^if(-f $small){$res[^file:delete[$small]]}
 ^if(-f $sbig){$res[^file:delete[$sbig]]}
}{
 $exception.handled(1)
 $result(-1)
}
$result(0)
################################################################################
@UpdateImage[id;image]
^try{
 $imageExt[^site:GetImageExtention[${self.imagesPath.big}/;$id]]
 ^if($imageExt ne 'no'){^self.DelImage[$id]}
 ^if(def $image){^self.SaveImage[$id;$image]}
}{
 $exception.handled(1)
 $result(-1)
}
$result(0)
################################################################################
@Show[block_id]
# ^if(!def $block_id){$block_id[$self.blockId]}
$block_id[$self.blockId]
^if(-f "${site:templateFolder}${self.responsesFolder}/index.html"){
 ^try{
  ^use[${site:templateFolder}${self.responsesFolder}/index.html]
  ^ShowResponsesTemplate[$block_id]
 }{
  $exception.handled(1)
  <p>Ошибка в шаблоне</p>
  ^var_dump[$exception]
 }
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.responsesFolder/${tmpl}"</p>}
################################################################################
@ShowLastResponses[responsesPageId;count;tmpl;link]
^if(!def $tmpl){$tmpl[lastResponses.html]}
^if(-f "${site:templateFolder}${self.responsesFolder}/${tmpl}"){
 ^try{
  ^use[${site:templateFolder}$self.responsesFolder/${tmpl}]
  ^ShowLastResponsesTemplate[$responsesPageId;$count;$link]
 }{
  $exception.handled(0)
  <p>Ошибка в шаблоне</p>
 }
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.responsesFolder/${tmpl}"</p>}
################################################################################