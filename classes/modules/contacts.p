################################################################################
@CLASS
contacts
################################################################################
@auto[]
$self.classVersion[1.3]
$self.classBuildDate[18.11.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[contacts]
$self.classDescription[Класс модуля "Контакты сайта"]
$self.classModuleDescription[Контакты сайта]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>В функцию <font color="red">^@GetCities</font>[params] добавлен параметр <strong>params</strong>, через который можно управлять запросом и автоматизирована её работа.</li>
			<li>В функцию <font color="red">^@GetCityContacts</font>[city_id^;params] добавлен параметр <strong>params</strong>, через который можно управлять запросом.</li>
			<li>Добавлена функция <font color="red">^@SaveCity</font>[cityID], сохраняющая новое значение текущего города в cookie.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.2 (14.07.2017):</u></strong>
		<ol>
			<li>В функции <font color="red">^@GetAllCityContacts</font>[city_id], при отсутствии параметра он инициализуется <strong>1</strong> (т.е. ID первого города).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (19.11.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetAllCityContacts</font>[city_id], возвращающая хэш с контактами (удобнее для вывода чем таблица).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (25.02.2015):</u></strong>
		<ol>
			<li>Создан класс для модуля "$self.classModuleDescription"</li>
		</ol>
	</p>
]
# Таблица "Контакты"
$self.contactsTable[
	$.name[contacts]
	$.file[contacts.table]
]
# Таблица "Города"
$self.contactsCitiesTable[
	$.name[contacts_cities]
	$.file[contacts_cities.table]
]
# Таблица "Типы данных"
$self.contactsDataTypesTable[
	$.name[contacts_data_types]
	$.file[contacts_data_types.table]
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
@GetCities[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[name]}
^if(!def $params.orderType){$params.orderType[ASC]}
^if(def $params.cityID){$params.cityID(^params.cityID.int(0))}{$params.cityID(0)}
^try{
	$result[^table::sql{
		SELECT *
		FROM $self.contactsCitiesTable.name
		WHERE 1=1
			^if($params.cityID>0){ AND id=$params.cityID}
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
@GetCityContacts[city_id;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[name]}
^if(!def $params.orderType){$params.orderType[ASC]}
$result[^table::sql{
	SELECT c.*, dt.name AS data_type, dt.variable
	FROM $self.contactsTable.name AS c
	LEFT JOIN $self.contactsDataTypesTable.name AS dt ON dt.id=c.data_type_id
	WHERE city_id=$city_id
	ORDER BY $params.order $params.orderType
}]
################################################################################
@GetAllCityContacts[city_id]
^if(^city_id.int(0)<1){$city_id(1)}
# Инициализируем хэш контактов
$contacts[^hash::create[]]
# Получаем все контакты для города
$allContacts[^self.GetCityContacts[$city_id]]
^allContacts.menu{
	^if(!^contacts.contains[$allContacts.variable]){
		$contacts.[$allContacts.variable][^hash::create[]]
	}
	$parts[^allContacts.name.split[_;rh]]
	$contacts.[$allContacts.variable].[$parts.0][$allContacts.value]
}
# Возвращаем результат
$result[$contacts]
################################################################################
@GetDataTypes[]
^try{
	$result[^table::sql{SELECT id, name, description FROM $self.contactsDataTypesTable.name ORDER BY id}]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@EditContact[id;field;value]
^try{
	$res[^void:sql{UPDATE $self.contactsTable.name SET $field="$value" WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@AddContact[values]
^try{
	$res[^void:sql{INSERT INTO $self.contactsTable.name (city_id, data_type_id, name, value) VALUES ($values.city_id, $values.data_type_id, "$values.name", "$values.value")}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@DeleteContact[id]
^try{
	$res[^void:sql{DELETE FROM $self.contactsTable.name WHERE id=$id}]
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@SaveCity[cityID]
^if(def $cityID){
	^try{
		$cityID(^cityID.int(0))
		^if($cityID>0){
			$cookie:cityId[$cityID]
			$result[
				$.error(false)
				$.text[Город сохранён]
			]
		}{
			$result[
				$.error(true)
				$.text[ID города имеет неизвестный формат]
			]
		}
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Не передан id города]
	]
}
################################################################################