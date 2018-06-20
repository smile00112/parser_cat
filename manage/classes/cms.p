################################################################################
@CLASS
cms
################################################################################
@auto[]
^use[structure.p;$.replace(true)]
$self.currentPath[^env:PATH_INFO.split[/;l]]
$self.currentPath[^self.currentPath.hash[piece][piece][$.type[string]]]
#----------------------------- Рабочие переменные ------------------------------
$self.cmsName[WEBSUN CMS]
$self.cryptValue[^$apr1^$AutoPhS]
$self.template[main]
$self.currentModule[^hash::create[]]
$self.maxUserLevel(10)
$self.domain[^env:SERVER_NAME.replace[www.;]]
# Текущая дата
$self.date[^date::now[]]
$self.configFile[/config.p]
$self.MySQLfieldTypes[
	$.1[
		$.name[string]
		$.caption[Строка]
		$.type[varchar]
		$.size(255)
		$.null[NOT NULL]
		$.default[NULL]
	]
	$.2[
		$.name[int]
		$.caption[Число]
		$.type[int]
		$.size(1)
		$.null[NOT NULL]
		$.default(0)
	]
	$.3[
		$.name[unsigned_int]
		$.caption[Число (беззнаковое)]
		$.type[int]
		$.size(1)
		$.attribute[unsigned]
		$.null[NOT NULL]
		$.default(0)
	]
]
#----------------------------------- Папки -------------------------------------
$self.cmsFolder[/^self.currentPath.at(1)]
$self.currentFile[^self.currentPath.at(-1)]
$self.currentFolder[/^self.currentPath.at(-2)]
$self.classesFolder[${self.cmsFolder}/classes]
$self.templatesFolder[${self.cmsFolder}/templates]
$self.templateFolder[${self.templatesFolder}/${self.template}]
$self.imagesFolder[${self.templateFolder}/images]
$self.errorsFolder[/errors]
# Папка статистики
$self.logFolder[${self.cmsFolder}/logs]
# Файл статистики без расширения
$self.logFileName[${self.logFolder}/log]
# Расширение файла статистики
$self.logFileExt[.txt]
# Файл статистики
$self.logFile[${self.logFileName}${self.logFileExt}]
#------------------------------ Имена SQL-таблиц -------------------------------
$self.adminsTable[
	$.name[admins]
	$.file[admins.table]
]
$self.pagesTable[
	$.name[menus]
	$.file[menus.table]
]
$self.pageBlockOptionsTable[
	$.name[te_opt]
	$.file[te_opt.table]
]
$self.cmsBlocksTable[
	$.name[cmc_block]
	$.file[cmc_block.table]
]
$self.siteSettingsTable[
	$.name[site_settings]
	$.file[site_settings.table]
]
$self.siteRedirectsTable[
	$.name[site_redirects]
	$.file[site_redirects.table]
]
#------------------------- Информация о пользователе ---------------------------
^site:Include[/config.p]
$site:connectString[$site:mysqlString?charset=^if(def $cms_charset){$cms_charset}{utf8}]
$self.cmsUser[^connect[$site:connectString]{^self.GetAdmin[$cookie:adm_login;$cookie:adm_password]}]
$self.cmsUserLevel(^connect[$site:connectString]{^self.GetAdminLevel[$cookie:adm_login]})
#---------------------------- Информация о классе ------------------------------
$self.className[CMS]
$self.classVersion(2.38)
$self.classBuildDate[18.02.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.classDescription[Система управления сайтом "$self.cmsName"]
$self.classModuleDescription[Система управления сайтом "$self.cmsName"]
$self.classHistory[
<p align="justify">
	<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
	<ol>
		<li>Удалена функция <font color="#cc0000">^@GetCmsBlocks</font>[params], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Удалена функция <font color="#cc0000">^@GetModuleIdByName</font>[name], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Удалена функция <font color="#cc0000">^@GetModulePathByName</font>[name], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Удалена функция <font color="#cc0000">^@GetBlockDescriptionByName</font>[name], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Удалена функция <font color="#cc0000">^@GetCmsSections</font>[level], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Удалена функция <font color="#cc0000">^@UpdateModulePathByName</font>[name^;path], так как её аналог есть в классе <strong>modules.p</strong></li>
		<li>Доработана функция <font color="#cc0000">^@SetCurrentModule</font>[moduleName] и у неё убран 2 параметр <strong>pageBlock</strong>.</li>
		<li>Удалена переменная <font color="#cc0000">^$self.currentModuleName</font>, так как теперь вся информация о текущей странице доступна в переменной <strong>self.currentModule</strong>.</li>
		<li>Удалена переменная <font color="#cc0000">^$self.currentModulePath</font>, так как теперь вся информация о текущей странице доступна в переменной <strong>self.currentModule</strong>.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.37 (09.10.2017):</u></strong>
	<ol>
		<li>Переменная <font color="#cc0000">self.scriptsFolder</font> перенесена в класс <strong>site.p</strong>.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.36 (23.08.2017):</u></strong>
	<ol>
		<li>Переменная <font color="#cc0000">path</font> переименована в <font color="#cc0000">self.path</font> и теперь содержит хэш всех элементов адреса страницы.</li>
		<li>Добавлена переменная <font color="#cc0000">self.currentFolder</font>, которая хранит имя текущего каталога.</li>
		<li>Добавлена переменная <font color="#cc0000">self.currentFile</font>, которая хранит имя текущего файла.</li>
		<li>Добавлена поддержка многоязычности (если присутствует переменная <font color="#cc0000">cms.languageVars</font>).</li>
		<li>Добавлена функция <font color="#cc0000">:^@inMain</font>[], которая вызывается внутри функции <font color="#cc0000">:^@main</font>[].</li>
		<li>Теперь в каждом модуле не требуется отслеживать, залогинен ли пользователь. Это делается в корневом методе <font color="#cc0000">^@main</font>[].</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.35 (02.03.2017):</u></strong>
	<ol>
		<li>Добавлена переменная (хэш) <font color="#cc0000">self.MySQLfieldTypes</font>, которая хранит типы переменных MySQL.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.34 (02.02.2017):</u></strong>
	<ol>
		<li>В функцию <font color="#cc0000">^@HtaccessGenerate</font>[] добавлено перенаправление с /index.html на /.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.33 (25.12.2016):</u></strong>
	<ol>
		<li>Добавлен модуль "SEO" в главное меню.</li>
		<li>Модуль "Перенаправление страниц" перенесён в модуль "SEO".</li>
		<li>Модуль "Контакты" перенесён в главное меню.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.32 (28.11.2016):</u></strong>
	<ol>
		<li>Добавлена переинициализация переменной <font color="#cc0000">site:connectString</font> для устранения конфликта кодировок.</li>
		<li>В шаблон добавлен блок класса <font color="#cc0000">wait</font> для отображения значка ожидания в центре экрана при выполнении длительного действия.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.31 (20.09.2016):</u></strong>
	<ol>
		<li>Добавлена функция <font color="#cc0000">^@var_dump</font>[variable^;nested], которая выдаёт дамп переменной <strong>variable</strong>.</li>
		<li>Удалена функция <font color="#cc0000">^@dbconnect</font> из файла <strong>auto.p</strong>.</li>
		<li>Удалена переменная <font color="#cc0000">connect_string</font> из файла <strong>auto.p</strong>, и теперь она инициализируются только в классе <strong>site.p</strong>.</li>
		<li>Удалена переменная <font color="#cc0000">servername</font> из файла <strong>auto.p</strong>.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.3 (05.06.2016):</u></strong>
	<ol>
		<li>Почищен файл auto.p, отвечающий за функции работы CMS.</li>
		<li>Добавлена функция <font color="#cc0000">^@HtaccessGenerate</font>[], которая генерирует корневой файл <strong>.htaccess</strong>.</li>
		<li>Добавлена функция <font color="#cc0000">^@GetSiteSettingsValue</font>[name], которая возвращает значение параметра <strong>name</strong> из таблицы настроек сайта.</li>
		<li>Добавлена функция <font color="#cc0000">^@GetSiteRedirects</font>[], которая возвращает список всех редиректов сайта.</li>
		<li>Добавлена функция <font color="#cc0000">^@GetCmsBlocks</font>[params], которая возвращает список всех блоков сайта.</li>
		<li>Перенесены функции GetModuleIdByName, GetModulePathByName, GetBlockDescriptionByName, GetCmsSections, UpdateModulePathByName из класса <strong>textext.p</strong>.</li>
		<li>Автоматически подключается класс <strong>structure.p</strong>.</li>
		<li>Добавлена поддержка <strong>Sitemap</strong>.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.23 (11.12.2015):</u></strong>
	<ol>
		<li>В транслитерацию добавлена обработка символа ©.</li>
		<li>Добавлена функция <font color="#cc0000">^@ConvertUrl</font>[string], которая выдаёт валидный url, который получает из строки <strong>string</strong>.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.22 (30.11.2015):</u></strong>
	<ol>
		<li>Добавлена функция <font color="#cc0000">^@RenameTable</font>[old_name^;new_name], которая переименовывает таблицу <strong>old_name</strong> в <strong>new_name</strong>.</li>
		<li>В функцию <font color="#cc0000">^@GetImageName</font>[tableName^;imageName^;imageNameFirst^;number^;field] добавлен параметр.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.21 (17.11.2015):</u></strong>
	<ol>
		<li>Добавлена функция <font color="#cc0000">^@ShowModalHeader</font>[header], которая возвращает HTML код header'а модального окна.</li>
		<li>Добавлена функция <font color="#cc0000">^@ShowModalFooter</font>[], которая возвращает HTML код footer'а модального окна.</li>
		<li>Добавлена переменная <font color="#cc0000">configFile</font>, которая содержит путь к конфигурационному файлу.</li>
		<li>Добавлена функция <font color="#cc0000">^@GetAllTablesList</font>[], которая возвращает список всех таблиц базы данных.</li>
		<li>Добавлена функция <font color="#cc0000">^@GetTableFieldsList</font>[table_name], которая возвращает список всех полей таблицы.</li>
		<li>Добавлена функция <font color="#cc0000">^@InsertTable</font>[table_name^;file_path], которая добавляет таблицу <strong>table_name</strong> в БД по данным из файла <strong>file_path</strong>.</li>
		<li>Добавлена функция <font color="#cc0000">^@DeleteTable</font>[table_name], которая удаляет таблицу <strong>table_name</strong> из БД.</li>
		<li>Добавлена функция <font color="#cc0000">^@InsertTableField</font>[table_name^;field^;file_path], которая добавляет поле <strong>field</strong> таблицы <strong>table_name</strong> по данным из файла <strong>file_path</strong>.</li>
		<li>Добавлена функция <font color="#cc0000">^@RenameTableField</font>[table_name^;field^;file_path], которая переименовывает поле <strong>field</strong> таблицы <strong>table_name</strong> по данным из файла <strong>file_path</strong>.</li>
		<li>Добавлена функция <font color="#cc0000">^@DeleteTableField</font>[table_name^;field], которая удаляет поле <strong>field</strong> таблицы <strong>table_name</strong>.</li>
		<li>В транслитерацию добавлена обработка символов « и ».</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.2 (29.07.2015):</u></strong>
	<ol>
		<li>Создан класс cms.p для централизации работы CMS</li>
		<li>Упразднена функция <font color="#cc0000">^@init</font>[], её переменные перенесены в класс cms.p</li>
		<li>Добавлена функция <font color="#cc0000">^@Translit</font>[text^;params], которая возвращает транслитерированный text.</li>
		<li>Добавлена функция <font color="#cc0000">^@ImageCrop</font>[src^;dest^;x^;y^;width^;height^;params], которая обрезает изображение.</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.10 (29.08.2014):</u></strong>
	<ol>
		<li>Добавлена поддержка API для CMS</li>
		<li>Добавлена возможность размещения новостей через API</li>
		<li>Добавлена возможность блокировки сайта + (API)</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.09 (07.03.2014):</u></strong>
	<ol>
		<li>В функцию <font color="#cc0000">^@main</font>[] добавлена загрузка класса site.p, которая решила проблему неправильной инициализации классов</li>
		<li>Добавлено перенаправление на информационные страницы при отсутствующей странице и ошибке выполнения скрипта</li>
		<li>Исправлена ошибка 301 редиректа (не работал)</li>
		<li>Код адаптирован под работу с версией parser 3.4.3</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.08 (22.11.2013):</u></strong>
	<ol>
		<li>В функцию <font color="#cc0000">^@make_rewrite</font>[] добавлен обработчик модулей нового типа</li>
		<li>Убрана постоянная проверка существования пользователей CMS</li>
		<li>Структура переделана под шаблонную концепцию</li>
		<li>Размещена реклама услуг и добавлена возможность взаимодействия с клиентом</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.07 (09.08.2013):</u></strong>
	<ol>
		<li>Создана переменная <font color="#cc0000">^$classesFolder</font>, которая хранит путь к классам CMS</li>
		<li>Добавлена функция <font color="#cc0000">^@head</font>[], которая позволяет подключать стили и скрипты</li>
		<li>Добавлена функция <font color="#cc0000">^@auto</font>[], которая исполняется раньше всех функций</li>
		<li>Убрана функция <font color="#cc0000">^@info</font>[], а её содержимое перенесено в функцию <font color="#cc0000">^@auto</font>[]</li>
		<li>Добавлены шрифты google</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.06 (10.06.2013):</u></strong>
	<ol>
		<li>Поправлен HTML код страницы (было 2 тэга body)</li>
		<li>Стили спрятаны в файл cms_style.css</li>
		<li>Добавлена функция <font color="#cc0000">^@change_charset</font>[charset], которая изменяет кодировку запроса и ответа сервера</li>
		<li>В функцию <font color="#cc0000">^@get_image_extention</font>[path^;name] добавлено расширение файла <strong>jpeg</strong></li>
		<li>Добавлена функция объединения виджетов сайта</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.05 (26.03.2013):</u></strong>
	<ol>
		<li>Добавлена функция перехвата ошибок</li>
		<li>В функцию <font color="#cc0000">^@get_edit_info</font>[table^;edit^;id^;sortir] добавлен параметр sortir</li>
		<li>Запрещён доступ к папкам, в которых нет индексного файла (чтобы не выводилось содержимое папки)</li>
		<li>Добавлена функция <font color="#cc0000">^@redirected_pages</font>[], которая выводит правила редиректа страниц</li>
		<li>В функцию <font color="#cc0000">^@check_fields</font> добавлен обработчик для типа поля time</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.04 (13.02.2013):</u></strong>
	<ol>
		<li>Добавлена функция 301 редиректа</li>
		<li>Добавлена функция объединения опций сайта</li>
		<li>Добавлена функция <font color="#cc0000">^@init</font>[]: инициализация переменных CMS</li>
		<li>Добавлена переменная <font color="#cc0000">^$domain</font>, которая содержит название домена (без WWW) для текущего сайта <font color="#cc0000">$domain</font></li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.03 (10.01.2013):</u></strong>
	<ol>
		<li>Добавлена функция <font color="#cc0000">^@get_add_info_fields</font>[]: формирование списка имён служебных полей таблицы ^$table при добавлении элемента</li>
		<li>Исправлены мелкие недочёты</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.02 (01.12.2012):</u></strong>
	<ol>
		<li>Добавлена функция <font color="#cc0000">^@get_image_extention</font>[path^;name]: получение расширения изображения</li>
		<li>Добавлена функция <font color="#cc0000">^@page_head</font>[name^;cms_page_id^;module_info^;folder]: вывод заголовка блока (название, иконка и версия)</li>
		<li>Добавлена функция <font color="#cc0000">^@get_info_fields</font>[]: получение списка служебных полей таблицы</li>
		<li>Добавлена функция <font color="#cc0000">^@create_sql_table</font>[table_name^;fields^;info_fields^;folder]: создание SQL таблицы ^$table_name с полями ^$fields</li>
		<li>Добавлена функция <font color="#cc0000">^@add_actions</font>[name^;description^;id^;show_edit_action^;parameters]: вывод кнопок действия с записью</li>
		<li>Добавлена функция <font color="#cc0000">^@get_add_info</font>[table^;sortir]: формирование списка значений служебных полей таблицы ^$table при добавлении элемента</li>
		<li>Добавлена функция <font color="#cc0000">^@get_edit_info</font>[table^;edit^;id]: формирование служебных полей таблицы ^$table при изменении элемента</li>
		<li>Добавлена функция <font color="#cc0000">^@insert_table_field</font>[path^;table^;fields]: добавление отсутствующих полей к таблице ^$table</li>
		<li>Добавлена функция <font color="#cc0000">^@check_fields</font>[fields]: проверка заполнения полей</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.01 (31.10.2012):</u></strong>
	<ol>
		<li>Добавлено отображение информации об изменениях в CMS (История версий)</li>
		<li>Изменено отображение страницы приветствия CMS</li>
		<li>Кнопка "Наверх" для сайта и для CMS разделены</li>
		<li>Добавлена поддержка png иконок в меню</li>
		<li>Иконки в меню также теперь являются ссылками</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 2.0 (11.10.2012):</u></strong>
	<ol>
		<li>Введено отображение версий</li>
		<li>Немного изменён интерфейс пользователя</li>
		<li>Добавлена возможность использовать иконки не только формата gif</li>
		<li>Исправлена проблема отображения иконок по умолчанию</li>
		<li>Добавлена ссылка на раздел помощи справа вверху</li>
		<li>Добавлена кнопка "Наверх"</li>
		<li>Исправлена проблема отображения информационного блока под меню</li>
		<li>Добавлено название сайта в CMS в тег title</li>
		<li>Добавлена иконка в CMS</li>
	</ol>
</p>
<p align="justify">
	<strong><u>Версия 1.0 (14.10.2008):</u></strong>
	<ol>
		<li>Добавлен prefpath</li>
		<li>Добавлены разделители</li>
		<li>@create_cookie_back[uri]</li>
		<li>@redirect_cookie[]</li>
		<li>Разграничение показа по уровню доступа</li>
		<li>insert_error_fields возврат по таймеру</li>
		<li>В tiny редактор использование стиля из файла /i/style_cmc.css</li>
		<li>uri для возврата в нужную страницу для языка выбора</li>
		<li>make_rewrite генерирование для mod_Rewrite</li>
	</ol>
</p>
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
@SetCurrentModule[moduleName;fields]
^if(def $fields){
	$self.currentModule[^hash::create[$fields]]
}{
	$self.currentModule[^modules:GetModules[$.name[$moduleName]]]
}
################################################################################
@ShowTemplate[filename]
^if(-f "$filename"){
	$t[^file::load[text;$filename]]
	$template[^untaint{$t.text}]
	$result[^process{$template}]
}{
	$result[<h1>Шаблон $filename не найден</h1>]
}
################################################################################
@Catch[exception;name]
$exception.handled(1)
$name
<p align="center">Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
<p align="center">Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
################################################################################
@ShowPageHeader[pageName;pagePath;moduleInfo;folder;hideInfo]
^self.ShowTemplate[${self.templateFolder}/header_page.html]
^try{^self.ShowPageHeader[$pageName;$pagePath;$moduleInfo;$folder;$hideInfo]}{^self.Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@ShowModalHeader[header]
^self.ShowTemplate[${self.templateFolder}/modal_header_page.html]
^try{^self.ShowModalPageHeader[$header]}{^self.Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@ShowModalFooter[]
^self.ShowTemplate[${self.templateFolder}/modal_footer_page.html]
^try{^self.ShowModalPageFooter[]}{^self.Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@GetAdmin[login;pass]
$result[^table::sql{SELECT login, password, fio FROM $self.adminsTable.name WHERE login='$login' AND password='$pass'}]
################################################################################
@GetCmsUsers[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.level){$params.level($self.cmsUserLevel)}
^if(!def $params.order){$params.order[level DESC, login]}
$result[^table::sql{SELECT login, fio, level FROM $self.adminsTable.name WHERE level<=$params.level ORDER BY $params.order}]
################################################################################
@GetImageExtention[path;name]
^if(!def $name){$name[index]}
^if(-f "${path}${name}.png"){
 $result[png]
}{
 ^if(-f "${path}${name}.gif"){
  $result[gif]
 }{
  ^if(-f "${path}${name}.jpeg"){
   $result[jpeg]
  }{
   ^if(-f "${path}${name}.jpg"){
    $result[jpg]
   }{
    $result[no]
   }
  }
 }
}
################################################################################
@GetAdminLevel[login]
$result(^int:sql{SELECT level FROM $self.adminsTable.name WHERE login='$login'}[$.default(0)])
################################################################################
@InsertTinyNew[tiny_count;filecss]
<script type="text/javascript" src="${self.cmsFolder}/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
tinymce.init({
    selector: "textarea",
		language: 'ru',
		skin : 'xenmce',
    plugins: [
        "advlist autolink lists link image charmap print preview anchor",
        "searchreplace visualblocks code fullscreen",
        "insertdatetime media table contextmenu paste moxiemanager"
    ],
    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
})^;
</script>
################################################################################
# функция для вставки блока редактора tyny
@InsertTiny[name;tiny_count;filecss]
^if(!def $name){$name[elm]}
$temp[${name}]
^for[ind](2;$tiny_count){
	$temp[${temp},${name}_${ind}]
}
<script language="javascript" type="text/javascript" src="${self.cmsFolder}/tiny/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({
		// General options
		mode     : "exact",
		theme    : "advanced",
		theme_advanced_resize_horizontal: false,
		plugins  : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,visualblocks,spellchecker",
		language : "ru",
		skin     : "default",
		// Theme options
		theme_advanced_buttons1 : "undo,redo,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect,styleselect",
		theme_advanced_buttons2 : "bullist,numlist,|,outdent,indent,|,link,unlink,anchor,image,|,hr,removeformat,cleanup,|,sub,sup,|,charmap,iespell,media",
		theme_advanced_buttons3 : "tablecontrols,|,fullscreen,spellchecker,code",
		theme_advanced_resizing : true,
		extended_valid_elements : "iframe[width|height|src|frameborder|allowfullscreen],hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style|id|itemprop|itemscope|itemtype],div[itemprop|itemscope|itemtype|class|style|id],td[itemprop|itemscope|itemtype|class|style|id],a[name|href|target|alt|title|class|style|id|itemprop|itemscope|itemtype|rel],img[src|alt|title|class|style|id],meta[itemprop|itemscope|itemtype|content],nobr",
		apply_source_formatting : true,
		file_browser_callback   : "almaFM",
		nonbreaking_force_tab   : true,
		remove_script_host      : true,
		relative_urls           : false,
		content_css             : "${site:templateFolder}/styles/editor.css",
		elements                : "$temp"
	})^;
	function almaFM(field_name, url, type, win) {
		tinyMCE.activeEditor.windowManager.open({
			file           : "${self.cmsFolder}/v3filemanager/index.html?opener=tinymce&url="+url+"&type="+type,
			title          : "FileManager.ALMA.CMS",
			width          : 820,
			height         : 500,
			resizable      : "yes",
			inline         : true,
			close_previous : "no",
			popup_css      : false,
		}, {
			window         : win,
			input          : field_name
		});
		return false^;
	}
</script>
################################################################################
@ImageResize[src;dest;w;h;sFormat][$params]
$NConvert[^NConvert::create[]]
$params[
	$.bKeepRatio(1)
	$.sResizeType[decr]
	$.iQuality(80)
]
^if(def $w && def $h){
	^NConvert.resize[$src;$dest;$w;$h;$params]
}{
	^if(def $w){^NConvert.resize[$src;$dest;$w;99999;$params]}{^NConvert.resize[$src;$dest;99999;$h;$params]}
}
################################################################################
@ImageCrop[src;dest;x;y;width;height;params][$params]
$NConvert[^NConvert::create[]]
^if(!def $params.iQuality){$params.iQuality(200)}
$result[^NConvert.crop[$src;$dest;$x;$y;$width;$height;$params]]
################################################################################
@GetImageName[tableName;imageName;imageNameFirst;number;field]
^if(!def $imageNameFirst){
	$imageNameFirst[$imageName]
	$number(0)
}
^if(!def $field){$field[name]}
$copies(^int:sql{SELECT COUNT(id) FROM $tableName WHERE ${field}="$imageName"})
^if($copies>0){
	$number(^eval($number+1))
	$imageName[^self.GetImageName[$tableName;${number}_${imageNameFirst};$imageNameFirst;$number;$field]]
}
$result[$imageName]
################################################################################
@Translit[text;params]
^if($params.filename==1){
$parse[^table::create{from	to
а	a
б	b
в	v
г	g
д	d
е	e
ё	e
ж	zh
з	z
и	i
й	i
к	k
л	l
м	m
н	n
о	o
п	p
р	r
с	s
т	t
у	u
ф	f
х	h
ц	c
ч	ch
ш	sh
щ	sch
ъ	_
ь	_
ы	i
э	e
ю	u
я	ya
А	A
Б	B
В	V
Г	G
Д	D
Е	E
Ё	E
Ж	ZH
З	Z
И	I
Й	I
К	K
Л	L
М	M
Н	N
О	O
П	P
Р	R
С	S
Т	T
У	U
Ф	F
Х	H
Ц	C
Ч	CH
Ш	SH
Щ	SCH
Ъ	_
Ь	_
Ы	I
Э	E
Ю	U
Я	YA
©	_
«	_
»	_
!	_
,	_
%	_
#01	_
#02	_
#03	_
#04	_
#05	_
#06	_
#07	_
#08	_
#09	_
#0a	_
#0b	_
#0c	_
#0d	_
#0e	_
#0f	_
#10	_
#11	_
#12	_
#13	_
#14	_
#15	_
#16	_
#17	_
#18	_
#19	_
#1a	_
#1b	_
#1c	_
#1d	_
#1e	_
#1f	_
#20	_
^"	_
 	_
}]
}{
$parse[^table::create{from	to
а	a
б	b
в	v
г	g
д	d
е	e
ё	e
ж	zh
з	z
и	i
й	i
к	k
л	l
м	m
н	n
о	o
п	p
р	r
с	s
т	t
у	u
ф	f
х	h
ц	c
ч	ch
ш	sh
щ	sch
ъ	'
ь	'
ы	i
э	e
ю	u
я	ya
А	A
Б	B
В	V
Г	G
Д	D
Е	E
Ё	E
Ж	ZH
З	Z
И	I
Й	I
К	K
Л	L
М	M
Н	N
О	O
П	P
Р	R
С	S
Т	T
У	U
Ф	F
Х	H
Ц	C
Ч	CH
Ш	SH
Щ	SCH
Ъ	'
Ь	'
Ы	I
Э	E
Ю	U
Я	YA
©	_
«	_
»	_
!	_
,	_
.	_
%	_
#01	_
#02	_
#03	_
#04	_
#05	_
#06	_
#07	_
#08	_
#09	_
#0a	_
#0b	_
#0c	_
#0d	_
#0e	_
#0f	_
#10	_
#11	_
#12	_
#13	_
#14	_
#15	_
#16	_
#17	_
#18	_
#19	_
#1a	_
#1b	_
#1c	_
#1d	_
#1e	_
#1f	_
#20	_
^"	_
 	_
}]
}
$result[^text.replace[$parse]]
################################################################################
@InsertIntoLog[params]
^if(-f $self.logFile){
	$new_string[$params.module	$params.module_id	$params.method	$params.description	$params.unit_id	$self.cmsUser.login	$self.cmsUserLevel	^self.date.sql-string[]^#0A]
	$res[^new_string.save[append;$self.logFile]]
}{
	$header_string[module	module_id	method	description	unit_id	user	level	date^#0A]
	$res[^header_string.save[append;$self.logFile]]
	$new_string[$params.module	$params.module_id	$params.method	$params.description	$params.unit_id	$self.cmsUser.login	$self.cmsUserLevel	^self.date.sql-string[]^#0A]
	$res[^new_string.save[append;$self.logFile]]
}
$fileStat[^file::stat[$self.logFile]]
$fileSize(^eval($fileStat.size/1024/1024))
^if($fileSize >= 10){
	$res[^file:move[$self.logFile;${self.logFileName}_${self.date.year}-${self.date.month}-${self.date.day}_${self.date.hour}-${self.date.minute}-${self.date.second}${self.logFileExt}]]
}
################################################################################
@GetAllTablesList[]
# Возвращаем список всех таблиц базы
$result[^table::sql{SELECT table_name FROM information_schema.tables}]
################################################################################
@GetTableFieldsList[table_name]
# Возвращаем список всех полей таблицы
$result[^table::sql{SHOW COLUMNS FROM $table_name}]
################################################################################
@InsertTable[table_name;file_path]
^if(def $table_name && -f "$file_path"){
	^try{
		$loaded_table[^table::load[$file_path]]
		$query[CREATE TABLE IF NOT EXISTS $table_name (]
		^loaded_table.menu{
			$query[$query $loaded_table.sql_field]
		}
		$query[$query ) DEFAULT CHARSET=cp1251]
		^void:sql{$query}
		$result(1)
	}{
# 		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@RenameTable[old_name;new_name]
^if(def $old_name && def $new_name){
	^try{
		^void:sql{ALTER TABLE $old_name RENAME $new_name}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteTable[table_name]
^if(def $table_name){
	^try{
		^void:sql{DROP TABLE $table_name}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@InsertTableField[table_name;field;file_path]
^if(def $table_name && def $field && -f "$file_path"){
	^try{
		$loaded_table[^table::load[$file_path]]
		^if(^loaded_table.locate[field;$field]){
			$newField[^loaded_table.sql_field.replace[,;]]
			$newField[^newField.replace[ DEFAULT '';]]
			$newField[^newField.replace[';]]
			^void:sql{ALTER TABLE $table_name ADD COLUMN $newField}
			$result(1)
		}{
			$result(-2)
		}
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@RenameTableField[table_name;field;file_path]
^if(def $table_name && def $field && -f "$file_path"){
	^try{
		$loaded_table[^table::load[$file_path]]
		^if(^loaded_table.locate[rename;$field]){
			$newField[^loaded_table.sql_field.replace[,;]]
			$newField[^newField.replace[ DEFAULT '';]]
			$newField[^newField.replace[';]]
$debug[ALTER TABLE $table_name CHANGE COLUMN `$field` $newField]
^debug.save[/debug.html]
			^void:sql{ALTER TABLE $table_name CHANGE COLUMN `$field` $newField}
			$result(1)
		}{
			$result(-2)
		}
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteTableField[table_name;field]
^if(def $table_name && def $field){
	^try{
		^void:sql{ALTER TABLE $table_name DROP COLUMN `$field`}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@ConvertUrl[string]
$symbols[^string.match[([a-zA-Z0-9- ])][gi]]
^symbols.menu{
	$res[${res}$symbols.1]
}
$result[$res]
################################################################################
@HtaccessGenerate[]
$header[AddHandler parsed-html html
Action parsed-html /cgi-bin/parser3.cgi
# запрет на доступ к .cfg и .p файлам:
<Files ~ "\.(p|cfg)^$">
Order allow,deny
Deny from all
</Files>

<IfModule mod_deflate.c>
	SetOutputFilter DEFLATE
	Header append Vary "User-Agent"
	Header set Referrer-Policy "no-referrer-when-downgrade"
	Header set X-XSS-Protection "1^; mode=block"
	Header always append X-Frame-Options "SAMEORIGIN"
	Header set X-Content-Type-Options "nosniff"
</IfModule>

<IfModule mod_expires.c>
	ExpiresActive On
	ExpiresDefault "access plus 1 month"

	ExpiresByType text/cache-manifest "access plus 59 seconds"
	ExpiresByType text/html "now"
	ExpiresByType text/xml "access plus 59 seconds"
	ExpiresByType application/xml "access plus 0 seconds"
	ExpiresByType application/json "access plus 0 seconds"
	ExpiresByType application/rss+xml "access plus 1 hours"
	ExpiresByType image/x-icon "access plus 1 week"
	ExpiresByType image/gif "access plus 1 year"
	ExpiresByType image/png "access plus 1 year"
	ExpiresByType image/jpg "access plus 1 year"
	ExpiresByType image/jpeg "access plus 1 year"
	ExpiresByType video/ogg "access plus 1 year"
	ExpiresByType audio/ogg "access plus 1 year"
	ExpiresByType audio/mp3 "access plus 1 year"
	ExpiresByType video/mp4 "access plus 1 year"
	ExpiresByType video/webm "access plus 1 year"
	ExpiresByType text/x-component "access plus 1 month"
	ExpiresByType font/truetype "access plus 1 year"
	ExpiresByType font/opentype "access plus 1 year"
	ExpiresByType application/x-font-woff "access plus 1 year"
	ExpiresByType image/svg+xml "access plus 1 month"
	ExpiresByType application/vnd.ms-fontobject "access plus 1 year"
	ExpiresByType text/css "access plus 2 months"
	ExpiresByType application/javascript "access plus 2 months"
	ExpiresByType text/javascript "access plus 2 months"
</IfModule>

DirectoryIndex index.html index.php index.htm
BrowserMatch "MSIE" brokenvary=1
BrowserMatch "Mozilla/4.[0-9]{2}" brokenvary=1
BrowserMatch "Opera" !brokenvary
SetEnvIf brokenvary 1 force-no-vary

RewriteEngine On
RewriteBase	/

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_URI} !(.*)/^$
RewriteRule ^^(.*[^^/])^$ ^$1/ [L,R=301]
# Правило для index.html
RewriteCond %{QUERY_STRING} !^^(.+)^$ [NC]
RewriteRule ^^index\.html^$ /? [L,R=301]

Options -Indexes
]
#-------------------------------------------------------------------------------
# Получаем значение настроек 301 редиректа из базы
$redirect_301_value(^self.GetSiteSettingsValue[redirect_301])
$https_value(^self.GetSiteSettingsValue[https])
# Получаем результат
^if(def $https_value){
	$header[${header}^#0ARewriteCond %{SERVER_PORT} ^^^if($https_value eq 0){443}{80}^$ [OR]]
	$header[${header}^#0ARewriteCond %{HTTPS} =^if($https_value eq 0){on}{off}]
	$header[${header}^#0ARewriteRule (.*) http^if($https_value eq 1){s}://^if($redirect_301_value eq 1){www.}${self.domain}/^$1 [R=301,L]]
}
$header[${header}^#0ARewriteCond %{HTTP_HOST} ^^^if($redirect_301_value eq 0){www.}${self.domain}]
$header[${header}^#0ARewriteRule (.*) http^if($https_value eq 1){s}://^if($redirect_301_value eq 1){www.}${self.domain}/^$1 [R=301,L]^#0A]
#-------------------------------------------------------------------------------
# Получаем список страниц для редиректа
$redirected_pages[^self.GetSiteRedirects[]]
^if(def $redirected_pages){
	^redirected_pages.menu{
		^if(def $redirected_pages.source_url){
			$header[${header}^#0ARewriteRule ^^$redirected_pages.source_url^if($redirected_pages.subfolders eq '0'){^$} ^if($redirected_pages.destination_url ne '/'){/}$redirected_pages.destination_url [L,R=301]]
		}
	}
}
#-------------------------------------------------------------------------------
$header[${header}^#0A^#0AErrorDocument 404 ${self.errorsFolder}/404/^#0A]
# Хэш, который будет содержать данные для файла sitemap.xml
$sitemap[^hash::create[]]
# Перебор и подключение дополнительных модулей
$cms_block[^modules:GetModules[]]
^cms_block.menu{
	^if(-f "${self.cmsFolder}/${cms_block.path}/mod_rewrite.p"){
		^use[${self.cmsFolder}/${cms_block.path}/mod_rewrite.p;$.replace(true)]
		$header_block[^mod_rewrite:make_rewrite[]]
		^if($header_block is hash){
			$header[${header}${header_block.htaccess}]
			$sitemap[^sitemap.union[$header_block.sitemap]]
		}{
			$header[${header}${header_block}]
		}
	}
}
^header.save[/.htaccess]
# Генерируем файл sitemap.xml
^GenerateSitemap[$sitemap]
################################################################################
@GenerateSitemap[pages]
^if(def $pages){
# Создаём XML-документ
	$sitemap[^xdoc::create[urlset]]
# Прописываем ему атрибут xmlns
		^sitemap.documentElement.setAttribute[xmlns;http://www.sitemaps.org/schemas/sitemap/0.9]
# Добавляем в файл каждую страницу
	^pages.foreach[key;page]{
# Создаём Тэг url
		$url[^sitemap.createElement[url]]
		^page.foreach[name;value]{
# Создаём Тэг loc
			$tag[^sitemap.createElement[$name]]
# Прописываем значение тэга
			$tagText[^sitemap.createTextNode[$value]]
# Добавляем значение тэга
			$res[^tag.appendChild[$tagText]]
# Добавляем дочерний элемент
			$res[^url.appendChild[$tag]]
		}
# Добавляем дочерний элемент
		$res[^sitemap.documentElement.appendChild[$url]]
	}
# Сохраняем результат в файл
	^sitemap.save[/sitemap.xml;$.indent[yes]$.encoding[utf-8]]
}{
	^file:delete[/sitemap.xml;$.exception(false)]
}
################################################################################
@GetSiteSettingsValue[name]
$result[^string:sql{SELECT value FROM $self.siteSettingsTable.name WHERE name='$name'}[$.default[]]]
################################################################################
@GetSiteRedirects[]
$result[^table::sql{SELECT id, source_url, destination_url, subfolders, comment, sortir FROM $self.siteRedirectsTable.name ORDER BY sortir}]
################################################################################