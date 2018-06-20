################################################################################
@CLASS
team
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[25.06.2014]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[team]
$self.classDescription[Класс модуля "Команда"]
$self.classModuleDescription[Команда]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.0 (18.03.2014):</u></strong>
  <ol>
   <li>Создан класс для модуля "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# Таблица Команда
$self.teamTable[
 $.name[team]
 $.file[team.table]
]
# Таблица Галерея Команды
$self.teamGalleryTable[
 $.name[team_gallery]
 $.file[team_gallery.table]
]
# Ширина изображений
$self.imagesWidth[
 $.small(50)
 $.big(300)
 $.gallery_small(130)
 $.gallery_big(800)
]
# Высота изображений
$self.imagesHeight[
 $.small(50)
 $.big(300)
 $.gallery_small(90)
 $.gallery_big(600)
]
# Пути к изображениям
$self.imagesPath[
 $.root[/images/${self.className}]
 $.small[/images/${self.className}/small]
 $.big[/images/${self.className}/big]
 $.src[/images/${self.className}/src]
]
# Пути к галерее изображений
$self.imagesGalleryPath[
 $.root[/images/${self.className}/gallery]
 $.small[/images/${self.className}/gallery/small]
 $.big[/images/${self.className}/gallery/big]
 $.src[/images/${self.className}/gallery/src]
]
# Название изображения по умолчанию
$self.noImage[$self.imagesPath.root/no-image.png]
# Путь к шаблону
$self.teamFolder[/$self.className]
# Сортировка по умолчанию
$self.order[sortir]
# Тип сортировки по умолчанию
$self.orderType[ASC]
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
@Insert[first_name;last_name;post;phrase;education;progress;training]
$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.teamTable.name WHERE block_id=$self.blockId}+10))
$result[^void:sql{INSERT INTO $self.teamTable.name (block_id, first_name, last_name, post, phrase, education, progress, training, sortir, visible) VALUES ($self.blockId, '$first_name', '$last_name', '$post', '$phrase', '$education', '$progress', '$training', $sortir, 1)}]
################################################################################
@Update[id;first_name;last_name;post;phrase;education;progress;training]
$result[^void:sql{UPDATE $self.teamTable.name SET first_name='$first_name', last_name='$last_name', post='$post', phrase='$phrase', education='$education', progress='$progress', training='$training' WHERE id=$id}]
################################################################################
@Delete[id]
# Удаляем запись в таблице
$result[^void:sql{DELETE FROM $self.teamTable.name WHERE id='$id'}]
# Удаляем изображения сотрудника
$imageExt[^site:GetImageExtention[${self.imagesPath.src}/;$id]]
^try{^file:delete[${self.imagesPath.small}/${id}.${imageExt}]}{$exception.handled(1)}
^try{^file:delete[${self.imagesPath.big}/${id}.${imageExt}]}{$exception.handled(1)}
^try{^file:delete[${self.imagesPath.src}/${id}.${imageExt}]}{$exception.handled(1)}
################################################################################
@GetEmployees[blockId;limitCount;offsetCount;order;orderType;all]
^if(!def $order){$order[$self.order]}
^if(!def $orderType){$orderType[$self.orderType]}
^if(!def $limitCount){$limitCount(-1)}
^if(!def $offsetCount){$offsetCount(0)}
$result[^table::sql{SELECT * FROM $self.teamTable.name WHERE block_id=$blockId ^if(!def $all){AND visible=1 }ORDER BY $order $orderType}[$.limit($limitCount) $.offset($offsetCount)]]
################################################################################
@GetEmployee[id]
$result[^table::sql{SELECT * FROM $self.teamTable.name WHERE id=$id}]
################################################################################
@GetEmployeeVisible[id]
$result(^int:sql{SELECT visible FROM $self.teamTable.name WHERE id=$id})
################################################################################
@ChangeEmployeePosition[block_id;id;up]
$curentPosition(^int:sql{SELECT sortir FROM $self.teamTable.name WHERE block_id=$block_id AND id=$id}[$.default(1000)])
^if(def $up){
 $changeId(^int:sql{SELECT id FROM $self.teamTable.name WHERE block_id=$block_id AND sortir<$curentPosition ORDER BY sortir DESC LIMIT 1}[$.default(1000)])
}{
 $changeId(^int:sql{SELECT id FROM $self.teamTable.name WHERE block_id=$block_id AND sortir>$curentPosition ORDER BY sortir LIMIT 1}[$.default(1000)])
}
$changePosition(^int:sql{SELECT sortir FROM $self.teamTable.name WHERE block_id=$block_id AND id=$changeId}[$.default(1001)])
$res[^void:sql{UPDATE $self.teamTable.name SET sortir=$changePosition WHERE block_id=$block_id AND id=$id}]
$res[^void:sql{UPDATE $self.teamTable.name SET sortir=$curentPosition WHERE block_id=$block_id AND id=$changeId}]
################################################################################
@SaveImage[id;image]
$oImg[^NConvert::create[$.sScriptPath[/cgi-bin/]$.sScriptName[nconvert]]]
$imageExt[^file:justext[$image.name]]
$big[$self.imagesPath.big/${id}.${imageExt}]
$small[$self.imagesPath.small/${id}.${imageExt}]
$sbig[$self.imagesPath.src/${id}.${imageExt}]
^try{
 $res[^image.save[binary;$sbig]]
 $res[^oImg.imageresize_into[$sbig;$big;$self.imagesWidth.big;9999]]
 $res[^oImg.imageresize_into[$sbig;$small;$self.imagesWidth.small;9999]]
# $res[^file:delete[$sbig]]
}{
 $exception.handled(true)
 $result(-1)
}
$result(0)
################################################################################
@SaveGalleryImage[id;image;description]
$oImg[^NConvert::create[$.sScriptPath[/cgi-bin/]$.sScriptName[nconvert]]]
$imageName[^self.GetImageName[$self.teamGalleryTable.name;^self.Translit[$image.name;$.filename(1)]]]
$big[$self.imagesGalleryPath.big/$imageName]
$small[$self.imagesGalleryPath.small/$imageName]
$sbig[$self.imagesGalleryPath.src/$imageName]
^try{
	$res[^image.save[binary;$sbig]]
	$res[^oImg.imageresize_into[$sbig;$big;$self.imagesWidth.gallery_big;9999]]
	$res[^oImg.imageresize_into[$sbig;$small;$self.imagesWidth.gallery_small;9999]]
	$res[^file:delete[$sbig]]
# Получаем последнюю сортировку
	$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.teamGalleryTable.name WHERE employee_id=$id}+10))
# Добавляем в галерею инфу о фотке
	^void:sql{INSERT INTO $self.teamGalleryTable.name (employee_id, name, description, visible, sortir) VALUES ($id, '$imageName', '$description', 1, $sortir)}
	$result(1)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@DelGalleryImage[id]
$imageName[^string:sql{SELECT name FROM $self.teamGalleryTable.name WHERE id=$id}]
^try{
	$big[$self.imagesGalleryPath.big/$imageName]
	$small[$self.imagesGalleryPath.small/$imageName]
	$sbig[$self.imagesGalleryPath.src/$imageName]
	^if(-f $big){$res[^file:delete[$big]]}
	^if(-f $small){$res[^file:delete[$small]]}
	^if(-f $sbig){$res[^file:delete[$sbig]]}
	^void:sql{DELETE FROM $self.teamGalleryTable.name WHERE id=$id}
	$result(1)
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@SaveGalleryImageProperty[id;property;value]
^try{
	^void:sql{UPDATE $self.teamGalleryTable.name SET $property='$value' WHERE id=$id}
	$result(1)
}{
	$exception.handled(true)
	$result(-1)
}
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
 $exception.handled(true)
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
 $exception.handled(true)
 $result(-1)
}
$result(0)
################################################################################
@Show[block_id]
^if(!def $block_id){$block_id[$self.blockId]}
^if(-f "${site:templateFolder}${self.teamFolder}/index.html"){
 ^try{
  ^use[${site:templateFolder}${self.teamFolder}/index.html]
  ^ShowTeamTemplate[$block_id]
 }{
  ^site:Catch[$exception;<h1>Ошибка в шаблоне Команда!</h1>]
 }
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.teamFolder/${tmpl}"</p>}
################################################################################
@ShowWidget[idpage;tmpl]
^if(!def $tmpl){$tmpl[widget.html]}
^if(-f "${site:templateFolder}${self.teamFolder}/${tmpl}"){
 ^try{
  ^use[${site:templateFolder}$self.teamFolder/${tmpl}]
  ^ShowWidgetTemplate[^textext:GetBlockIdByPageId[$idpage]]
 }{
  ^site:Catch[$exception;<h1>Ошибка в шаблоне Команда!</h1>]
 }
}{<p>Невозможно найти шаблон "${site:templateFolder}${self.teamFolder}/${tmpl}"</p>}
################################################################################
@GetEmployeeImages[employeeId;limitCount;offsetCount;order;orderType;all]
^if(!def $order){$order[$self.order]}
^if(!def $orderType){$orderType[$self.orderType]}
^if(!def $limitCount){$limitCount(-1)}
^if(!def $offsetCount){$offsetCount(0)}
$result[^table::sql{SELECT * FROM $self.teamGalleryTable.name WHERE employee_id=$employeeId ^if(!def $all){AND visible=1 }ORDER BY $order $orderType}[$.limit($limitCount) $.offset($offsetCount)]]
################################################################################
@GetEmployeeImagesCount[employeeId]
$result(^int:sql{SELECT COUNT(id) FROM $self.teamGalleryTable.name WHERE employee_id=$employeeId})
################################################################################
@GetEmployeeImage[id]
$result[^table::sql{SELECT * FROM $self.teamGalleryTable.name WHERE id=$id}]
################################################################################
@GetImageName[tableName;imageName;imageNameFirst;number;field]
^if(!def $imageNameFirst){
	$imageNameFirst[$imageName]
	$number(0)
}
^if(!def $field){$field[name]}
$copies(^int:sql{SELECT COUNT(id) FROM $tableName WHERE ${field}="$imageName"})
^if($copies>0){
	$number(^eval($number+1))
	$imageName[^self.GetImageName[$tableName;${number}_${imageNameFirst};$imageNameFirst;$number;$field]]
}
$result[$imageName]
################################################################################
@Translit[text;params]
^if($params.filename==1){
$parse[^table::create{from	to
а	a
б	b
в	v
г	g
д	d
е	e
ё	e
ж	zh
з	z
и	i
й	i
к	k
л	l
м	m
н	n
о	o
п	p
р	r
с	s
т	t
у	u
ф	f
х	h
ц	c
ч	ch
ш	sh
щ	sch
ъ	'
ь	'
ы	i
э	e
ю	u
я	ya
А	A
Б	B
В	V
Г	G
Д	D
Е	E
Ё	E
Ж	ZH
З	Z
И	I
Й	I
К	K
Л	L
М	M
Н	N
О	O
П	P
Р	R
С	S
Т	T
У	U
Ф	F
Х	H
Ц	C
Ч	CH
Ш	SH
Щ	SCH
Ъ	'
Ь	'
Ы	I
Э	E
Ю	U
Я	YA
©	_
«	_
»	_
!	_
,	_
%	_
#01	_
#02	_
#03	_
#04	_
#05	_
#06	_
#07	_
#08	_
#09	_
#0a	_
#0b	_
#0c	_
#0d	_
#0e	_
#0f	_
#10	_
#11	_
#12	_
#13	_
#14	_
#15	_
#16	_
#17	_
#18	_
#19	_
#1a	_
#1b	_
#1c	_
#1d	_
#1e	_
#1f	_
#20	_
^"	_
 	_
}]
}{
$parse[^table::create{from	to
а	a
б	b
в	v
г	g
д	d
е	e
ё	e
ж	zh
з	z
и	i
й	i
к	k
л	l
м	m
н	n
о	o
п	p
р	r
с	s
т	t
у	u
ф	f
х	h
ц	c
ч	ch
ш	sh
щ	sch
ъ	'
ь	'
ы	i
э	e
ю	u
я	ya
А	A
Б	B
В	V
Г	G
Д	D
Е	E
Ё	E
Ж	ZH
З	Z
И	I
Й	I
К	K
Л	L
М	M
Н	N
О	O
П	P
Р	R
С	S
Т	T
У	U
Ф	F
Х	H
Ц	C
Ч	CH
Ш	SH
Щ	SCH
Ъ	'
Ь	'
Ы	I
Э	E
Ю	U
Я	YA
©	_
«	_
»	_
!	_
,	_
.	_
%	_
#01	_
#02	_
#03	_
#04	_
#05	_
#06	_
#07	_
#08	_
#09	_
#0a	_
#0b	_
#0c	_
#0d	_
#0e	_
#0f	_
#10	_
#11	_
#12	_
#13	_
#14	_
#15	_
#16	_
#17	_
#18	_
#19	_
#1a	_
#1b	_
#1c	_
#1d	_
#1e	_
#1f	_
#20	_
^"	_
 	_
}]
}
$result[^text.replace[$parse]]
################################################################################