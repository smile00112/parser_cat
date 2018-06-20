################################################################################
@CLASS
votes
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[29.06.2015]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[votes]
$self.classDescription[Класс голосования]
$self.classModuleDescription[Голосование]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
  <ol>
   <li>Создан класс для модуля "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# Таблица с данными по голосованию
$self.votesTable[
 $.name[votes]
 $.file[votes.table]
]
# Таблица участников голосования
$self.votesParticipantsTable[
 $.name[votes_participants]
 $.file[votes_participants.table]
]
# Таблица изображений участников голосования
$self.votesImagesTable[
 $.name[votes_participants_images]
 $.file[votes_participants_images.table]
]
# Кол-во элементов на странице
$self.perPage(50)
# Путь к шаблону
$self.templatesFolder[/$self.className]
# Путь к папке с изображениями каталога
$self.imagesFolder[
	$.root[/images/$self.className]
	$.src[/images/${self.className}/src]
	$.big[/images/${self.className}/big]
	$.small[/images/${self.className}/small]
]
# Ширина изображений
$self.imagesWidth[
 $.small(110)
 $.big(800)
]
# Высота изображений
$self.imagesHeight[
 $.small(99999)
 $.big(99999)
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
$self.imagesWidth.small(^textext:GetOptionValue[small_images_width;$self.blockId;$self.imagesWidth.small])
$self.imagesHeight.small(^textext:GetOptionValue[small_images_height;$self.blockId;$self.imagesHeight.small])
$self.imagesWidth.big(^textext:GetOptionValue[big_images_width;$self.blockId;$self.imagesWidth.big])
$self.imagesHeight.big(^textext:GetOptionValue[big_images_height;$self.blockId;$self.imagesHeight.big])
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
@Show[block_id]
^if(!def $block_id){$block_id[$self.blockId]}
$template[index.html]
^if(-f "${site:templateFolder}${self.templatesFolder}/${template}"){
	^try{
		^if(!def $cpage){$cpage(1)}{$cpage($form:cpage)}
		^use[${site:templateFolder}${self.templatesFolder}/${template}]
		^ShowTemplate[$self;$cpage]
	}{
		$exception.handled(0)
		<p>Ошибка в шаблоне <strong>$template</strong></p>
	}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.templatesFolder/${template}"</p>}
################################################################################
@GetParticipants[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.blockId){$blockId($self.blockId)}{$blockId($params.blockId)}
^if(!def $params.order){$params.order[name, id]}
^if(!def $params.orderType){$params.orderType[ASC]}
^if(!def $params.limitCount){$params.limitCount(-1)}
^if(!def $params.offsetCount){$params.offsetCount(0)}
$result[^table::sql{
	SELECT v.id, v.name,
		(SELECT COUNT(id) FROM $self.votesTable.name WHERE participant_id=v.id) AS votes_count,
		(SELECT COUNT(id) FROM $self.votesTable.name) AS all_votes_count,
		(SELECT votes_count/all_votes_count) AS percent,
		(SELECT AVG(value) FROM $self.votesTable.name WHERE participant_id=v.id) AS votes_avg
	FROM $self.votesParticipantsTable.name AS v
	WHERE v.block_id = $blockId
	ORDER BY $params.order $params.orderType
}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
################################################################################
@GetAllParticipantsCount[blockId]
^if(!def $blockId){$blockId($self.blockId)}{$blockId($blockId)}
$result(^int:sql{SELECT COUNT(id) FROM $self.votesParticipantsTable.name WHERE block_id = $blockId})
################################################################################
@InsertParticipant[params]
^try{
	$res[^void:sql{
		INSERT INTO $self.votesParticipantsTable.name
			(block_id, name)
		VALUES
			($params.block_id, "$params.name")
	}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteParticipant[id]
^try{
	$res[^void:sql{DELETE FROM $self.votesParticipantsTable.name WHERE id=$id}]
	$res[^void:sql{DELETE FROM $self.votesTable.name WHERE participant_id=$id}]
	^self.DeleteMainImage[$id]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@SaveParticipantField[id;field;value]
^try{
	$res[^void:sql{UPDATE $self.votesParticipantsTable.name SET $field="$value" WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@GetMainParticipantImage[participant_id]
$result[^table::sql{SELECT id, name FROM $self.votesImagesTable.name WHERE participant_id=$participant_id AND main=1}]
################################################################################
@InsertImage[participant_id;imageName;main]
^if(!def $main){$main(0)}{$main(1)}
$sort(^int:sql{SELECT MAX(sortir) FROM $self.votesImagesTable.name WHERE participant_id=$participant_id})
$sort(^eval($sort+10))
$result[^void:sql{INSERT INTO $self.votesImagesTable.name (participant_id, name, main, sortir) VALUES ($participant_id, '$imageName', $main, '$sort')}]
################################################################################
@DeleteMainImage[participant_id]
^try{
	$fileName[^string:sql{SELECT name FROM $self.votesImagesTable.name WHERE participant_id=$participant_id AND main=1}[$.default[]]]
	^if($fileName ne ''){
		$res[^file:delete[${self.imagesFolder.src}/${participant_id}/${fileName};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.big}/${participant_id}/${fileName};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^file:delete[${self.imagesFolder.small}/${participant_id}/${fileName};$.keep-empty-dirs(true)$.exception(false)]]
		$res[^void:sql{DELETE FROM $self.votesImagesTable.name WHERE participant_id=$participant_id AND main=1}]
		$result(1)
	}{
		$result(0)
	}
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@isVote[params]
$result(^int:sql{SELECT COUNT(id) FROM $self.votesTable.name WHERE participant_id=$params.participant_id AND ip=INET_ATON("$params.ip")})
################################################################################
@vote[params]
^if(!def $params.user_id){$params.user_id(0)}
^if(! ^self.isVote[$params] ){
	$res[^void:sql{INSERT INTO $self.votesTable.name (user_id, participant_id, value, ip) VALUES ($params.user_id, $params.participant_id, $params.value, INET_ATON("$params.ip"))}]
	$result(1)
}{
	$result(0)
}
################################################################################
@SetDefaultBlockOptions[block_id]
^if(!def $block_id){$block_id($self.blockId)}
$result[^void:sql{
INSERT INTO $textext:pageBlockOptionsTable.name (id_te, named, name, value, type_field) VALUES
($block_id, 'Ширина малого изображения', 'small_images_width', '$self.imagesWidth.small', 0),
($block_id, 'Высота малого изображения', 'small_images_height', '$self.imagesHeight.small', 0),
($block_id, 'Ширина большого изображения', 'big_images_width', '$self.imagesWidth.big', 0),
($block_id, 'Высота большого изображения', 'big_images_height', '$self.imagesHeight.big', 0)
}]
################################################################################