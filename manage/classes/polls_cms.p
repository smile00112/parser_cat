################################################################################
@CLASS
polls_cms
################################################################################
@USE
polls.p
################################################################################
@BASE
polls
################################################################################
@auto[]
$self.modulePath[$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.pollsTable.name]
	]
	$.superfluous[
		$.1[]
	]
]
$self.moduleOptions[
	$.main[
	]
	$.rename[
	]
]
################################################################################
@create[]
################################################################################
# Создаёт новый элемент
@CreateElement[fields;params]
^try{
	^if(def $fields.name && def $fields.type){
		^if(def $fields.parent){$parent(^fields.parent.int(0))}{$parent(0)}
		$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.pollsTable.name WHERE parent=$parent}+10))
		$query_fields[sortir, create_date]
		$query_values[$sortir, NOW()]
		^fields.foreach[key;value]{
			^if($value ne ''){
				$query_fields[${query_fields}, $key]
				$query_values[${query_values}, '$value']
			}
		}
		^void:sql{INSERT INTO $self.pollsTable.name ($query_fields) VALUES ($query_values)}
	# Делаем запись в лог
			$params[
				$.unit_id[]
				$.module[$self.className]
				$.module_id[]
				$.method[CreateElement]
				$.description[Добавление ^self.elementTypes.[$fields.type].titleRE.lower[]]
			]
			$res[^cms:InsertIntoLog[$params]]
		$answer[^hash::create[
			$.error(false)
			$.text[$self.elementTypes.[$fields.type].title добавлен]
		]]
	}{
		$answer[^hash::create[
			$.error(true)
			$.text[Недостаточно параметров для создания ^self.elementTypes.[$fields.type].titleRE.lower[]]
		]]
	}
}{
	$exception.handled(true)
	$answer[^hash::create[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]]
}
$result[$answer]
################################################################################
@DeleteElement[element_id][element_id;element;childs]
$answer[^hash::create[]]
^if(def $element_id){
	^try{
		$element[^table::sql{SELECT name, type FROM $self.pollsTable.name WHERE id=$element_id}]
		^if(def $element){
			$childs[^table::sql{SELECT id FROM $self.pollsTable.name WHERE parent=$element_id}]
			^if(def $childs){
				^childs.menu{
					$res[^self.DeleteElement[$childs.id]]
				}
			}
			$res[^void:sql{DELETE FROM $self.pollsTable.name WHERE id=$element_id}]
# Делаем запись в лог
			$params[
				$.unit_id[$element_id]
				$.module[$self.className]
				$.module_id[]
				$.method[DeleteImage]
				$.description[Удаление ^self.elementTypes.[$element.type].titleRE.lower[]]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[^if($element.type == 1){Вопрос удалён}{^if(def $childs){Опрос и все его вопросы удалены}{Опрос удалён}}]
		}{
			$answer.error(true)
			$answer.text[Элемент с ID=$element_id не найден]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID элемента]
}
$result[$answer]
################################################################################
@SaveProperty[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		^switch[$name]{
			^case[sortir]{
				$parent[^string:sql{SELECT parent FROM $self.pollsTable.name WHERE id=$id}]
				^if(!^int:sql{SELECT 1 FROM $self.pollsTable.name WHERE $name=$value AND parent=$parent}[$.default(0)]){
					$res[^void:sql{UPDATE $self.pollsTable.name SET $name='$value' WHERE id=$id}]
				}{
					$answer.error(true)
					$answer.text[Это значение уже используется!]
				}
			}
			^case[DEFAULT]{
				$res[^void:sql{UPDATE $self.pollsTable.name SET $name='$value' WHERE id=$id}]
			}
		}
		^if(!$answer.error){
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
@SetElementVisible[id]
$answer[^hash::create[]]
^if(def $id){
	^try{
		$visible(^int:sql{SELECT visible FROM $self.pollsTable.name WHERE id=$id})
		^if($visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.pollsTable.name SET visible=$visible WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[SetImageVisible]
			$.description[^if($visible){Отображение}{ Скрытие} элемента]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.visible($visible)
		$answer.error(false)
		$answer.text[Элемент^if($visible){ отображён}{ скрыт}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID элемента]
}
$result[$answer]
################################################################################