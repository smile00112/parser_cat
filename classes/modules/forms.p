################################################################################
@CLASS
forms
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[18.02.2015]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[forms]
$self.classDescription[Форма обраной связи]
$self.classModuleDescription[Форма]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс ${self.className}.</li>
		</ol>
	</p>
]
#----------------------------- Рабочие переменные ------------------------------
# Таблица "Поля формы"
$self.fieldsTable[
	$.name[form_fields]
	$.file[form_fields.table]
]
# Таблица "Типы полей формы"
$self.fieldTypesTable[
	$.name[form_field_types]
	$.file[form_field_types.table]
]
# Путь к шаблону
$self.formsFolder[/$self.className]
################################################################################
@GetClassInfo[]
$result[
	$.className[$self.className]
	$.classVersion[$self.classVersion]
	$.version[$self.classVersion]
	$.classBuildDate[$self.classBuildDate]
	$.build_date[$self.classBuildDate]
	$.classDeveloper[$self.classDeveloper]
	$.classDescription[$self.classVersion]
	$.classHistory[$self.classVersion]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
################################################################################
@Show[template]
^if(!def $template){$template[index.html]}
^if(-f "${site:templateFolder}${self.formsFolder}/${template}"){
	^try{
		^use[${site:templateFolder}${self.formsFolder}/${template}]
		^ShowFormTemplate[^self.GetBlockFields[$self.blockId];$self.blockId]
	}{
		$exception.handled(true)
		<p>Ошибка в шаблоне <strong>$template</strong></p>
	}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.formsFolder/${template}"</p>}
################################################################################
@GetBlockFields[blockId]
^if(!def $blockId){$blockId($self.blockId)}
$result[^table::sql{
	SELECT
		f.id,
		f.name,
		f.label,
		f.type_id,
		t.name AS type_name,
		t.description AS type_description,
		f.default_value,
		f.required,
		f.mask,
		f.sortir
	FROM $self.fieldsTable.name AS f
	LEFT JOIN $self.fieldTypesTable.name AS t ON f.type_id = t.id
	WHERE f.block_id=$blockId ORDER BY sortir
}]
################################################################################
@GetFieldTypes[]
$result[^table::sql{SELECT id, name, description FROM $self.fieldTypesTable.name}]
################################################################################
@InsertField[values]
$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.fieldsTable.name WHERE block_id=$values.block_id}+10))
$result[^void:sql{INSERT INTO $self.fieldsTable.name (block_id, name, label, type_id, default_value, required, sortir) VALUES ($values.block_id, '$values.name', '$values.label', $values.type_id, '$values.default_value', $values.required, $sortir)}]
################################################################################
@SaveField[id;field;value]
^try{
	$res[^void:sql{UPDATE $self.fieldsTable.name SET $field="$value" WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteField[id]
^try{
	$res[^void:sql{DELETE FROM $self.fieldsTable.name WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@ChangeFieldPosition[id;up]
^try{
	$res[^table::sql{SELECT block_id, sortir FROM $self.fieldsTable.name WHERE id=$id}]
	^if(def $up){
		$changeId(^int:sql{SELECT id FROM $self.fieldsTable.name WHERE block_id=$res.block_id AND sortir<$res.sortir ORDER BY sortir DESC LIMIT 1}[$.default(1000)])
	}{
		$changeId(^int:sql{SELECT id FROM $self.fieldsTable.name WHERE block_id=$res.block_id AND sortir>$res.sortir ORDER BY sortir LIMIT 1}[$.default(1000)])
	}
	$changePosition(^int:sql{SELECT sortir FROM $self.fieldsTable.name WHERE block_id=$res.block_id AND id=$changeId}[$.default(1001)])
	^void:sql{UPDATE $self.fieldsTable.name SET sortir=$changePosition WHERE block_id=$res.block_id AND id=$id}
	^void:sql{UPDATE $self.fieldsTable.name SET sortir=$res.sortir WHERE block_id=$res.block_id AND id=$changeId}
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@AddBlockSettings[id]
^try{
	^if(def $id){$block_id($id)}{$block_id($self.blockId)}
	$params[
		$.block_id($block_id)
		$.caption[Почта]
		$.name[email]
		$.value[]
		$.type_field(0)
	]
	$res(^textext:InsertOption[$params])
	$params[
		$.block_id($block_id)
		$.caption[Тема письма]
		$.name[subject]
	]
	$res(^textext:InsertOption[$params])
	$params[
		$.block_id($block_id)
		$.caption[Шаблон]
		$.name[template]
	]
	$res(^textext:InsertOption[$params])
	$params[
		$.block_id($block_id)
		$.caption[От кого]
		$.name[from]
	]
	$res(^textext:InsertOption[$params])
	$result(1)
}{
	$exception.handled(false)
	$result(0)
}
################################################################################
@SendMail[block_id]
$answer[^hash::create[]]
^if(def $block_id){$blockId($block_id)}{$blockId($self.blockId)}
^use[textext.p]
$options[^textext:GetOptions[$blockId]]
^options.menu{
	^switch[$options.name]{
		^case[email]{			^if(!def $options.value){	$email[$site:email]}{$email[$options.value]}	}
		^case[subject]{   ^if(!def $options.value){	$subject[Форма обратной связи]}{$subject[$options.value]}	}
		^case[template]{	^if(!def $options.value){	$template[mail.html]}{$template[$options.value]}	}
		^case[from]{			^if(!def $options.value){	$from[postmaster]}{$from[$options.value]}	}
		^case[DEFAULT]{	}
	}
}
^if(-f "${site:templateFolder}${self.formsFolder}/${template}"){
	^try{
		^use[${site:templateFolder}${self.formsFolder}/${template}]
		^mail:send[
			$.from[$from]
			$.to[$email]
			$.charset[$response:charset]
			$.subject[$subject]
			$.text[^ShowTemplate[^self.GetBlockFields[$blockId]]]
		]
		$answer.result(true)
	}{
		$exception.handled(true)
		$answer.result(false)
		$answer.error[<p>Ошибка в шаблоне <strong>$template</strong></p>]
	}
}{$answer.error[<p>Невозможно найти шаблон "${site:templateFolder}$self.formsFolder/${template}"</p>]}
$result[$answer]
################################################################################