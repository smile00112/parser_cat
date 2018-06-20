################################################################################
@CLASS
orders_cms
################################################################################
@USE
catalog.p
################################################################################
@BASE
catalog
################################################################################
@auto[]
$self.classVersion[1.00]
$self.classBuildDate[03.02.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[orders]
$self.classDescription[Класс модуля "Заказы"]
$self.classModuleDescription[Заказы]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс для работы с заказами сайта.</li>
		</ol>
	</p>
]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.orderTable.name]
		$.2[$self.orderArchiveTable.name]
	]
	$.superfluous[
	]
]
$self.moduleOptions[
	$.main[
	]
	$.rename[
	]
]
$self.perPage(100)
$self.statuses[
	$.r[
		$.name[Отправлен оператору]
		$.color[red]
	]
	$.i[
		$.name[Исполнен]
		$.color[green]
	]
	$.au[
		$.name[Аннулирован заказчиком]
		$.color[black]
	]
	$.as[
		$.name[Аннулирован исполнителем]
		$.color[black]
	]
	$.as[
		$.name[Аннулирован исполнителем]
		$.color[black]
	]
	$.o[
		$.name[Оплачен]
		$.color[red]
	]
	$.p[
		$.name[Подтверждён]
		$.color[blue]
	]
]
################################################################################
@create[]
################################################################################
@SaveOrderProperty[id;name;value]
^if(def $id && def $name){
	^try{
		^void:sql{UPDATE $self.orderTable.name SET $name='$value' WHERE id=$id}
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[SaveOrderProperty]
			$.description[Поле "$name" изменено]
		]
		$res[^cms:InsertIntoLog[$params]]
		$result[
			$.error(false)
			$.text[Значение сохранено]
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
		$.text[Переданы не все параметры]
	]
}
################################################################################