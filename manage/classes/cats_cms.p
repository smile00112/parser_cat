################################################################################
@CLASS
cats_cms
################################################################################
@USE
cats_cms.p
################################################################################
@BASE
cat
################################################################################
@auto[]
$self.classVersion[1.00]
$self.classBuildDate[19.06.2018]
$self.classDeveloper[...]
$self.className[cats]
$self.classDescription[Класс управления котами]
$self.classModuleDescription[Список котов]
$self.classHistory[
	$.1_00[
		$.version(1.00)
		$.date[19.06.2018]
		$.changes[
			$.1[Создан класс управления котами]
		]
	]
]
# Пол кошек
$self.sex[
	$.male[Мальчик]
	$.female[Девочка]

]
# Статус кошек
$self.status[
	$.1[Свободен]
	$.2[Занят]

]
#Все самцы
	$sql[
		SELECT id, name, sex
		FROM $self.cats_list_table.name
		WHERE sex = 'male'
		ORDER BY name
	]

	$self.male_cats[^table::sql{$sql}]

#Все самки
	$sql[
		SELECT id, name, sex
		FROM $self.cats_list_table.name
		WHERE sex = 'female'
		ORDER BY name
	]

	$self.female_cats[^table::sql{$sql}]

################################################################################
@GetClassInfo[]
^use[${cms:templateFolder}/prepare_history.html]
$result[
	$.version[$self.classVersion]
	$.build_date[$self.classBuildDate]
	$.developer[$self.classDeveloper]
	$.module_name[$self.className]
	$.module_description[$self.classModuleDescription]
	$.history[^PrepareHistory[$self.classHistory]]
]
################################################################################
@create[blockId]
################################################################################
@SaveField[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		$res[^void:sql{UPDATE $self.cats_list_table.name SET $name='$value' WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[SaveProperty]
			$.description[Поле "$name" изменено]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.text[Значение сохранено]
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
@RenameField[oldName;newName;tableName]
^try{
	^if(!def $tableName){$tableName[$self.accountsTable.name]}
	$columns[^site:GetTableColumns[$tableName]]
	$fieldOptions[^columns.select($columns.Field eq '$oldName')]
	^if(def $fieldOptions){
		^if(^columns.locate[Field;$newName]){
			$result[
				$.error(true)
				$.text[Это имя уже используется!]
			]
		}{
			^void:sql{ALTER TABLE $tableName CHANGE COLUMN $oldName $newName $fieldOptions.Type^if($fieldOptions.Null eq 'YES'){ NULL}{ NOT NULL}^if(def $fieldOptions.Default){ DEFAULT $fieldOptions.Default}}
# Делаем запись в лог
			$params[
				$.unit_id[$newName]
				$.module[$self.className]
				$.module_id[]
				$.method[RenameField]
				$.description[Поле "$oldName" изменено]
			]
			$res[^cms:InsertIntoLog[$params]]
			$result[
				$.error(false)
				$.text[Имя сохранено]
			]
		}
	}{
		$result[
			$.error(true)
			$.text[Эта переменная не найдена]
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
@UpdateOptionValue[id;value]
^try{
	^void:sql{UPDATE $self.optionsTable.name SET value='$value' WHERE id=$id}
# Делаем запись в лог
	$params[
		$.unit_id[$id]
		$.module[$self.className]
		$.module_id[]
		$.method[UpdateOptionValue]
		$.description[Сохранение настройки "$field"]
	]
	$res[^cms:InsertIntoLog[$params]]
	$result[
		$.error(false)
		$.text[Настройка сохранена]
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