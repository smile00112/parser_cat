################################################################################
@CLASS
system
################################################################################
@auto[]
$self.classVersion[3.14]
$self.classBuildDate[26.12.2016]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[system]
$self.classDescription[Класс информации о системе]
$self.classModuleDescription[Система]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Переделаны некоторые функции, которые теперь при ошибке возвращают хэш с данными вместо кода ошибки.</font>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.14 (26.12.2016):</u></strong>
		<ol>
			<li>Перенесена функция <font color="red">GetModules</font>[] в модуль <font color="red">modules.p</font>
			<li>Переменная <strong>self.mainSite</strong> переименована в <strong>self.syncSite</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.13 (27.01.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetUsersFromXML</font>[file], возвращающая список пользователей CMS в XML формате.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.12 (13.12.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetClassInformation</font>[className^;params], возвращающая информацию о классе <strong>className</strong> в формате <strong>params.resultFormat</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetAPIError</font>[params], возвращающая текст ошибки <strong>params.errorText</strong> в формате <strong>params.resultFormat</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.11 (06.12.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetSavedCMSVersion</font>[siteName], возвращающая версию <strong>CMS</strong> этого сайта, хранящуюся на головном сайте.</li>
			<li>Добавлена функция <font color="red">^@UpdateCMSVersion</font>[siteName^;cmsVersion], изменяющая (или добавляющая) информацию о сайте <strong>siteName</strong> и версии его CMS <strong>cmsVersion</strong> в базу на главном сайте.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.1 (02.12.2015):</u></strong>
		<ol>
			<li>Добавлена переменная <strong>self.mainSite</strong>, содержащая путь к головному сайту.</li>
			<li>Добавлена переменная <strong>self.systemApiFolder</strong>, содержащая путь к папке с системными API на головном сайте.</li>
			<li>Добавлена переменная <strong>self.modulesURL</strong>, содержащая путь к списку версий модулей на головном сайте.</li>
			<li>Добавлена переменная <strong>self.usersURL</strong>, содержащая путь к списку пользователей на головном сайте.</li>
			<li>Добавлена функция <font color="red">^@UpdateModuleVersion</font>[module^;version], обновляющая версию модуля <strong>module</strong> на значение <strong>version</strong> на головном сайте.</li>
			<li>Добавлена проверка и оповещение при невозможности получения данных о версиях модулей с головного сайта.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 3.0 (07.11.2015):</u></strong>
		<ol>
			<li>Класс переделан под новую архитектуру</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.2 (23.07.2013):</u></strong>
		<ol>
			<li>Загрузка последних версий модулей происходит с сервера bryansk.in</li>
			<li>Исправлена ошибка в отображении версий модулей CMS</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.1 (15.07.2013):</u></strong>
		<ol>
			<li>Создан класс system.p для мониторинга системы</li>
			<li>Добавлена проверка списка версий модулей (только CMS)</li>
			<li>Добавлен чёрный и белый список пользователей CMS (без добавления и удаления)</li>
			<li>Добавлена проверка папки /classes</li>
			<li>Добавлена проверка существования классов</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.0 (06.03.2013):</u></strong>
		<ol>
			<li>Добавлена функция анализа пустых SEO атрибутов для страниц</li>
		</ol>
	</p>
]
# ----------------------------- Рабочие переменные -----------------------------
$self.syncSite[http://websun-com.ru]
$self.systemApiFolder[${self.syncSite}/CMS]
$self.folders[^table::create{folder	description
/bank	Банк файлов
/cgi-bin	Скрипты
/classes	Пользовательские классы
/i	Стили и доп. файлы
/lib	Библиотеки
/manage	Админка
/tmpl	Шаблоны
/typepage	Модули сайта
}]
# ------------------------------------------------------------------------------
$self.files[^table::create{file	description
/.htaccess	Файл доступа
/auto.p	Файл функций
/config.p	Доступ к БД
/index.html	Запускной файл
/robots.txt	Файл ограничения доступа роботам
/sitemap.xml	Карта сайта
}]
# ------------------------------------------------------------------------------
$self.modulesURL[${self.systemApiFolder}/modules-versions.html]
$self.modules[^self.GetModulesFromXML[$self.modulesURL]]
# ------------------------------------------------------------------------------
$self.usersURL[${self.systemApiFolder}/users.html]
$self.users[^self.GetUsersFromXML[$self.usersURL]]
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
@GetModulesFromXML[file]
^try{
# Загрузка внешнего файла
	$xml[^xdoc::load[$file]]
# хэш элементов Module из файла
	$list[^xml.select[/modules/module]]
# Возвращаем таблицу с данными о модулях
	$result[^table::create{clean	name	version
    ^for[i](0;$list-1){	^list.[$i].selectString[string(name)]	^list.[$i].selectString[string(version)]^#0A}
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
@GetUsersFromXML[file]
^try{
# Загрузка внешнего файла
	$xml[^xdoc::load[$file]]
# хэш элементов users из файла
	$list[^xml.select[/users/user]]
# Возвращаем таблицу с данными о пользователях
	$allUsers[^table::create{clean	login	password	name	level	to_delete
    ^for[i](0;$list-1){	^list.[$i].selectString[string(login)]	^list.[$i].selectString[string(password)]	^list.[$i].selectString[string(name)]	^list.[$i].selectString[string(level)]	^list.[$i].selectString[string(to_delete)]^#0A}}]
	$users[^hash::create[]]
	$users.good[^allUsers.select($allUsers.to_delete == 0)]
	$users.bad[^allUsers.select($allUsers.to_delete == 1)]
	$result[$users]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetAllCleanPagesUri[]
$result[^table::sql{SELECT * FROM $cms:pagesTable.name WHERE uri='' ORDER BY id_menu, sortir}]
################################################################################
@GetAllCleanPagesAttributes[]
$result[^table::sql{SELECT * FROM $cms:pagesTable.name WHERE head='' OR keywords='' OR descript='' ORDER BY id_menu, sortir}]
################################################################################
@GetCmsUserByLogin[login]
$result[^table::sql{SELECT * FROM $cms:adminsTable.name WHERE login='$login'}]
################################################################################
@UpdateModuleVersion[module;version]
^if(def $module && def $version){
	^try{
# Инициализируем переменную с параметрами
		$params[?]
# Передаём имя модуля
		$params[${params}module=$module]
# Передаём версию модуля
		$params[${params}&version=$version]
# Передаём имя сайта
		$params[${params}&site=^site:GetDomainName[]]
# Передаём через API соответствующую информацию о модуле и возвращаем результат
		$answer[^file::load[text;${self.systemApiFolder}/update-module-version.html${params}]]
		$result[
			$.error(false)
			$.text[$answer.text]
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
		$.text[Недостаточно данных]
	]
}
################################################################################
@GetSavedCMSVersion[siteName]
^if(def $siteName){
	^try{
		$answer[^file::load[text;${self.systemApiFolder}/get-saved-cms-version.html?site=$siteName]]
		$result[
			$.error(false)
			$.text[$answer.text]
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
		$.text[Не указан сайт]
	]
}
################################################################################
@UpdateCMSVersion[siteName;cmsVersion]
^if(def $siteName && def $cmsVersion){
	^try{
		$answer[^file::load[text;${self.systemApiFolder}/update-cms-version.html?site=$siteName&cms_version=$cmsVersion]]
		$result[
			$.error(false)
			$.text[$answer.text]
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
		$.text[Недостаточно данных]
	]
}
################################################################################
@GetClassInformation[className;params]
^if(def $className){
	^try{
		^use[${className}.p;$.replace(true)]
		^process{^$this[^^${className}::create[]]}
		$classInfo[^this.GetClassInfo[]]
		^switch[$params.resultFormat]{
			^case[xml]{
				$classInfo.format[xml]
# Создаём XML-документ
				$document[^xdoc::create[answer]]
# ------------------------------------------------------------------------------
# Создаём Тэг moduleDescription
				$moduleDescriptionNode[^document.createElement[moduleDescription]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.module_description]]
# Добавляем значение атрибута
				$addedNode[^moduleDescriptionNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$moduleDescriptionNode]]
# ------------------------------------------------------------------------------
# Создаём Тэг moduleName
				$moduleNameNode[^document.createElement[moduleName]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.module_name]]
# Добавляем значение атрибута
				$addedNode[^moduleNameNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$moduleNameNode]]
# ------------------------------------------------------------------------------
# Создаём Тэг version
				$versionNode[^document.createElement[version]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.version]]
# Добавляем значение атрибута
				$addedNode[^versionNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$versionNode]]
# ------------------------------------------------------------------------------
# Создаём Тэг buildDate
				$buildDateNode[^document.createElement[buildDate]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.build_date]]
# Добавляем значение атрибута
				$addedNode[^buildDateNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$buildDateNode]]
# ------------------------------------------------------------------------------
# Создаём Тэг Developer
				$DeveloperNode[^document.createElement[Developer]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.developer]]
# Добавляем значение атрибута
				$addedNode[^DeveloperNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$DeveloperNode]]
# ------------------------------------------------------------------------------
# Создаём Тэг History
				$HistoryNode[^document.createElement[History]]
# Прописываем значение атрибута
				$ValueElement[^document.createTextNode[$classInfo.history]]
# Добавляем значение атрибута
				$addedNode[^HistoryNode.appendChild[$ValueElement]]
# Добавляем значение в документ
				$addedNode[^document.documentElement.appendChild[$HistoryNode]]
# ------------------------------------------------------------------------------
# Выводим результат
				$classInfo.text[^document.string[$.indent[yes]]]
			}
			^case[DEFAULT]{
				$classInfo.format[text]
				$classInfo.text[<table border="0" cellspacing="0" cellpadding="3">]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td><strong>Module Description</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.module_description</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td><strong>Module Name</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.module_name</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td><strong>Version</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.version</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td><strong>Build Date</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.build_date</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td><strong>Developer</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.developer</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text<tr>]
				$classInfo.text[$classInfo.text<td valign="top"><strong>History</strong>:</td>]
				$classInfo.text[$classInfo.text<td>$classInfo.history</td>]
				$classInfo.text[$classInfo.text</tr>]
				$classInfo.text[$classInfo.text</table>]
			}
		}
		$result[$classInfo]
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
		$.text[Неизвестный класс]
	]
}
################################################################################
@GetAPIError[params]
$error[^hash::create[]]
^if(def $params.resultFormat){$error.format[$params.resultFormat]}{$error.format[text]}
^try{
	^if(def $params.errorText){
		$error.text[$params.errorText]
	}{
		$error.text[Ошибка при выполнении запроса!]
	}
	^switch[$params.resultFormat]{
		^case[xml]{
# Создаём XML-документ
			$document[^xdoc::create[answer]]
# Создаём главный Тэг error
			$errorNode[^document.createElement[error]]
# Прописываем значение атрибута
			$ValueElement[^document.createTextNode[$error.text]]
# Добавляем значение атрибута
			$addedNode[^errorNode.appendChild[$ValueElement]]
# Добавляем значение в документ
			$addedNode[^document.documentElement.appendChild[$errorNode]]
# Выводим результат
			$error.text[^document.string[$.indent[yes]]]
		}
		^case[DEFAULT]{$error.format[text]}
	}
}{
	$exception.handled(true)
	$error.text[Ошибка функции GetAPIError!]
}
$result[$error]
################################################################################
@AddUserByAPI[user;params]
$answer[^hash::create[]]
^if(def $params.resultFormat){$error.format[$params.resultFormat]}{$error.format[text]}
^try{
	^if(def $params.errorText){
		$answer.text[$params.errorText]
	}{
		$answer.text[Ошибка при выполнении запроса!]
	}
	^switch[$params.resultFormat]{
		^case[xml]{
		}
		^case[DEFAULT]{$answer.format[text]}
	}
}{
	$exception.handled(true)
	$answer.text[Ошибка функции AddUserByAPI!]
}
$result[$answer]
################################################################################