################################################################################
@CLASS
widgets
################################################################################
@auto[]
$self.classVersion[1.2]
$self.classBuildDate[02.03.2015]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[widgets]
$self.classDescription[Класс модуля настройки виджетов]
$self.classModuleDescription[Настройки виджетов]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия 1.1 (17.02.2014):</u></strong>
		<ol>
			<li>Изменена структура таблиц (осталось 2 вместо 3-х)</li>
			<li>Добавлены функции добавления и удаления виджетов</li>
			<li>Удалена функция <font color="red">^@GetWidgetsFolder</font>[]</li>
			<li>Удалена функция <font color="red">^@GetWidgetName</font>[id]</li>
			<li>Удалена функция <font color="red">^@GetWidgetLink</font>[id]</li>
			<li>Удалена функция <font color="red">^@GetWidgetLinkByName</font>[name]</li>
			<li>Удалена функция <font color="red">^@GetWidgetValue</font>[id^;value]</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (17.02.2014):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetWidgetsFolder</font>[], которая возвращает путь к виджетам.</li>
			<li>Добавлена функция <font color="red">^@GetWidgetValue</font>[id^;value], которая возвращает значение соответствующей переменной виджета.</li>
			<li>Добавлена функция <font color="red">^@GetWidgetLink</font>[name], которая возвращает все ссылки на виджеты с именем ^$name.</li>
			<li>Добавлена функция <font color="red">^@UpdateProperty</font>[id^;name^;value], которая сохраняет значение ^$value параметра ^$name виджета.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (06.01.2014):</u></strong>
		<ol>
			<li>Создан класс для модуля "Настройки виджетов"</li>
		</ol>
</p>
]
#----------------------------- Рабочие переменные ------------------------------
$self.widgetsTable[
 $.name[widgets]
 $.file[widgets.table]
]
$self.widgetTypesTable[
 $.name[widget_types]
 $.file[widgetTypes.table]
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
@GetWidgets[]
$result[^table::sql{
	SELECT w.id, w.name, w.caption, w.type_id, w.value_1, w.value_2, w.value_3, w.value_4, t.name AS type_name, t.caption AS type_caption
	FROM $self.widgetsTable.name AS w
	LEFT JOIN $self.widgetTypesTable.name AS t ON t.id=w.type_id
	ORDER BY w.caption
}]
################################################################################
@GetWidgetTypes[]
$result[^table::sql{SELECT id, name, caption, value FROM $self.widgetTypesTable.name ORDER BY caption}]
################################################################################
@UpdateProperty[id;name;value]
$result(^void:sql{UPDATE $self.widgetsTable.name SET $name="$value" WHERE id=$id})
################################################################################
@ShowWidget[name]
^try{
# Получаем параметры виджета
	$params[^table::sql{
		SELECT w.value_1, w.value_2, w.value_3, w.value_4, t.value
		FROM $self.widgetsTable.name w
		LEFT JOIN $self.widgetTypesTable.name AS t ON t.id=w.type_id
		WHERE w.name="$name"
	}]
	$value[$params.value]
# Создаём таблицу подстановок параметров виджета
	$rep[^table::create{from	to
value_1	$params.value_1
value_2	$params.value_2
value_3	$params.value_3
value_4	$params.value_4}]
# Подставляем в функцию параметры
	$value[^value.replace[$rep]]
# Выводим виджет
	$result[^process[$caller.self]{^taint[as-is][$value]}]
}{
	$exception.handled(true)
	$result[<h1>Ошибка загрузки виджета!</h1>^var_dump[$exception]]
}
################################################################################
@CreateWidget[params]
^try{
	$res[^void:sql{INSERT INTO $self.widgetsTable.name (caption, type_id, value_1, value_2, value_3, value_4) VALUES ("$params.caption", $params.type_id, "$params.value_1", "$params.value_2", "$params.value_3", "$params.value_4")}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteWidget[id]
^try{
	$res[^void:sql{DELETE FROM $self.widgetsTable.name WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################