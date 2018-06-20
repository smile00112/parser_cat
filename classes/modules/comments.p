################################################################################
@CLASS
comments
################################################################################
@create[blockId;params]
$self.blockId(^blockId.int(0))
$self.unitId(^params.unitId.int(0))
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[01.12.2015]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[comments]
$self.classDescription[Класс модуля "Комментарии"]
$self.classModuleDescription[Комментарии]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
			<ol>
				<li>Создан класс <strong>${self.className}.p</strong> ($self.classDescription) для работы с комментариями.</li>
			</ol>
	</p>
]
# Таблица "Комментарии"
$self.commentsTable[
	$.name[comments]
	$.file[comments.table]
]
$self.order[comment_date]
$self.orderType[ASC]
# Количество элементов на странице
$self.perPage(20)
# Путь к шаблонам
$self.commentsFolder[/comments]
$self.actionsPath[/modules/comments/actions.html]
$self.smilesFolder[/smiles]
$self.smilesTemplate[main]
$self.smiles[^table::load[${site:templateFolder}${self.smilesFolder}/${self.smilesTemplate}/db.tbl]]
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
@GetComments[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.block_id){$params.block_id($self.blockId)}{$params.block_id(^params.block_id.int(0))}
	^if(!def $params.unit_id){$params.unit_id($self.unitId)}{$params.unit_id(^params.unit_id.int(0))}
	^if(!def $params.order){$params.order[$self.order]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	$result[^table::sql{
		SELECT id, comment_date, block_id, unit_id, user_id, parent, guest_name, comment, visible
		FROM $self.commentsTable.name
		WHERE 1=1
			^if($params.block_id>0){AND block_id=$params.block_id}
			^if($params.unit_id>0){AND unit_id=$params.unit_id}
			^if(def $params.visible){ AND visible=$params.visible}
			ORDER BY $params.order $params.orderType
	}]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@AddComment[params]
^if(def $params.comment && def $params.guest_name && def $params.block_id && def $params.unit_id){
	^try{
		^if(!def $params.user_id){$params.user_id(0)}
		^if(!def $params.parent){$params.parent(0)}
		^if(!def $params.visible){$params.visible(1)}
		$now[^date::now[]]
		^void:sql{
			INSERT INTO $self.commentsTable.name
			(comment_date, block_id, unit_id, user_id, parent, guest_name, comment, visible)
			VALUES
			("^now.sql-string[]", $params.block_id, $params.unit_id, $params.user_id, $params.parent, "$params.guest_name", "$params.comment", $params.visible)
		}
		$answer[
			$.error(false)
			$.text[Комментарий добавлен]
			$.comment[^table::sql{
				SELECT id, comment_date, block_id, unit_id, user_id, parent, guest_name, comment, visible
				FROM $self.commentsTable.name
				WHERE comment_date="^now.sql-string[]"
					AND block_id=$params.block_id
					AND unit_id=$params.unit_id
					AND user_id=$params.user_id
					AND parent=$params.parent
					AND guest_name="$params.guest_name"
					AND comment="$params.comment"
					AND visible=$params.visible
			}]
		]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
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
@Show[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.blockId){$params.blockId($self.blockId)}
^if(!def $params.unitId){$params.unitId($self.unitId)}
^if(!def $params.visible){$params.visible(1)}
$comments[^self.GetComments[$params]]
^use[${site:templateFolder}${self.commentsFolder}/main.html]
^ShowCommentsTemplate[$comments;$self;$params]
################################################################################