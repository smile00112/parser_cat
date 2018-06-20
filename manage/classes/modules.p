################################################################################
@CLASS
modules
################################################################################
@auto[]
#---------------------------- Информация о классе ------------------------------
$self.className[modules]
$self.classVersion(2.01)
$self.classBuildDate[16.02.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.classDescription[Класс модуля 'Управление модулями сайта']
$self.classModuleDescription[Управление модулями сайта]
$self.classHistory[
<p align="justify">
	<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
	<ol>
		<li>Доработана функция <font color="red">^@GetModules</font>[params]. Увеличено кол-во обрабатываемых параметров (гибкость функции).</li>
		<li>Переименованы поля таблицы блоков.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.0 (26.12.2016):</u></strong>
	<ol>
		<li>Модуль переделан в соответствии с новой структурой "$cms:cmsName"</li>
		<li>Добавлена переменная <font color="red">^$self.moduleTypes</font>, содержащая описание типов модулей сайта.</li>
		<li>Перенесена функция <font color="red">^@GetModules</font>[] из модуля <font color="red">system.p</font>
		<li>В функцию <font color="red">^@GetModules</font>[params] добавлен параметр <strong>params</strong>, через который будут передаваться параметры для выборки модулей.</li>
	</ol>
</p>
]
# ----------------------------- Рабочие переменные -----------------------------
$self.moduleTypes[
	$.cmsModule[
		$.label[Модуль]
		$.description[Раздел $cms:cmsName]
		$.id(0)
		$.tab_caption[Модули сайта]
		$.tab_active(true)
	]
	$.pageBlock[
		$.label[Блок]
		$.description[Составная единица страницы сайта]
		$.id(1)
		$.tab_caption[Блоки страницы]
		$.tab_active(false)
	]
]
################################################################################
@create[]
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
@GetModules[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[type, sortir]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$sql[
		SELECT *
		FROM $cms:cmsBlocksTable.name
		WHERE 1=1
			^if(def $params.IDs){ AND id IN ($params.IDs)}
			^if(def $params.name){ AND name='$params.name'}
			^if(def $params.parent){ AND parent=$params.parent}
			^if(def $params.type){ AND type=$params.type}
			^if(def $params.level){ AND level IN ($params.level)}
			^if(def $params.levelEL){ AND level<=$params.levelEL}
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
@SaveModuleProperty[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		^switch[$name]{
			^case[sortir]{
				$blockType(^int:sql{SELECT type FROM $cms:cmsBlocksTable.name WHERE id=$id})
				^if(!^int:sql{SELECT 1 FROM $cms:cmsBlocksTable.name WHERE $name=$value AND type=$blockType}[$.default(0)]){
					^void:sql{UPDATE $cms:cmsBlocksTable.name SET $name='$value' WHERE id=$id}
				}{
					$answer.error(true)
					$answer.text[Это значение уже используется!]
				}
			}
			^case[parent]{
				$blockType(^int:sql{SELECT type FROM $cms:cmsBlocksTable.name WHERE id=$id})
				$prevElement[^table::sql{SELECT id, sortir FROM $cms:cmsBlocksTable.name WHERE sortir IN ( SELECT MAX(sortir) FROM $cms:cmsBlocksTable.name WHERE parent=$value AND type=$blockType ) AND parent=$value AND type=$blockType}]
				^if(!def $prevElement){
					$answer.prevId(0)
					$answer.prevSort(0)
				}{
					$answer.prevId($prevElement.id)
					$answer.prevSort($prevElement.sortir)
				}
				^if($answer.prevSort == 0){
					$nextElement[^table::sql{SELECT id, sortir FROM $cms:cmsBlocksTable.name WHERE sortir IN ( SELECT MIN(sortir) FROM $cms:cmsBlocksTable.name WHERE parent=$value AND type=$blockType ) AND parent=$value AND type=$blockType}]
					^if(!def $prevElement){
						$answer.nextId(0)
						$answer.nextSort(0)
					}{
						$answer.nextId($nextElement.id)
						$answer.nextSort($nextElement.sortir)
					}
				}
				$answer.sort(^eval($answer.prevSort+10))
				$res[^void:sql{UPDATE $cms:cmsBlocksTable.name SET $name='$value', sortir='$answer.sort' WHERE id=$id}]
			}
			^case[DEFAULT]{
				$res[^void:sql{UPDATE $cms:cmsBlocksTable.name SET $name='$value' WHERE id=$id}]
			}
		}
		^if(!$answer.error){
# Делаем запись в лог
			$params[
				$.unit_id[$id]
				$.module[$self.className]
				$.module_id[]
				$.method[SaveModuleProperty]
				$.description[Поле "$name" изменено]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.text[Значение сохранено]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
		$answer.exception[$exception]
	}
}{
	$answer.error(true)
	$answer.text[Переданы не все параметры]
}
$result[$answer]
################################################################################
@InsertModule[params]
$answer[^hash::create[]]
^try{
# Если передаются необходимые параметры
	^if(def $params.description && def $params.name && def $params.path){
		^if(!def $params.type){$params.type(0)}
		^if(!def $params.level){$params.level(0)}
		^if(!def $params.sortir || ^int:sql{SELECT 1 FROM $cms:cmsBlocksTable.name WHERE sortir=$params.sortir AND type=$params.type}[$.default(0)]){
			$params.sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $cms:cmsBlocksTable.name WHERE type=$params.type}+10))
		}
		$res[^void:sql{
			INSERT INTO $cms:cmsBlocksTable.name
				(description, name, path, sortir, type, level)
			VALUES
				("$params.description", "$params.name", "$params.path", $params.sortir, $params.type, $params.level)
		}]
# Делаем запись в лог
		$params[
			$.module[$self.className]
			$.module_id[]
			$.method[InsertModule]
			$.description[Добавление модуля]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.error(false)
		$answer.text[Модуль добавлен]
	}{
		$answer.error(true)
		$answer.text[Не хватает параметров]
	}
}{
	$exception.handled(true)
	$answer.error(true)
	$answer.text[Ошибка выполнения скрипта]
	$answer.exception[$exception]
}
$result[$answer]
################################################################################
@DeleteModule[module_id]
$answer[^hash::create[]]
^if(def $module_id){
	^try{
		$element[^self.GetModules[$.IDs($module_id)]]
		^void:sql{DELETE FROM $cms:cmsBlocksTable.name WHERE id=$module_id}
	# Делаем запись в лог
		$params[
			$.unit_id[$module_id]
			$.module[$self.className]
			$.module_id[]
			$.method[DeleteModule]
			$.description[Удаление ^if($element.type){модуля сайта}{блока страницы}]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.error(false)
		$answer.text[^if($element.type){Модуль сайта удалён}{Блок страницы удалён}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
		$answer.exception[$exception]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID модуля]
}
$result[$answer]
################################################################################