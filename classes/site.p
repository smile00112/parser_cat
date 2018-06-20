################################################################################
@CLASS
site
################################################################################
@OPTIONS
locals
################################################################################
@auto[]

sql_table[catss]
sql_login[root]
sql_pass[root]
#---------------------------- Информация о классе ------------------------------
$self.className[site]
$self.classVersion[2.06]
$self.classBuildDate[11.05.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.classDescription[Сайт]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$site.defaultCityID</font>, содержащая ID города, который используется по умолчанию.</li>
			<li>Добавлена переменная <font color="red">^$site.currentCityID</font>, содержащая ID текущего города.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.05 (18.04.2018):</u></strong>
		<ol>
			<li>Доработана функция <font color="red">^@ShowTemplate</font>[filename^;params] и перенесена в корневой <strong>auto.p</strong>. Теперь через переменную <strong>params</strong> она может получить контекст выполнения шаблона.</li>
			<li>Добавлена функция <font color="red">^@ShowException[exception]</font> в корневой <strong>auto.p</strong>, отображающая информацию об ошибке по исключению <strong>(exception)</strong>.</li>
			<li>Функция <font color="red">^@CutString</font>[string^;limit^;dots] перенесена в корневой <strong>auto.p</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.04 (18.02.2018):</u></strong>
		<ol>
			<li>Удалена функция <font color="red">^@GetModulePathByName</font>[name], так как её аналог есть в классе <strong>modules.p</strong>.</li>
			<li>В функцию <font color="red">^@GetPages</font>[order^;order_type^;id_menu^;parent^;params] добавлена обработка параметра <strong>visible</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.03 (08.02.2018):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$site.currentPage.mainPageFlag</font>, указывающая на то, является ли страница текущей.</li>
			<li>Теперь переменная <font color="#cc0000">^$self.breadcrumbs</font> не обнуляется, если содержит только 1 элемент.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.02 (27.01.2018):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$site.currentPage.showBreadcrumbs</font>, отвечающая за отображение "хлебных крошек" на текущей странице.</li>
			<li>Доработана функция <font color="red">^@SetCurrentPage[pageId^;params]</font> (добавлена инициализация забытого поля keywords и если SEO-тэги у страницы пусты, то теперь они инициализируются именем сайта).</li>
			<li>Удалена функция <font color="red">^@ShowBlock[page^;visible^;template]</font>, отображающая блоки шаблона (по причине неиспользования).</li>
			<li>Удалена функция <font color="red">^@ShowReplacesField[field^;separator]</font>, возвращающая значение поля после подстановки в него нового значения (по причине неиспользования).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.01 (07.12.2017):</u></strong>
		<ol>
			<li>В функцию <font color="red">^@SetCurrentPage</font>[pageId], перенесена инициализация нескольких переменных и реализован механизм опроса классов блоков страницы для заполнения SEO полей.</li>
			<li>Удалена функция <font color="red">^@GetTitle[id]</font>, возвращающая имя страницы.</li>
			<li>Удалена функция <font color="red">^@GetKeywords[id]</font>, возвращающая ключевые слова страницы.</li>
			<li>Удалена функция <font color="red">^@GetDescription[id]</font>, возвращающая описание страницы.</li>
			<li>Переделана функция <font color="red">^@GetOpenGraphTags[params]</font>. Теперь она выозвращает хэш вместо прямого HTML кода.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.00 (18.11.2017):</u></strong>
		<ol>
			<li>Создана переменная <font color="#cc0000">self.currentCity</font>, содержащая информацию о текущем городе.</li>
			<li>В функции <font color="red">^@ShowPage</font>[page^;visible], параметр <strong>visible</strong> заменён на параметр <strong>params</strong>.</li>
			<li>Переменная <font color="#cc0000">self.contacts</font> теперь инициализируется данными текущего города. Если их нет, то городом по умолчанию (как раньше).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.99 (09.10.2017):</u></strong>
		<ol>
			<li>Переменная <font color="#cc0000">self.scriptsFolder</font> перенесена из класса <strong>cms.p</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.98 (14.07.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GenerateBreadcrumbs</font>[], которая генерирует переменную <strong>^$self.breadcrumbs</strong>, содержащую хэш с хлебными крошками на страницы.</li>
			<li>Добавлена функция <font color="red">^@ShowBreadcrumbs</font>[params], которая выводит хлебные крошки на страницу.</li>
			<li>Добавлена переменная <font color="red">^$site.currentPage.blocks</font>, содержащая список (table) блоков текущей страницы.</li>
			<li>Удалена функция <font color="red">^@GetBreadcrumbs</font>[noLinks^;showRoots], так как теперь её функции выполняет более универсальная функция <font color="red">^@ShowBreadcrumbs</font>[params].</li>
			<li>Добавлена функция <font color="red">^@GetInstalledBlocks</font>[params], которая возвращает список всех установленных модулей.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.97 (17.06.2017):</u></strong>
		<ol>
			<li>Переменная <font color="red">^$site.currentPage</font>, теперь содержит хэш полей текущей страницы вместо таблицы (Это сделано для удобства добавления полей в переменную).</li>
			<li>Добавлена переменная <font color="red">^$site.currentPage.header</font>, содержащая заголовок текущей страницы.</li>
			<li>Удалена переменная <font color="red">^$self.currentPageId</font>, содержащая ID текущей страницы, так как она же содержится в переменной <strong>$self.currentPage.id</strong>.</li>
			<li>Добавлена функция <font color="red">@SetCurrentPage[pageId]</font>, которая инициализирует переменную с полями текущей страницы.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.96 (17.12.2016):</u></strong>
		<ol>
			<li>Параметры функции<font color="red">^$self.ShowMenu</font> объединены в 1 хэш-параметр <strong>params</strong> и добавлен параметр <strong>all_parents</strong>, при передаче которого формируется хэш с таблицами страниц, ключами которого являются id родителя этих страниц.</li>
			<li>Добавлена возможность инициализации ссылки на страничку социальной сети Одноклассники.</li>
			<li>Добавлена переменная <font color="red">^$self.contacts</font>, содержащая контактную информацию из модуля CMS "Контакты".</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.95 (28.11.2016):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.mysqlString</font>, содержащая строку инициализации соединения с MySQL без параметров для переключения кодировки на сайте и в CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.94 (19.09.2016):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.social</font>, содержащая ссылки на соц. сети.</li>
			<li>Удалена функция <font color="red">^@GetAddress[]</font> и поле <font color="red">^$self.address</font> так как это поле доступно из настройки "Контакты".</li>
			<li>Удалена функция <font color="red">^@GetPhoneCode[name]</font> и поле <font color="red">^$self.phone_code</font> так как это поле доступно из настройки "Контакты".</li>
			<li>Удалена функция <font color="red">^@GetPhone[name]</font> и поле <font color="red">^$self.tel</font> так как это поле доступно из настройки "Контакты".</li>
			<li>Добавлена функция <font color="red">@InitSiteSettings[]</font>, в которую перенесена инициализация свойств класса.</li>
			<li>Удалена функция <font color="red">^@GetSiteName[]</font> так как она увеличивала кол-во обращений к таблице настроек сайта.</li>
			<li>Удалена функция <font color="red">^@GetEmail[]</font> так как она увеличивала кол-во обращений к таблице настроек сайта.</li>
			<li>Удалена функция <font color="red">^@GetDesignFlag[]</font> так как она увеличивала кол-во обращений к таблице настроек сайта.</li>
			<li>Удалена функция <font color="red">^@GetPhrase[]</font> так как она увеличивала кол-во обращений к таблице настроек сайта.</li>
			<li>Удалена функция <font color="red">^@GetTemplateName[]</font> так как она увеличивала кол-во обращений к таблице настроек сайта.</li>
			<li>Удалена функция <font color="red">^@create[]</font> так как теперь в классе <strong>site</strong> не создаются другие экземпляры классов.</li>
			<li>Удалена функция <font color="red">^@useClasses</font> так как теперь её ф-ю выполняет метод <font color="red">^@autouse[className]</font> файла <strong>auto.p</strong>.</li>
			<li>Добавлена переменная <font color="red">^$self.currentDate</font>, содержащая текущую дату и время.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.93 (08.09.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetOpenGraphTags[params]</font>.</li>
			<li>Добавлена функция <font color="red">^@GetSchemaOrgTags[params]</font>.</li>
			<li>Добавлена функция <font color="red">^@GetPageByUrl[url]</font>, возвращающая информацию о странице по url.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.92 (18.04.2016):</u></strong>
		<ol>
			<li>Изменена функция <font color="red">^@GetPagesWithBlock[name^;params]</font>.</li>
			<li>Удалена функция <font color="red">^@GetPagesByType</font>[type^;bySons^;id^;parent^;page_type^;visible].</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.91 (07.12.2015):</u></strong>
		<ol>
			<li>Обновлена (добавлена поддержка новостей) функция <font color="red">^@GetTitle[id]</font>, возвращающая имя страницы.</li>
			<li>Обновлена (добавлена поддержка новостей) функция <font color="red">^@GetKeywords[id]</font>, возвращающая ключевые слова страницы.</li>
			<li>Обновлена (добавлена поддержка новостей) функция <font color="red">^@GetDescription[id]</font>, возвращающая описание страницы.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.9 (05.02.2015):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.queue</font> - очередь (для скриптов).</li>
			<li>Добавлена функция <font color="red">^@AddToQueue</font>[text], добавляющая текст в очередь.</li>
			<li>Добавлена функция <font color="red">^@PrintQueue</font>[], возвращающая содержимое очереди.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.8 (29.08.2014):</u></strong>
		<ol>
			<li>Добавлена переменная (флаг) <font color="red">^$self.block</font>, определяющая, заблокирован ли сайт.</li>
			<li>Добавлена функция <font color="red">^@GetBlockFlag</font>[], возвращающая значение поля block сайта.</li>
			<li>Добавлена функция <font color="red">^@ChangeBlockFlag</font>[], меняющая значение поля block сайта.</li>
			<li>Добавлена функция <font color="red">^@ChangeRemoteSiteBlockFlag</font>[remoteSite], меняющая значение переменной block удалённого сайта.</li>
			<li>Добавлена функция <font color="red">^@GetRemoteSiteInfo</font>[remoteSite], возвращающая хэш с параметрами удалённого сайта.</li>
			<li>Добавлена переменная <font color="#cc0000">^$self.domain</font>, которая содержит название домена (без WWW) для текущего сайта</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.7 (25.06.2014):</u></strong>
		<ol>
			<li>Добавлена переменная (хэш) <font color="red">^$self.currentPage</font>, содержащая информацию о странице.</li>
			<li>Добавлена функция <font color="red">^@ChangeBoolField[table^;field^;id]</font>, меняющая булево поле field таблицы table.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.6 (15.03.2014):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@ShowBlock[page^;visible^;template]</font>, отображающая блоки шаблона.</li>
			<li>Добавлена функция <font color="red">^@GetTitle[id]</font>, возвращающая имя страницы.</li>
			<li>Добавлена функция <font color="red">^@GetKeywords[id]</font>, возвращающая ключевые слова страницы.</li>
			<li>Добавлена функция <font color="red">^@GetDescription[id]</font>, возвращающая описание страницы.</li>
			<li>Добавлена функция <font color="red">^@GetBreadcrumbs[]</font>, возвращающая путь по сайту от его «корня» до текущей страницы.</li>
			<li>Функция <font color="red">^@GetBlockNameById[id]</font> - перенесена в класс textext.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.5 (08.01.2014):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.widgets</font>, содержащая экземпляр класса для работы с виджетами.</li>
			<li>Добавлена функция <font color="red">^@GetDomainName[]</font>, возвращающая доменное имя сайта.</li>
			<li>Добавлена функция <font color="red">^@GetPages[order^;order_type]</font>, возвращающая список всех страниц, отсортированных по ^$order и ^$order_type.</li>
			<li>Добавлена функция <font color="red">^@GetPagesWithBlock[name^;order^;order_type]</font>, возвращающая список всех страниц, в которых содержится блок ^$name.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.4 (08.12.2013):</u></strong>
		<ol>
			<li>Добавлена информация о таблице блоков CMS в переменную <font color="red">^$self.blocksTable</font>.</li>
			<li>Добавлена функция <font color="red">^@GetModulePathByName[name]</font>, возвращающая путь к модулю по его имени.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.3 (16.11.2013):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetDesignFlag[]</font>, возвращающая значение поля design в настройках, отвечающего за отображение дизайна и переменная <font color="red">^$self.design</font>, содержащая её результат.</li>
			<li>Добавлена функция <font color="red">^@GetPhrase[]</font>, возвращающая значение поля phrase в настройках, отвечающего за фразу, которую пользователь видит вместо дизайна, и переменную <font color="red">^$self.phrase</font>, содержащая её результат.</li>
			<li>Добавлена функция <font color="red">^@GetImageExtention[path^;name]</font>, возвращающая расширение изображения в директории path с именем name.</li>
			<li>Добавлена функция <font color="red">^@Catch[exception^;name]</font>, возвращающая текст при возникновении исключения.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.2 (13.11.2013):</u></strong>
		<ol>
			<li>Теперь переменная <font color="red">^$templateFolder</font>, содержащая путь к текущему шаблону сайта, а переменная <font color="red">^$templatesFolder</font> - путь к папке с шаблонами</li>
			<li>Добавлена функция <font color="red">^@GetPagesByParent[id^;visible]</font>, возвращающая страницы по родителю</li>
			<li>Добавлена функция <font color="red">^@ShowReplacesField[field^;separator]</font>, возвращающая значение поля после подстановки в него нового значения</li>
			<li>Добавлена функция <font color="red">^@GetPageNameById[id]</font>, возвращающая имя страницы по её id</li>
			<li>Добавлена функция <font color="red">^@GetPageVisibleById[id]</font>, возвращающая видимость страницы по её id</li>
			<li>Обновлена функция <font color="red">^@GetPageUrlById[id^;skipMain]</font></li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (29.10.2013):</u></strong>
		<ol>
			<li>Добавлен объект класса <font color="red">auth</font> - авторизация сайта</li>
			<li>Добавлены переменные с информацией о классе</li>
			<li>Функция <font color="red">^@ShowTemplate[filename]</font> теперь выдает сообщение, если нет шаблона, вместо ошибки</li>
			<li>Добавлена функция <font color="red">^@GetPageParentId[id]</font> - получение самого верхнего родителя для страницы</li>
			<li>Добавлена функция <font color="red">^@GetBlockNameById[id]</font> - получение имени блока</li>
			<li>Добавлена функция <font color="red">^@GetPageParentById[id]</font> - получение родителя для страницы</li>
			<li>Обновлена функция <font color="red">^@ShowMenu[template^;parent^;page_type^;visible]</font></li>
			<li>Добавлена функция <font color="red">^@GetPageById[id] - получение информации о странице</font></li>
			<li>Добавлена функция <font color="red">^@GetPagesByType[type^;bySons^;id^;parent^;page_type^;visible] - получение страниц определённого типа</font></li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (18.07.2013):</u></strong>
		<ol>
			<li>Создан класс <font color="red">site</font> как агрегатор всех объектов сайта</li>
			<li>Добавлена переменная <font color="red">name</font> - имя сайта</li>
			<li>Добавлена переменная <font color="red">email</font> - административный e-mail</li>
			<li>Добавлен объект класса <font color="red">user</font> - пользователь сайта</li>
			<li>Добавлен метод вывода страницы <font color="red">^@ShowPage[]</font></li>
		</ol>
	</p>
]
#----------------------------- Рабочие переменные ------------------------------
# Имена SQL-таблиц
$self.menusTable[
	$.name[menus]
	$.file[menus.table]
]
$self.settingsTable[
	$.name[site_settings]
	$.file[site_settings.table]
]
$self.blocksTable[
	$.name[cmc_block]
	$.file[cmc_block.table]
]
$self.siteUsersTable[
	$.name[auth_accounts]
	$.file[auth_accounts.table]
]
# ------------------------------------------------------------------------------
# Инициализируем переменные класса
^self.InitSiteSettings[]
################################################################################
@create[]
################################################################################
@InitSiteSettings[]
^self.Include[/config.p]
# ^use[/config.p]
# Текущая дата
$self.currentDate[^date::now[]]
#utf8 cp1251
$self.mysqlString[mysql://root:root@[/var/run/mysqld/mysqld.sock]/cats]
# Строка подключения к БД
$self.connectString[$self.mysqlString?charset=^if(def $site_charset){$site_charset}{utf8}]
^connect[$self.connectString]{
# id главной страницы
	$self.mainPageId(^self.GetMainPageId[])
# id текущей страницы
	^if(def $form:p){
		$currentPageId(^form:p.int($self.mainPageId))
	}{
		$currentPageId($self.mainPageId)
	}
# Домен
	$self.domain[^self.GetDomainName[]]
# Переменная для очереди
	$self.queue[]
# Получаем настройки сайта из БД
	$settings[^hash::sql{SELECT name, value FROM $self.settingsTable.name}]
# Имя сайта
	$self.name[$settings.site_name.value]
# Административный e-mail
	$self.email[$settings.e-mail.value]
# Текущий город
	$self.defaultCityID($settings.default_city_id.value)
	^if(^cookie:cityId.int(0) == 0){
		$cookie:cityId($self.defaultCityID)
		$self.currentCityID($self.defaultCityID)
	}{
		$self.currentCityID($cookie:cityId)
	}
	$self.currentCity[^contacts:GetCities[$.cityID($self.currentCityID)]]
# Контакты
	$self.contacts[^contacts:GetAllCityContacts[$self.currentCity.id]]
	^if(!def $self.contacts){
		$self.contacts[^contacts:GetAllCityContacts[]]
	}
# Отображать дизайн
	$self.design[$settings.show_design.value]
# Фраза при отсутствии дизайна
	$self.phrase[$settings.phrase.value]
# Значение параметра block
	$self.block($settings.block.value)
# Социальные сети
	$vkParts[^settings.vk_link.value.split[/;rh]]
	$fbParts[^settings.fb_link.value.split[/;rh]]
	$okParts[^settings.ok_link.value.split[/;rh]]
	$inParts[^settings.in_link.value.split[/;rh]]
	$twitterParts[^settings.twitter_link.value.split[/;rh]]
	$googleParts[^settings.google_link.value.split[/;rh]]
	$telegramParts[^settings.telegram_link.value.split[/;rh]]
# Хэш со ссылками соц. сетей
	$self.social[
		$.fb[
			$.link[$settings.fb_link.value]
			$.account[$fbParts.0]
			$.site[$fbParts.1]
			$.title[$self.name в Facebook]
		]
		$.vk[
			$.link[$settings.vk_link.value]
			$.account[$vkParts.0]
			$.site[$vkParts.1]
			$.title[$self.name в Контакте]
		]
		$.ok[
			$.link[$settings.ok_link.value]
			$.account[$okParts.0]
			$.site[$okParts.1]
			$.title[$self.name в Одноклассниках]
		]
		$.twitter[
			$.link[$settings.twitter_link.value]
			$.account[$twitterParts.0]
			$.site[$twitterParts.1]
			$.title[$self.name в Twitter]
		]
		$.in[
			$.link[$settings.in_link.value]
			$.account[$inParts.0]
			$.site[$inParts.1]
			$.title[$self.name в Instagram]
		]
		$.google[
			$.link[$settings.google_link.value]
			$.account[$googleParts.0]
			$.site[$googleParts.1]
			$.title[$self.name в Google +]
		]
		$.telegram[
			$.link[$settings.telegram_link.value]
			$.account[$telegramParts.0]
			$.site[$telegramParts.1]
			$.title[$self.name в Telegram]
		]
	]
# Имя шаблона
	^if(def $cookie:template){
		$self.templateName[$cookie:template]
	}{
		$self.templateName[$settings.template_name.value]
	}
# Папки
	$self.scriptsFolder[/cgi-bin]
	$self.classesFolder[/classes]
	$self.templatesFolder[/tmpl]
	$self.filesFolder[/files]
	$self.templateFolder[$self.templatesFolder/$self.templateName]
	$self.apiFolder[/manage/api]
	$self.apiInfoFolder[${self.apiFolder}/info]
# Путь к файлу загрузки
	$self.filesDownloadPath[$self.filesFolder/download.html?path=]
# Пользователь
	$self.user[^user::create[]]
# Информация о текущей странице
	^self.SetCurrentPage[$currentPageId]
# Хлебные крошки
	^self.GenerateBreadcrumbs[]
}
################################################################################
@Include[file][_fd]
# Оператор @include[]. В случае отсутствия файла НЕ ВЫЗЫВАЕТ
# фатальной ошибки, а только выводит предупреждение.
^if(-f $file){
	$_fd[^file::load[text;$file]]
	$result[^process[$caller.self]{^taint[as-is][$_fd.text]}[$.file[$file]]]
}{
	$result[^process[$caller.self]{<br><font color="red"><b>Warning! Оператор ^^#5einclude[$file] не нашел файл!</b></font><br>}]
}
################################################################################
# Используется при удалённой блокировке
@GetBlockFlag[]
$result(^connect[$self.connectString]{^int:sql{SELECT value FROM $self.settingsTable.name WHERE name='block'}[$.default(0)]})
################################################################################
# Используется при удалённой блокировке
@ChangeBlockFlag[]
^connect[$self.connectString]{
	$flag(^int:sql{SELECT value FROM $self.settingsTable.name WHERE name='block'}[$.default(0)])
	^if($flag==0){$flag(1)}{$flag(0)}
	$result(^void:sql{UPDATE $self.settingsTable.name SET value=$flag WHERE name='block'})
}
################################################################################
@GetOpenGraphTags[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.defaultImage){$params.defaultImage[${self.templateFolder}/images/DefaultShareImage.png]}
^if(!def $params.locale){$params.locale[ru_RU]}
^if(!def $params.imageTitle){$params.imageTitle[Логотип $self.name]}
# ------------------------------------------------------------------------------
# Инициализация "по умолчанию" микроразметки OpenGraph
^if($ogData.CLASS_NAME ne hash){
	$REQUEST_SCHEME[$env:REQUEST_SCHEME]
	^if(!def $REQUEST_SCHEME){$REQUEST_SCHEME[$env:HTTP_X_FORWARDED_PROTOCOL]}
	$ogData[
		$.og[
			$.title[^textext:GetFixedText[$self.currentPage.title;70]]
			$.description[^textext:GetFixedText[$self.currentPage.description;200]]
			$.type[website]
			$.url[^if(def $REQUEST_SCHEME){${REQUEST_SCHEME}:}//${self.domain}${env:REQUEST_URI}]
			$.site_name[$self.name]
			$.locale[$params.locale]
		]
		$.twitter[
			$.card[summary_large_image]
		]
	]
	^if(def $self.social.twitter.account){$ogData.twitter.creator[^@${self.social.twitter.account}]}
	^if(-f $params.defaultImage){
		$NConvert[^NConvert::create[]]
		$image[^NConvert.info[$params.defaultImage]]
		$ogData.og.image[
			$.url[^if(def $REQUEST_SCHEME){${REQUEST_SCHEME}:}//${self.domain}${params.defaultImage}]
			$.width($image.iWidth)
			$.height($image.iHeight)
			$.type[$NConvert.mimeTypes.[$image.sFormat]]
			$.alt[$params.imageTitle]
		]
	}
}
# Получаем микроразметку OpenGraph от блоков страницы
^if(def $self.currentPage.blocks){
	^self.currentPage.blocks.menu{
		^try{
			$ogBlockData[^process{^^${self.currentPage.blocks.name}:GetOpenGraphData[^$.block[^^table::create[^$self.currentPage.blocks]]]}]
		}{
			$exception.handled(true)
		}
	}
}
^if(def $ogBlockData && $ogBlockData.CLASS_NAME eq 'hash'){
	^ogBlockData.foreach[key;value]{
		$ogData.[$key][^value.union[$ogData.[$key]]]
	}
}
# ------------------------------------------------------------------------------
# Вывод микроразметки OpenGraph
$templates[
	$.og[<meta property="--PROPERTY--" content="--VALUE--" />]
	$.article[<meta property="--PROPERTY--" content="--VALUE--" />]
	$.twitter[<meta name="--PROPERTY--" content="--VALUE--" />]
]
$answer[
	$.html[]
	$.prefix[]
]
^ogData.foreach[template;fields]{
	^fields.foreach[field;value]{
		^switch[$value.CLASS_NAME]{
			^case[string;int;double]{
				$answer.html[$answer.html^str_replace[$templates.[$template];$.--PROPERTY--[${template}:${field}]$.--VALUE--[$value]]^#0A]
			}
			^case[hash]{
				^value.foreach[subField;subValue]{
					^switch[$subValue.CLASS_NAME]{
						^case[string;int;double]{
							$answer.html[$answer.html^str_replace[$templates.[$template];$.--PROPERTY--[${template}:${field}^if($subField ne 'url' && $field ne 'tag'){:${subField}}]$.--VALUE--[$subValue]]^#0A]
						}
						^case[hash]{
							^subValue.foreach[subField;subValue]{
								^switch[$subValue.CLASS_NAME]{
									^case[string;int;double]{
										$answer.html[$answer.html^str_replace[$templates.[$template];$.--PROPERTY--[${template}:${field}^if($subField ne 'url'){:${subField}}]$.--VALUE--[$subValue]]^#0A]
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
^switch[$ogData.og.type]{
	^case[article]{$answer.prefix[prefix="article: http://ogp.me/ns/article#"]}
	^case[DEFAULT]{}
}
$result[$answer]
################################################################################
@GetSchemaOrgTags[params]
<script type="application/ld+json">
^{
	"@context" : "http://schema.org",
	"@type" : "Organization",
	"name" : "$self.name",
	"url" : "${env:REQUEST_SCHEME}://${self.domain}${env:REQUEST_URI}"
^if(def $self.social){,
	$counter(0)
	^self.social.foreach[key;value]{
		^counter.inc[]
		$socialLinks[$socialLinks^if(def $self.social.$key.link){^if($counter>1){,}^#0A"$self.social.$key.link"}]
	}
	"sameAs" : [$socialLinks^#0A]
}
^}
</script>
################################################################################
@ShowPage[page;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.visible){$params.visible(^int:sql{SELECT visible FROM $self.menusTable.name WHERE id=$page}[$.default(0)])}
^if($params.visible==1){
	$mod_text_extended[^text_extended::init[$page]]
	^mod_text_extended.show[$params]
}
################################################################################
@IsTableExist[table]
$result[^table::sql{SHOW TABLES LIKE '$table'}]
################################################################################
@CheckTableExist[table]
# Проверяем есть ли таблица
^if(^self.IsTable[$self.socialInfoTable]){
# Загружаем поля таблицы
	$mysql_table[^table::load[${self.classesPath}${self.socialFolder}${self.mysqlTablesPath}/${self.socialInfoFile}]]
# Создаём таблицу $table
	^create_sql_table[$table;$mysql_table]
}
################################################################################
# Создаёт SQL таблицу с именем $table_name и полями $fields
@create_sql_table[table_name;fields]
^if(def $fields){
	^fields.menu{
		$string[$string $fields.field]
	}
# Дополнительные служебные поля
	$info_fields[^table::load[${self.classesPath}${self.socialFolder}${self.mysqlTablesPath}/${self.socialInfoFile}]]
	^info_fields.menu{
		$info_string[$info_string $info_fields.field]
	}
# Создание таблицы
	^void:sql{CREATE TABLE IF NOT EXISTS $table_name ($string $info_string) DEFAULT CHARSET=cp1251}
}
################################################################################
@GetTableColumns[table]
$result[^connect[$self.connectString]{^table::sql{SHOW COLUMNS FROM $table}}]
################################################################################
@GetAddInfoFields[]
$result[sortir, creation_date, create_user_login, modify_date, modify_user_login]
################################################################################
@GetPageById[id]
$result[^table::sql{SELECT * FROM $self.menusTable.name WHERE id=$id}]
################################################################################
@GetPageByUrl[url]
$id(0)
# Инициализируем массив, который будем возвращать
$answer[
	$.type[other]
]
$parts[^url.split[/;lh]]
# Если это url новости и каталога, то вложенности 3-го уровня не будет существовать
^if(def $parts.1 && $parts.1 ne "" && !def $parts.2){
# Вдруг это новость
	$news[^news:GetNewsByUrl[$parts.1]]
	^if(def $news){
		$id($news.id_page)
		$answer.type[$news:className]
		$answer.element_id($news.id)
# Если нет
	}{
# То вдруг это каталог
		$catalog[^catalog:GetElementByUrl[$parts.1]]
		^if(def $catalog){
			$id(^textext:GetPageIdByBlockId[$catalog.block_id])
			$answer.type[$catalog:className]
			$answer.element_id($catalog.id)
		}
	}
}
# Если что-то нашли
^if($id>0){
	$answer.page[^self.GetPageById[$id]]
}{
# Ну а если нет
	$answer.page[^table::sql{SELECT * FROM $self.menusTable.name WHERE uri='$url'}]
}
	$result[$answer]
################################################################################
@GetPageNameById[id]
$result[^string:sql{SELECT name FROM $self.menusTable.name WHERE id=$id}[$.default[Удалён]]]
################################################################################
@GetPageEmailById[id]
$result[^string:sql{SELECT email FROM $self.menusTable.name WHERE id=$id}]
################################################################################
@GetPageVisibleById[id]
$result[^int:sql{SELECT visible FROM $self.menusTable.name WHERE id=$id}[$.default(0)]]
################################################################################
@GetAddInfoValues[table;sortir;username]
$now[^date::now[]]
^if(!def $username){$username[$self.user.login]}
# Определяем значение поля sortir
^if(!def $sortir){$sortir(^eval(^int:sql{SELECT count(*) FROM $table}*10+10))}
# Выводим результат
$result['$sortir', '^now.sql-string[]', '$username', '^now.sql-string[]', '$username']
################################################################################
@GetPageUrlById[id;skipMain]
$url[^string:sql{SELECT uri FROM $self.menusTable.name WHERE id=$id}[$.default[]]]
$mainpage(^int:sql{SELECT mainpage FROM $self.menusTable.name WHERE id=$id}[$.default(0)])
^if($mainpage==1 && !def $skipMain){$result[/]}{
	^if(def $mainpage && def $url){$result[$url]}{$result[?p=$id]}
}
################################################################################
@GetMainPageId[]
{!!!!!!!!!!!!!!}
$result(^connect[$self.connectString]{^int:sql{SELECT id FROM $self.menusTable.name WHERE mainpage=1}})
################################################################################
@GetPageParentById[id]
$result(^int:sql{SELECT parent FROM $self.menusTable.name WHERE id=$id}[$.default(0)])
################################################################################
@GetPageParentId[id]
$res($id)
^while($res>0){
	$parent($res)
	$res(^self.GetPageParentById[$parent])
}
$result($parent)
################################################################################
@ShowHeader[]
^ShowTemplate[/${self.templateFolder}/header.html]
################################################################################
@ShowMenu[params;userVars]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.template){$params.template[main.html]}
^if(!def $params.parent){$params.parent(0)}
^if(!def $params.page_type){$params.page_type[a]}
^if(!def $params.visible){$params.visible(1)}
^if(!def $params.all_parents){$params.all_parents(false)}
^if(!def $params.noPages){$params.noPages(false)}
^if(!$params.noPages){
	$pages[^table::sql{
		SELECT *
		FROM $self.menusTable.name
		WHERE
			id_menu='$params.page_type'
			AND visible=$params.visible
			^if(!$params.all_parents){AND parent=$params.parent}
		ORDER BY sortir
	}]
}
^if(def $pages || $params.noPages){
	^if(def $params.all_parents && !$params.noPages){
		$hashPages[^hash::create[]]
		^pages.menu{
			^if(!^hashPages.contains[$pages.parent]){
				$parent($pages.parent)
				$hashPages.[$parent][^pages.select($pages.parent==$parent)]
			}
		}
	}
	^ShowTemplate[${self.templateFolder}/menus/${params.template}]
	^try{
		^if(!$params.all_parents){
			^self.ShowMenuTemplate[$pages;$params.parent;$userVars]
		}{
			^self.ShowMenuTemplate[$hashPages]
		}
	}{
		^self.Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]
	}
}
################################################################################
@GetPagesByParent[id;visible]
^if(!def $visible){$visible(1)}
$result[^table::sql{SELECT * FROM $self.menusTable.name WHERE parent=$id AND visible=$visible ORDER BY sortir}]
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
@Catch[exception;name]
$exception.handled(1)
$name
<p align="center">Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
<p align="center">Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
################################################################################
@GetDomainName[siteName]
^if(!def $siteName){$siteName[$env:SERVER_NAME]}
# Определяем таблицу с подстановками
$rep[^table::create{from	to
/
www.	}]
# Инициализируем переменную $domain
$domain[$siteName]
# Получаем необходимое название домена
$result[^domain.replace[$rep]]
################################################################################
@GetPages[order;order_type;id_menu;parent;params]
^if(!def $order){$order[id]}
^if(!def $order_type){$order_type[asc]}
^if($id_menu.CLASS_NAME eq 'string' && ^id_menu.length[]>0){
	$id_menu[^explode[,;$id_menu]]
	$menus[^hash::create[]]
	$counter(0)
	^id_menu.foreach[key;value]{
		^counter.inc[]
		$menus.[$counter][^value.trim[]]
	}
	$id_menu[]
	^menus.foreach[key;value]{
		$id_menu[${id_menu},'$value']
	}
	$id_menu[^id_menu.trim[left;,]]
}
$result[^table::sql{
	SELECT *, head AS title
	FROM $self.menusTable.name
	WHERE
		1=1
		^if(def $id_menu){ AND id_menu=$id_menu}
		^if(def $parent){ AND parent=$parent}
		^if(def $params.page_ids){ AND id IN ($params.page_ids)}
		^if(def $params.visible){ AND visible=$params.visible}
	ORDER BY $order $order_type
}]
################################################################################
@GetPagesWithBlock[name;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[id]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	$result[^table::sql{
		SELECT *
		FROM $self.menusTable.name
		WHERE id IN (SELECT idpage FROM $textext:pageBlocksTable.name WHERE pref_block='$name')
		^if(def $params.exclude){ AND id NOT IN ($params.exclude)}
		^if(def $params.visible){ AND visible=$params.visible}
		^if(def $params.menu){ AND id_menu="$params.menu"}
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
@GetInstalledBlocks[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[id]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	$result[^table::sql{
		SELECT *
		FROM $self.blocksTable.name
		WHERE 1=1
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
@GenerateBreadcrumbs[]
$counter(1)
$self.breadcrumbs[
	$.[$counter][
		$.name[$self.currentPage.name]
		$.url[/${self.currentPage.uri}/]
		$.module[page]
		$.opened(true)
	]
]
^if($self.currentPage.mainpage){$self.breadcrumbs.[$counter].main(true)}
# Получаем хлебные крошки от блоков страницы
^self.currentPage.blocks.menu{
	^try{
		$blockBreadcrumbs[^process{^^${self.currentPage.blocks.name}:GetBreadcrumbs[$self.currentPage.uri]}]
	}{
		$exception.handled(true)
	}
}
^if(def $blockBreadcrumbs && $blockBreadcrumbs.CLASS_NAME eq hash){
	$self.breadcrumbs.[$counter].module[$blockBreadcrumbs.1.module]
	^self.breadcrumbs.[$counter].delete[opened]
	$newPosition(^eval(^blockBreadcrumbs.count[]+1))
	$self.breadcrumbs.[$newPosition][^hash::create[$self.breadcrumbs.[$counter]]]
	^self.breadcrumbs.delete[$counter]
	$self.breadcrumbs[^self.breadcrumbs.union[$blockBreadcrumbs]]
	$counter($newPosition)
}
# Добавляем всех предков страницы
$parent($self.currentPage.parent)
^while($parent>0){
	^counter.inc[]
	$curPage[^self.GetPageById[$parent]]
	$self.breadcrumbs.[$counter][
		$.name[$curPage.name]
		$.url[/^self.GetPageUrlById[$parent;true]/]
		$.module[page]
	]
	^if($curPage.mainpage){$self.breadcrumbs.[$counter].main(true)}
	$parent(^self.GetPageParentById[$parent])
}
# Сортируем хэш
^self.breadcrumbs.sort[name;]{$name}[desc]
################################################################################
@ShowBreadcrumbs[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.template){$params.template[breadcrumbs.html]}
^if(def $self.breadcrumbs && $self.currentPage.showBreadcrumbs){
	^ShowTemplate[/${self.templateFolder}/${params.template}]
	^ShowBreadcrumbsTemplate[params]
}
################################################################################
# Инвертирует значение поля
@ChangeBoolField[table;field;id]
$res(^int:sql{SELECT $field FROM $table WHERE id=$id})
^if($res>0){$value(0)}{$value(1)}
$res[^void:sql{UPDATE $table SET $field=$value WHERE id=$id}]
$result($value)
################################################################################
@GetRemoteSiteInfo[remoteSite]
^if(def $remoteSite){
	$siteName[^remoteSite.replace[www.;]]
# 	^curl:options[$.library[libcurl.so.4]]
# 	$res[^curl:load[
# 		$.url[https://${siteName}${self.apiInfoFolder}/]
# 		$.mode[text]
# 		$.timeout(2)
# 	]]
	^try{
		$res[^table::load[http://${siteName}${self.apiInfoFolder}/]]
		$answer[^res.hash[field][value][$.type[string]]]
	}{
		$exception.handled(true)
		^try{
			$res[^table::load[http://www.${siteName}${self.apiInfoFolder}/]]
			$answer[^res.hash[field][value][$.type[string]]]
		}{
			$exception.handled(true)
			$answer[
				$.error(1)
				$.error_description[http://${siteName}${self.apiInfoFolder}/ - Ошибка загрузки]
			]
		}
	}
	$result[$answer]
}{
	$result[
		$.error(1)
		$.description[Неизвестный сайт]
	]
}
################################################################################
@ChangeRemoteSiteBlockFlag[remoteSite]
$res(0)
^if(def $remoteSite){
	$siteName[^remoteSite.replace[www.;]]
	^try{
		$answer[^file::load[text;http://${siteName}${self.apiActionsFolder}/block.html]]
		$res($answer.text)
	}{
		$exception.handled(1)
		^try{
			$answer[^file::load[text;http://www.${siteName}${self.apiActionsFolder}/block.html]]
			$res($answer.text)
		}{$exception.handled(1)}
	}
}
$result($res)
################################################################################
@GetBackLink[block_id]
$referer[$env:HTTP_REFERER]
$inside[^referer.pos[$env:SERVER_NAME]]
^if($inside == -1){
	^try{
		$blockName[^string:sql{SELECT pref_block FROM text_ext WHERE id=$block_id}]
		^switch[$blockName]{
			^case[news;catalog]{
				^use[${blockName}.p;$.replace(true)]
				$referer[^process[$caller.self]{^taint[as-is][^^${blockName}:GetBackLink[$block_id]]}]
			}
			^case[DEFAULT]{$referer[/^self.GetPageUrlById[^textext:GetPageIdByBlockId[$block_id]]/]}
}
	}{
		$exception.handled(true)
		$referer[Не найдена функция GetBackLink]
	}
}{
	$referer[^referer.replace[http://;]]
	$referer[^referer.replace[$env:SERVER_NAME;]]
}
$result[$referer]
################################################################################
@AddToQueue[text]
$self.queue[$self.queue $text]
################################################################################
@PrintQueue[]
$result[$self.queue]
################################################################################
@SetCurrentPage[pageId;params]
^if($pageId>0){
	$currentPage[^connect[$self.connectString]{^self.GetPages[;;;;$.page_ids[$pageId]]}]
	$currentPage[^currentPage.hash[id]]
	$self.currentPage[$currentPage.[$pageId]]
	$self.currentPage.title[$self.currentPage.head]
	$self.currentPage.keywords[$self.currentPage.keywords]
	$self.currentPage.description[$self.currentPage.descript]
	$self.currentPage.header[$self.currentPage.name]
	$self.currentPage.fullUrl[${self.currentPage.uri}]
	$self.currentPage.url[^if($self.currentPage.mainpage eq 1){/}{/${self.currentPage.uri}/}]
	$self.currentPage.blocks[^textext:GetPageBlocks[$self.currentPage.id]]
	$self.currentPage.showBreadcrumbs(true)
	^if($self.currentPage.id != $self.mainPageId){
		$self.currentPage.mainPageFlag(false)
	}{
		$self.currentPage.mainPageFlag(true)
	}
	^if(def $self.currentPage.blocks){
		^self.currentPage.blocks.menu{
			^try{
				$SEOData[^process{^^${self.currentPage.blocks.name}:GetSEOData[]}]
			}{
				$exception.handled(true)
			}
		}
		^if(def $SEOData){
			$self.currentPage[^SEOData.union[$self.currentPage]]
		}
	}
}{
	$self.currentPage[
		$.id(0)
	]
	^if(def $params.header){$self.currentPage.header[$params.header]}
	^if(def $params.showBreadcrumbs){$self.currentPage.showBreadcrumbs($params.showBreadcrumbs)}{$self.currentPage.showBreadcrumbs(false)}
	^if(def $params.title){$self.currentPage.title[$params.title]}
}
^if(!def $self.currentPage.title){$self.currentPage.title[$self.name]}
^if(!def $self.currentPage.keywords){$self.currentPage.keywords[$self.name]}
^if(!def $self.currentPage.description){$self.currentPage.description[$self.name]}
################################################################################
@CheckURL[url;params][answer]
^if(!def $params){^hash::create[$params]}
^if(def $url){
	^try{
		^curl:options[$.library[libcurl.so.4]]
		$answer[^curl:load[
			$.url[^taint[as-is;$url]]
			$.mode[binary]
			$.response-charset[utf-8]
			$.timeout(2)
		]]
		$result[
			$.error(false)
			$.text[Файл загружен]
			$.file[$answer]
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
		$.text[Не передан URL]
	]
}
################################################################################