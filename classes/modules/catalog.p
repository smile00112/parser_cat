################################################################################
@CLASS
catalog
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
$self.imagesWidth.big(^textext:GetOptionValue[big_images_width;$self.blockId;$self.imagesWidth.big])
$self.imagesWidth.small(^textext:GetOptionValue[small_images_width;$self.blockId;$self.imagesWidth.small])
$self.settings.template[^textext:GetOptionValue[template;$self.blockId;$self.settings.template]]
^if(def $self.settings.template){
	$self.catalogFolder[${self.catalogFolder}/${self.settings.template}]
}
$self.settings.joint(^textext:GetOptionValue[joint;$self.blockId;$self.settings.joint])
$self.settings.showAll(^textext:GetOptionValue[show_all;$self.blockId;$self.settings.showAll])
$self.settings.showFilters(^textext:GetOptionValue[show_filters;$self.blockId;$self.settings.showFilters])
$self.settings.showRelated(^textext:GetOptionValue[show_related;$self.blockId;$self.settings.showRelated])
$self.settings.showStep(^textext:GetOptionValue[show_step;$self.blockId;$self.settings.showStep])
$self.settings.saveChildsStep(^textext:GetOptionValue[save_childs_step;$self.blockId;$self.settings.saveChildsStep])
$self.settings.showComments(^textext:GetOptionValue[show_comments;$self.blockId;$self.settings.showComments])
$self.settings.showColors(^textext:GetOptionValue[show_colors;$self.blockId;$self.settings.showColors])
$self.settings.showSizes(^textext:GetOptionValue[show_sizes;$self.blockId;$self.settings.showSizes])
$self.settings.showStickers(^textext:GetOptionValue[show_stickers;$self.blockId;$self.settings.showStickers])
$self.settings.showCurrencies(^textext:GetOptionValue[show_currencies;$self.blockId;$self.settings.showCurrencies])
^if($self.settings.showColors){$self.colors[^self.GetColors[]]}
^if($self.settings.showSizes){$self.sizes[^self.GetSizes[]]}
^if($self.settings.showStickers){$self.stickers[^self.GetStickers[]]}
^if($self.settings.showCurrencies){
	$self.currencies[^self.GetCurrencies[]]
	$self.currentCurrency[^self.currencies.select($self.currencies.id == 1)]
}
^if($self.settings.showComments){
	$self.comments[^comments::create[]]
}
$self.elementsPerPage(^textext:GetOptionValue[elements_per_page;$self.blockId;$self.elementsPerPage])
$self.settings.shippingDate[^textext:GetOptionValue[shipping_date;$self.blockId;$self.settings.shippingDate]]
$self.settings.shippingDateMin[^textext:GetOptionValue[shipping_date_min;$self.blockId;$self.settings.shippingDateMin]]
$self.settings.shippingDateMax[^textext:GetOptionValue[shipping_date_max;$self.blockId;$self.settings.shippingDateMax]]
$self.settings.showServices(^textext:GetOptionValue[show_services;$self.blockId;$self.settings.showServices])
################################################################################
@auto[]
$self.classVersion[2.01]
$self.classBuildDate[14.05.2018]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[catalog]
$self.classDescription[Класс модуля "Каталог"]
$self.classModuleDescription[Каталог]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Добавлена Функция <font color="red">^@GetElementsWithoutLost</font>[params], возвращающая все элементы каталога, которые не являются потерянными.</li>
			<li>Добавлена переменная <font color="red">^$self.tmpFolder</font>, которая содержит путь к временным файлам каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 2.00 (23.04.2018):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.settings.showServices</font>, которая отвечает за отображение пункта интеграции со сторонними сервисами.</li>
			<li>Добавлена таблица <font color="red">^$self.ymlSettingsTable.name</font>, которая хранит список настроек для "Товаров и услуг" Яндекса.</li>
			<li>Добавлена Функция <font color="red">^@GetYMLSettings</font>[params], возвращающая настройки для генерации YML - файла (Товары и цены Яндекса).</li>
			<li>Добавлена Функция <font color="red">^@SaveYMLSetting</font>[setting^;value], сохраняющая значение <strong>value</strong> настройки <strong>setting</strong> YML - файла (Товары и цены Яндекса).</li>
			<li>Добавлена Функция <font color="red">^@UpdateYML</font>[params], сохраняющая YML - файл (Товары и цены Яндекса).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.99 (10.03.2018):</u></strong>
		<ol>
			<li>Добавлена таблица <font color="red">^$self.catalogStickersTable.name</font>, которая хранит список стикеров каталога.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogStickersColorsTable.name</font>, которая хранит список цветов стикеров каталога.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogStickersRelationsTable.name</font>, которая хранит связи элементов и стикеров каталога.</li>
			<li>Добавлены Функции для работы со стикерами каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.98 (01.03.2018):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.settings.shippingDate</font>, которая отвечает за дату отгрузки товара по умолчанию.</li>
			<li>Добавлена переменная <font color="red">^$self.settings.shippingDateMin</font>, которая отвечает за минимальную дату отгрузки товара (при выборе пользователем).</li>
			<li>Добавлена переменная <font color="red">^$self.settings.shippingDateMax</font>, которая отвечает за максимальную дату отгрузки товара (при выборе пользователем).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.97 (14.02.2018):</u></strong>
		<ol>
			<li>Добавлена Функция <font color="red">^@GetFileRegions</font>[params], возвращающая хэш регионов на основе полей (для файла синхронизации).</li>
			<li>Добавлена таблица <font color="red">^$self.catalogUnitsTable.name</font>, которая хранит единицы измерения товаров каталога.</li>
			<li>Добавлена Функция <font color="red">^@GetUnits</font>[params], возвращающая единицы измерения товара.</li>
			<li>Доработана Функция <font color="red">^@UpdateFile</font>[file^;block_id^;params]. Добавлена возможность синхронизации по частям, синхронизация цен по регионам, синхронизация единиц измерения и дополнительные счётчики синхронизации.</li>
			<li>Переделан импорт каталога из файла. Теперь он поддерживает синхронизацию файла импорта по частям (сделано это из-за того, что если файл большой, то не хватает времени выполнения скрипта его обработать).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.96 (03.02.2018):</u></strong>
		<ol>
			<li>Функция <font color="red">^@GetOneOrder</font>[user_id^;order_id], переделана и переименована в <font color="red">^@GetOrders</font>[params].</li>
			<li>Функция <font color="red">^@GetOrderArch</font>[order_id], переделана и переименована в <font color="red">^@GetArchiveOrders</font>[params].</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.95 (27.01.2018):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetSEOData</font>[], инициализирующая переменную <strong>^$site.currentPage</strong> данными SEO полей.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.94 (18.01.2018):</u></strong>
		<ol>
			<li>Удалена функция <font color="red">^@ShowNotRegForm</font>[].</li>
			<li>Удалена функция <font color="red">^@ShowUpdateInfo</font>[].</li>
			<li>Удалена функция <font color="red">^@ShowFavorites</font>[].</li>
			<li>В функции <font color="red">^@ShowBasket</font>[session_id] параметр <strong>session_id</strong> заменён на <strong>params</strong>.</li>
			<li>В функции <font color="red">^@ShowOrder</font>[session_id] параметр <strong>session_id</strong> заменён на <strong>params</strong>.</li>
			<li>В функции <font color="red">^@SendMail</font>[userId^;orderId^;email^;tmpl^;params] все параметры заменены на <strong>params</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.93 (12.12.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetBasketInfo</font>[session_id], возвращающая информацию о текущем содержимом корзины.</li>
			<li>Доработана функция <font color="red">^@GetMainImage</font>[element_id^;params]: теперь поддерживает тип вывода и перехватывает ошибку выполнения.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.92 (24.11.2017):</u></strong>
		<ol>
			<li>Переименована и переработана функция <font color="red">^@GetCityPrice</font>[element_id].</li>
			<li>Переделана функция <font color="red">^@GetPrice</font>[params], возвращающая цену элемента.</li>
			<li>В функцию <font color="red">^@GetElements</font>[params], добавлен параметр <strong>type</strong>, который управляет типом возвращаемого результата.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.91 (02.11.2017):</u></strong>
		<ol>
			<li>Добавлена поддержка цветов.</li>
			<li>Добавлена поддержка размеров.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.9 (10.10.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetOpenGraphData</font>[params], возвращающая массив (hash) с данными OpenGraph разметки блока текущей страницы.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogCurrenciesTable.name</font>, которая хранит список валют каталога.</li>
			<li>Добавлена функция <font color="red">^@GetCurrencies</font>[params], возвращающая список валют каталога.</li>
			<li>Добавлена переменная <font color="red">^$self.settings.showCurrencies</font>, которая отвечает за отображение валюты элемента каталога.</li>
			<li>Добавлена переменная <font color="red">^$self.currentCurrency</font>, которая содержит строку таблицы с данными о текущей валюте.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.89 (03.10.2017):</u></strong>
		<ol>
			<li>Добавлена поддержка размеров товара.</li>
			<li>Добавлена поддержка цветов товара.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.88 (22.09.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@RedirectElement</font>[elementIDs^;redirectValue^;params], сохраняющая значение <strong>redirectValue</strong> для <strong>elementIDs</strong> в поле <strong>redirect</strong>.</li>
			<li>Добавлена функция <font color="red">^@GeneratePromoCode</font>[], которая генерирует промо-код для заказа.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.87 (29.08.2017):</u></strong>
		<ol>
			<li>Доработана функция <font color="red">^@DeleteElement</font>[element_id][childs]. Исправлена ошибка рекурсивной работы объявлением переменной <strong>childs</strong> локальной.</li>
			<li>Доработана функция <font color="red">^@SetVisible</font>[element_id^;value^;params][childs]. Теперь она может принимать устанавливаемое значение и по умолчанию работает рекурсивно.</li>
			<li>Теперь в шаблоны не передаётся переменная <strong>self</strong>, так как вместо неё нужно использовать переменную <strong>caller</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.86 (17.08.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@DeleteBlock</font>[blockId], удаляющая блок страницы.</li>
			<li>Доработана функция <font color="red">^@DeleteElement</font>[element_id]. Теперь она удаляет не только элемент, но и всех его потомков.</li>
			<li>Добавлена переменная <font color="red">^$self.elementTypes</font>, содержащая описания элементов блока.</li>
			<li>Добавлена функция <font color="red">^@LinkElement</font>[elementIDs^;parentID] привязывающая элемент (или список элементов) <strong>elementIDs</strong> к родителю <strong>parentID</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.85 (14.07.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetBreadcrumbs</font>[pageUrl], возвращающая массив (hash) с хлебными крошками блока текущей страницы.</li>
			<li>Добавлена функция <font color="red">^@Search</font>[searchString^;params], возвращающая элементы, соответствующие строке поиска <strong>searchString</strong>.</li>
			<li>Добавлено поле <font color="red">step</font>, содержащее шаг для изменения количества элементов каталога при их покупке.</li>
			<li>Добавлена функция <font color="red">^@SaveElementStep</font>[element_id^;value^;params], сохраняющая поле <strong>step</strong> для <strong>element_id</strong> (и всех его потомках при <strong>^$params.withChilds</strong> eq true).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.84 (02.05.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@SwitchView</font>[action], переключающая вид каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.83 (31.03.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@AddToCompare</font>[elementId], добавляющая в файл ID элемента для сравнения.</li>
			<li>Добавлена функция <font color="red">^@RemoveFromCompare</font>[elementId], удаляющая из файла ID элемента для сравнения.</li>
			<li>Добавлена функция <font color="red">^@CheckComapare</font>[elementId], проверяющая, добавлен ли ID элемента в сравнение.</li>
			<li>Добавлена функция <font color="red">^@ShowCompare</font>[params], которая выводит шаблон сравнения элементов.</li>
			<li>Добавлена функция <font color="red">^@GetCompareElements</font>[params], которая выводит таблицу с ID элементов для сравнения.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.82 (23.03.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@RemoveAllRelateds</font>[element_id], удаляющая все сопутствующие товары для элемента <strong>element_id</strong>.</li>
			<li>Разделы, в которых есть выделенные элементы, теперь открыты.</li>
			<li>В разделе <strong>"Сопутствующие товары"</strong> добавлена кнопка <strong>"Удалить все"</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.81 (01.03.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetElementTexts</font>[element_id], возвращающая верхний и нижний текст для элемента <strong>element_id</strong>.</li>
			<li>Добавлена функция <font color="red">^@SaveElementText</font>[element_id^;position^;value], сохраняющая верхний и нижний (<strong>position</strong>) текст (<strong>value</strong>) для элемента (<strong>element_id</strong>).</li>
			<li>Добавлены кнопки в интерфейс раздела для редактирования верхнего и нижнего текста элемента.</li>
			<li>Добавлена функция <font color="red">^@InsertExpandField</font>[params], добавляющая дополнительное поле элемента каталога.</li>
			<li>Добавлена функция <font color="red">^@DeleteExpandField</font>[field], удаляющая дополнительное поле элемента каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.80 (11.02.2017):</u></strong>
		<ol>
			<li>В функции <font color="red">^@AddProductToBasket</font>[session_id^;id^;count] теперь можно не только перезаписывать значение, но и суммировать его, управляя этим через параметр <strong>^$reset</strong>.</li>
			<li>Добавлена переменная <font color="red">^$self.basketFilesFolder</font>, содержащая путь к обработчикам корзины.</li>
			<li>Удалена дублирующаяся переменная <font color="red">^$self.minOrderSumm</font>.</li>
			<li>Удалена дублирующаяся переменная <font color="red">^$self.basketFolder</font>.</li>
			<li>Удалена дублирующаяся переменная <font color="red">^$self.basketAddFile</font>.</li>
			<li>Удалена дублирующаяся переменная <font color="red">^$self.orderFile</font>.</li>
			<li>Удалена дублирующаяся переменная <font color="red">^$self.basketFiles</font>.</li>
			<li>Добавлена функция <font color="red">^@RecalcPartsPrices</font>[params], которая пересчитывает цены элементов, которые состоят из частей.</li>
			<li>Реализован автоматический пересчёт цен при синхронизации каталога по артикулу у тех элементов, которые состоят из частей.</li>
			<li>Функция <font color="red">^@CropImage</font>[image_id^;params] теперь обрезает не только маленькую копию изображения, но и большую тоже.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.79 (09.02.2017):</u></strong>
		<ol>
			<li>Добавлена поддержка сопутствующих товаров каталога.</li>
			<li>Добавлена переменная <font color="red">^$self.settings.showRelated</font>, которая отвечает за отображение сопутствующих товаров элемента каталога.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogRelatedsTable.name</font>, которая хранит список сопутствующих товаров каталога.</li>
			<li>Добавлена функция <font color="red">^@ToggleRelated</font>[element_id^;related_id], которая добавляет или удаляет связь сопутствующего товара.</li>
			<li>В таблице <font color="red">^$self.catalogFiltersTable.name</font>, имя поля <strong>catalog_id</strong> изменено на <strong>element_id</strong>.</li>
			<li>Функции <font color="red">^@AddFilter</font>[catalog_id^;filter] и <font color="red">^@RemoveFilter</font>[catalog_id^;filter] объединены в ф-ю <font color="red">^@ToggleFilter</font>[element_id^;filter].</li>
			<li>Удалена неиспользуемая функция <font color="red">^@GetAccessories</font>[pageId].</li>
			<li>Удалена неиспользуемая функция <font color="red">^@CheckAccessories</font>[catalog_id^;accessory_id].</li>
			<li>Удалена неиспользуемая функция <font color="red">^@SaveAccessories</font>[catalog_id^;accessories].</li>
			<li>Удалена неиспользуемая функция <font color="red">^@GetAccessoriesById</font>[catalog_id].</li>
			<li>Удалена дублирующая функция <font color="red">^@GetCatalogInfo</font>[block_id]. При этом функция с таким же названием и назначением присутствует.</li>
			<li>Добавлена функция <font color="red">^@GetElementsRelateds</font>[params], возвращающая список сопутствующих товаров.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.78 (02.02.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GenerateHtaccessRules</font>[], которая добавляет записи блока в файл <strong>.htaccess</strong>.</li>
			<li>В функции <font color="red">^@GetElements[params]</font> теперь если не передаётся параметр parent, то он и не учитывается в запросе (раньше он равнялся 0).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.77 (26.01.2017):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.settings.showFilters</font>, которая отвечает за отображение фильтров в разделах каталога.</li>
			<li>Добавлена функция <font color="red">^@GetExpandFields</font>[], которая возвращает список дополнительных полей каталога.</li>
			<li>Добавлена функция <font color="red">^@GetFilterFields</font>[], которая возвращает список полей, которые могут быть фильтрами каталога.</li>
			<li>Добавлена функция <font color="red">^@GetElementsFilters</font>[params], которая возвращает связи разделов каталога с их фильтрами.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogExpandFieldsTable.name</font>, которая хранит список дополнительных полей каталога.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogFiltersTable.name</font>, которая хранит список фильтров каталога.</li>
			<li>Добавлена таблица <font color="red">^$self.catalogFilterFieldsTable.name</font>, которая хранит список полей, которые можно использовать как фильтры каталога.</li>
			<li>Добавлена функция <font color="red">^@AddFilter</font>[catalog_id^;filter], которая добавляет фильтр <strong>filter</strong> для элемента <strong>catalog_id</strong> каталога.</li>
			<li>Добавлена функция <font color="red">^@RemoveFilter</font>[catalog_id^;filter], которая удаляет фильтр <strong>filter</strong> для элемента <strong>catalog_id</strong> каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.76 (18.01.2017):</u></strong>
		<ol>
			<li>В интерфейс каталога добавлена информация о количестве элементов каталога и функции синхронизации объединены в одну пиктограмму.</li>
			<li>Добавлена возможность пакетной синхронизации одного из 3 (title, keywords, description) полей элемента из текстового файла.</li>
			<li>Добавлена функция <font color="red">^@GetCatalogInfo</font>[params], которая возвращает количественную информацию о элементах каталога.</li>
			<li>Добавлена функция <font color="red">^@UpdateFieldByFile</font>[field^;file^;params], которая инициализирует поле <strong>field</strong> строками из файла <strong>file</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetElementsWithChilds[params]</font>, которая возвращает все вложенные элементы в раздел (для синхронизации поля из файла).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.75 (01.11.2016):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.settings.showAll</font>, которая отвечает за отображение всех элементов каталога на странице.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.74 (10.09.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetElementByUrl</font>[url^;params], которая возвращает элемент по его <strong>url</strong> (создана для работы через ajax).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.73 (18.04.2016):</u></strong>
		<ol>
			<li>Добавлена переменная <strong>self.settings.showСomponents</strong>, которая отвечает за отображение дочерних элементов у элемента каталога в CMS.</li>
			<li>Добавлена переменная <strong>self.settings.showNew</strong>, которая отвечает за отображение новинок у элементов каталога в CMS.</li>
			<li>Добавлена переменная <strong>self.settings.showStock</strong>, которая отвечает за отображение акции у элементов каталога в CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.72 (01.04.2016):</u></strong>
		<ol>
			<li>Добавлена переменная <strong>self.settings.showParts</strong>, которая отвечает за отображение поля <strong>parts</strong> в CMS.</li>
			<li>Добавлена функция <font color="red">^@ParseParts</font>[str], которая используется для получения id и количества товаров, из которых состоит составной товар.</li>
			<li>В функции <font color="red">^@OrderBasket</font>[user_id^;id_session^;extra_fields] добавлена новая переменная <strong>^$extra_fields</strong> и убрана <strong>^$dostavka</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.71 (24.03.2016):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@ImportFile</font>[file^;block_id], которая загружает данные в каталог из файла <strong>file</strong> в блок <strong>block_id</strong>.</li>
			<li>Добавлена переменная <strong>self.settings.showParent</strong>, которая отвечает за отображение поля <strong>parent</strong> в CMS.</li>
			<li>Добавлена переменная <strong>self.settings.showId</strong>, которая отвечает за отображение поля <strong>ID</strong> в CMS.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.7 (01.12.2015):</u></strong>
		<ol>
			<li>Добавлены переменные для проверки класса разделом <strong>check</strong> модуля <strong>siteclass</strong>.</li>
			<li>Добавлена переменная <strong>self.settings.joint</strong>, которая отвечает за переключение отображения в совмещённый вид.</li>
			<li>Оптимизирована работа функции <font color="red">^@Show</font>[], которая выводит содержимое каталога.</li>
			<li>Добавлена функция <font color="red">^@GetElementPageCount</font>[elementId^;blockId^;params], которая возвращает страницу элемента для совмещённого режима.</li>
			<li>Добавлена переменная <strong>self.settings.template</strong>, которая отвечает за путь к шаблону.</li>
			<li>Добавлена переменная <strong>self.settings.showComments</strong>, которая отвечает за отображение комментариев.</li>
			<li>Добавлена переменная <strong>self.comments</strong>, которая содержит экземпляр класса <strong>comments.p</strong>.</li>
			<li>В функции <font color="red">^@SetMainImage</font>[image_id], исправлена ошибка, появляющаяся при условии отстутствия главного изображения.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.6 (02.10.2015):</u></strong>
		<ol>
			<li>Переделаны функции для работы с корзиной (через <strong>hashfile</strong> вместо таблицы <strong>basket</strong>).</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.5 (14.08.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetElementTitle</font>[id], которая возвращает title элемента по его id.</li>
			<li>Добавлена функция <font color="red">^@GetElementKeywords</font>[id], которая возвращает keywords элемента по его id.</li>
			<li>Добавлена функция <font color="red">^@GetElementDescription</font>[id], которая возвращает description элемента по его id.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.4 (25.05.2015):</u></strong>
		<ol>
			<li>Добавлены функции для работы с аксессуарами</li>
			<li>Добавлена функция <font color="red">^@GetElementUrlById</font>[id], которая возвращает адрес элемента по его id.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.3 (30.01.2015):</u></strong>
		<ol>
			<li>Добавлена поддержка 2 галереи</li>
			<li>Добавлена поддержка "Избранного" (favorites)</li>
			<li>Убрано наследование от класса site</li>
			<li>Добавлена функция <font color="red">^@GetSearchedGoods</font>[searchString^;cpage^;noContent], которая возвращает список элементов, содержащих ^$searchString.</li>
			<li>Добавлена функция <font color="red">^@GetSearchedGoodsByName</font>[searchString^;cpage], которая возвращает список элементов, содержащих ^$searchString в имени элемента.</li>
			<li>Добавлена функция <font color="red">^@GetSearchedGoodsByArtikul</font>[searchString^;cpage], которая возвращает список элементов, содержащих ^$searchString в артикуле элемента.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.2 (10.06.2014):</u></strong>
		<ol>
			<li>Исправлена ошибка вывода неверного шаблона при отсутствии элементов в категории.</li>
			<li>Добавлена возможность использования разных шаблонов для каталога</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (22.02.2014):</u></strong>
		<ol>
			<li>Изменён параметр конструктора с id страницы на id блока.</li>
			<li>Добавлена функция <font color="red">^@GetNameById</font>[id], возвращающая имя элемента каталога.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (05.10.2013):</u></strong>
		<ol>
			<li>Создан класс <strong>${self.className}.p</strong> для работы с каталогом.</li>
		</ol>
	</p>
]
# ---------------------------------- Каталог -----------------------------------
# Таблица "Каталог"
$self.catalogTable[
	$.name[catalog]
	$.file[catalog.table]
]
# Таблица "Тексты Каталога"
$self.catalogTextsTable[
	$.name[catalog_text]
	$.file[catalog_text.table]
]
# Таблица "Файлы Каталога"
$self.catalogFilesTable[
	$.name[catalog_files]
	$.file[catalog_files.table]
]
# Таблица "Галерея каталога"
$self.catalogGalleryTable[
	$.name[catalog_gallery]
	$.file[catalog_gallery.table]
]
# Таблица "Цены каталога"
$self.catalogPricesTable[
	$.name[catalog_prices]
	$.file[catalog_prices.table]
]
# Таблица "Дополнительные поля"
$self.catalogExpandFieldsTable[
	$.name[catalog_expand_fields]
	$.file[catalog_expand_fields.table]
]
# Таблица "Фильтры"
$self.catalogFiltersTable[
	$.name[catalog_filters]
	$.file[catalog_filters.table]
]
# Таблица "Поля фильтров"
$self.catalogFilterFieldsTable[
	$.name[catalog_filter_fields]
	$.file[catalog_filter_fields.table]
]
# Таблица "Сопутствующие товары"
$self.catalogRelatedsTable[
	$.name[catalog_relateds]
	$.file[catalog_relateds.table]
]
# Таблица "Размер"
$self.catalogSizesTable[
	$.name[catalog_sizes]
	$.file[catalog_sizes.table]
]
# Таблица "Связь Товара и Размера"
$self.catalogSizesRelationsTable[
	$.name[catalog_sizes_relations]
	$.file[catalog_sizes_relations.table]
]
# Таблица "Цвет"
$self.catalogColorsTable[
	$.name[catalog_colors]
	$.file[catalog_colors.table]
]
# Таблица "Связь Цвета и Размера"
$self.catalogColorsRelationsTable[
	$.name[catalog_colors_relations]
	$.file[catalog_colors_relations.table]
]
# Таблица "Валюты"
$self.catalogCurrenciesTable[
	$.name[catalog_currencies]
	$.file[catalog_currencies.table]
]
# Таблица "Единицы измерения"
$self.catalogUnitsTable[
	$.name[catalog_units]
	$.file[catalog_units.table]
]
# Таблица "Стикеры"
$self.catalogStickersTable[
	$.name[catalog_stickers]
	$.file[catalog_stickers.table]
]
# Таблица "Цвета стикеров"
$self.catalogStickersColorsTable[
	$.name[catalog_stickers_colors]
	$.file[catalog_stickers_colors.table]
]
# Таблица "Связь Товара и Стикера"
$self.catalogStickersRelationsTable[
	$.name[catalog_stickers_relations]
	$.file[catalog_stickers_relations.table]
]
# Таблица настроек для "Товаров и услуг" Яндекса
$self.ymlSettingsTable[
	$.name[yml_settings]
	$.file[yml_settings.table]
]

# Путь к шаблонам каталога
$self.catalogFolder[/catalog]
# Путь к папке с изображениями каталога
$self.imagesFolder[/images/catalog]
# Путь к иконкам файлов
$self.fileIconsFolder[/images/file_icons]
# Путь к изображениям каталога
$self.imagesFolder[
	$.root[${self.imagesFolder}]
	$.small[${self.imagesFolder}/small]
	$.big[${self.imagesFolder}/big]
	$.src[${self.imagesFolder}/src]
]
# Ширина изображений
$self.imagesWidth[
	$.min(80)
	$.small(200)
	$.big(800)
]
# Соотношение сторон изображения
$self.imagesAspectRatio(^eval(800/600))
# Ширина видео
$self.videosWidth[
	$.small(200)
	$.big(600)
]
# Количество элементов на странице
$self.elementsPerPage(20)
# Сортировка по умолчанию
$self.order[type, sortir]
# Тип сортировки по умолчанию
$self.orderType[ASC]
# Настройки модуля
$self.settings[
	$.showHead(1)
	$.showFolderHead(0)
	$.setTextHead(0)
	$.template[]
	$.showFolderActions(0)
	$.showPrice(0)
	$.showFavorites(0)
	$.showToOrder(0)
	$.showSync(0)
	$.showNoSync(0)
	$.showComments(0)
	$.joint(0)
	$.showParent(0)
	$.showId(0)
	$.showParts(0)
	$.showСomponents(0)
	$.showNew(1)
	$.showStock(1)
	$.showAll(0)
	$.showFilters(0)
	$.showRelated(0)
	$.showStep(0)
	$.saveChildsStep(1)
	$.showExpandFields(0)
	$.showDiagnostics(0)
	$.showColors(0)
	$.showSizes(0)
	$.showStickers(0)
	$.showCurrencies(0)
	$.shippingDate[^site:currentDate.sql-string[]]
	$.shippingDateMin[^site:currentDate.sql-string[]]
	$.shippingDateMax[^site:currentDate.sql-string[]]
	$.showServices(0)
]
# Хэш типов элементов
$self.elementTypes[
	$.0[
		$.title[раздел]
		$.titleRE[раздела]
		$.titleDE[разделу]
		$.titleRM[разделов]
		$.name[section]
	]
	$.1[
		$.title[элемент]
		$.titleRE[элемента]
		$.titleDE[элементу]
		$.titleRM[элементов]
		$.name[element]
	]
]
# ---------------------------------- Магазин -----------------------------------
$self.minOrderSumm(500)
$self.basketFolder[/basket]
$self.tmpFolder[/modules/${self.className}/tmpFolder]
$self.basketFilesFolder[/modules/basket]
$self.basketAddFile[${self.basketFilesFolder}/add.html]
$self.orderFile[${self.basketFilesFolder}/order]
$self.basketFiles[${self.basketFilesFolder}/files/]

# Таблица "Заказ"
$self.orderTable[
	$.name[order_a]
	$.file[order_a.table]
]
# Таблица "Архив заказов"
$self.orderArchiveTable[
	$.name[order_arch]
	$.file[order_arch.table]
]
################################################################################
# --------------------------------- Информация ---------------------------------
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
# ---------------------------------- Элементы ----------------------------------
################################################################################
@GetElements[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.block_id && $params.parent eq 0 && def $self.blockId){$params.block_id($self.blockId)}
	^if(!def $params.block_id){$params.block_id==0}
	^if(!def $params.sync_type){$params.sync_type[new]}
	^if(!def $params.sync_field){$params.sync_field[title]}
	^if(!def $params.order){$params.order[$self.order]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
# 	$expandFields[^self.GetExpandFields[]]
# 	$strExpandFields[]
# 	^if($expandFields.CLASS_NAME eq 'table'){
# 		^expandFields.menu{
# 			$strExpandFields[${strExpandFields}, $expandFields.field]
# 		}
# 	}{<h1>Ошибка загрузки дополнительных полей</h1>}
	$sql[
# 		SELECT id, block_id, name, parent, url, title, keywords, description, sortir, price, currency_id, head, visible, content, type, artikul, parts, favorites, step, redirect, to_order, no_sync, new, stock, markup $strExpandFields
		SELECT cat.*, cur.name AS currency_name, cur.abbreviation AS currency_abbreviation, cur.num_code AS currency_num_code, cur.char_code AS currency_char_code, unit.name AS unit_name, unit.point AS unit_point
		FROM $self.catalogTable.name AS cat
		LEFT JOIN $self.catalogCurrenciesTable.name AS cur ON cur.id=cat.currency_id
		LEFT JOIN $self.catalogUnitsTable.name AS unit ON unit.id=cat.unit_id
		WHERE 1=1
			^if(def $params.element_ids){ AND cat.id IN ($params.element_ids)}
			^if(def $params.parent){ AND parent IN ($params.parent)}
			^if($params.block_id>0){AND block_id=$params.block_id}
			^if(def $params.type){ AND type=$params.type}
			^if(def $params.visible){ AND visible=$params.visible}
			^if($params.sync_type eq 'clean'){ AND ($params.sync_field=NULL OR $params.sync_field='')}
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
@GetElementsWithChilds[params][elements]
^try{
	$elements[^self.GetElements[$params]]
	^if(def $params.element_ids){^params.delete[element_ids]}
	^if(!def $allElements){
		$allElements[^table::create[$elements]]
	}{
		^allElements.join[$elements]
	}
	^if(def $elements){
		^elements.menu{
			$params.parent($elements.id)
			$res[^self.GetElementsWithChilds[$params]]
		}
	}
	$result[$allElements]
}{
	$exception.handled(true)
	$result[^hash::create[]]
}
################################################################################
@GetElementsWithoutLost[params][currentElements]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.parent){$params.parent(0)}
^if(def $params.visible){$allParams[$.visible($params.visible)]}
^try{
	^if(!def $allElements){$allElements[^self.GetElements[^if(def $allParams){$allParams}]]}
	^if(def $allElements){
		$currentElements[^allElements.select($allElements.parent==$params.parent)]
		^if(def $currentElements){
			^if(!def $resElements){
				$resElements[^table::create[$currentElements]]
			}{
				^resElements.join[$currentElements]
			}
			^currentElements.menu{
				$params.parent($currentElements.id)
				$res[^self.GetElementsWithoutLost[^hash::create[$params]]]
			}
		}
		$result[$resElements]
	}{
		$result[
			$.error(true)
			$.text[Каталог пуст]
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
@GetElementById[id;visible]
$result[^table::sql{SELECT id, block_id, name, parent, url, title, keywords, description, sortir, price, head, visible, content, type, artikul, favorites FROM $self.catalogTable.name WHERE id=$id^if(def $visible){ AND visible=$visible}}]
################################################################################
@GetElementUrl[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.element){
	$params.element[^table::sql{SELECT id, url FROM $self.catalogTable.name WHERE id=$params.id}]
}
# Если не передан URL страницы
^if(!def $params.page_url){
	^if(!def $params.page_id){$params.page_id($site:currentPage.id)}
	$params.page_url[^site:GetPageUrlById[$params.page_id;^if(def $params.skip_main){$params.skip_main}]]
}{
	$params.page_url[^params.page_url.trim[/]]
}
# Генерируем URL и возвращаем его
^if(def $params.element.url){
	$result[/$params.page_url/$params.element.url/]
}{
	$result[/$params.page_url/$params.element.id/]
}
################################################################################
@GetElementUrlById[id;params]
^if(!def $params){$params[^hash::create[]]}
$params.id($id)
$result[^self.GetElementUrl[params]]
################################################################################
@GetNameById[id]
$result[^string:sql{SELECT name FROM $self.catalogTable.name WHERE id='$id'}[$.default[Ошибка]]]
################################################################################
@GetParentById[id]
$result(^int:sql{SELECT parent FROM $self.catalogTable.name WHERE id='$id'}[$.default(-1)])
################################################################################
@GetElementNameById[element_id]
$result[^string:sql{SELECT name FROM $self.catalogTable.name WHERE id='$element_id'}]
################################################################################
@GetElementTitle[id]
$result[^string:sql{SELECT title FROM $self.catalogTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetElementKeywords[id]
$result[^string:sql{SELECT keywords FROM $self.catalogTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetElementDescription[id]
$result[^string:sql{SELECT description FROM $self.catalogTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetElementByUrl[url;params]
if(def $params.visible){$visible($params.visible)}{$visible(1)}
$result[^table::sql{SELECT * FROM $self.catalogTable.name WHERE url="$url" AND visible=$visible}]
################################################################################
@GetCountElements[params]
^try{
	$result(^int:sql{
		SELECT count(id)
		FROM $self.catalogTable.name
		WHERE
			parent=$params.parent
			^if(def $params.block_id){ AND block_id=$params.block_id}
			^if(def $params.visible){ AND visible=$params.visible}
	})
}{
	$exception.handled(true)
	$result(-1)
}
################################################################################
@GetElementPageCount[elementId;blockId;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[$self.order]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	$RowNumber(^int:sql{
		SELECT RowNumber FROM (
			SELECT id, @i:=@i+1 AS `RowNumber`, name
			FROM $self.catalogTable.name, (SELECT @i:=0) AS `RowNumberTable`
			WHERE
				block_id=$blockId
				^if(def $params.parent){	AND parent=$params.parent}
				^if(def $params.visible){	AND visible=$params.visible}
				^if(def $params.type){		AND type=$params.type}
			ORDER BY $params.order $params.orderType
		) AS val
		WHERE id=$elementId
	})
	$val(^eval($RowNumber/$self.elementsPerPage))
	$trunc(^math:trunc($val))
	^if(^math:frac($val)>0){$result(^eval($trunc+1))}{$result($trunc)}
}{
	$exception.handled(true)
	$result[]
}
################################################################################
# ------------------------------------ Цены ------------------------------------
################################################################################
@GetCurrencies[params]
^try{
	$result[^table::sql{
		SELECT *
		FROM $self.catalogCurrenciesTable.name
		WHERE 1=1
		^if(def $params.elementIDs){AND id IN ($params.elementIDs)}
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
# Укажите элемент, ID элемента (можно несколько) или его цену и валюту
@GetPrice[params][params;answer]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.accuracy){$params.accuracy(2)}
	^if(!def $params.withMarkup){$params.withMarkup(true)}
	^if(!def $params.convert){$params.convert(false)}
	^if(!def $params.cityPrice){$params.cityPrice(false)}
	^if(!def $params.pruning){$params.pruning(false)}
	^if(!def $params.cityID){$params.cityID($site:currentCity.id)}
# Проверяем наличие элемента
	^if(!def $params.element){
		^if(def $params.elementIDs){
			$params.element[^self.GetElements[$.element_ids[$params.elementIDs]$.resultType[hash]]]
			^if(!def $params.element){
				$result[
					$.error(true)
					$.text[Не найден элемент]
				]
			}
		}{
#			Проверяем цену
			^if(^params.price.int(-1)>-1){
#				Проверяем валюту
				^if(def $params.currency || ^params.currencyID.int(-1)>-1){
					^if(!def $params.currency){
						^if(^self.currencies.locate[id;$params.currencyID]){
							$params.currency[$self.currencies.char_code]
						}{
							$result[
								$.error(true)
								$.text[Неизвестная валюта]
							]
						}
					}
					$params.element[
						$.price($params.price)
						$.currency_char_code[$params.currency]
					]
				}{
					$result[
						$.error(true)
						$.text[Не указана валюта]
					]
				}
			}{
				$result[
					$.error(true)
					$.text[Не указана цена]
				]
			}
		}
	}
#		В зависимости от типа элемента формируем хэш элементов для вывода (elements)
	^switch[$params.element.CLASS_NAME]{
		^case[table]{
			$elements[^params.element.hash[id]]]
		}
		^case[hash]{
			$firstValue[^params.element.at[first]]
			^if($firstValue.CLASS_NAME ne 'hash' && ^params.element.count[]==1){
				$elements[
					$.current[^hash::create[$params.element]]
				]
			}{
				$elements[^hash::create[$params.element]]
			}
		}
		^case[DEFAULT]{
			$result[
				$.error(true)
				$.text[Не поддерживаемый тип элемента ($params.element.CLASS_NAME)]
			]
		}
	}
# Если нужно конвертировать в другую валюту, то определяем в какую
	^if($params.convert){
		^if(!def $params.exchange){$params.exchange[^exchange::create[]]}
# Получаем валюту, в которую конвертируем цену
		^if(!def $params.toCurrency){
			^if(def $params.toCurrencyID){
				^if(^self.currencies.locate[id;$params.toCurrencyID]){
					$params.toCurrency[$self.currencies.char_code]
				}{
					$params.toCurrency[$self.currentCurrency.char_code]
				}
			}{
				$params.toCurrency[$self.currentCurrency.char_code]
			}
		}
	}
#	Если нужно брать цену города, получаем хэш цен городов для всех элементов
	^if($params.cityPrice){
		^if(!def $params.elementIDs){
			$params.elementIDs[]
			^elements.foreach[key;value]{
				$params.elementIDs[$params.elementIDs,$key]
			}
			$params.elementIDs[^params.elementIDs.trim[left;,]]
		}
		$cityPrices[^self.GetCityPrice[$.elementIDs[$params.elementIDs]]]
	}
# Готовим хэш для ответа
	$answer[^hash::create[]]
	^if(!def $self.currencies){
		$self.currencies[^self.GetCurrencies[]]
		$self.currentCurrency[^self.currencies.select($self.currencies.id == 1)]
	}
	$elementCurrency[^self.currencies.select($self.currencies.char_code eq $self.currentCurrency.char_code)]
	$elementCurrencyID($self.currentCurrency.id)
	$elementCurrency[^elementCurrency.hash[id]]
# Для каждого элемента
	^elements.foreach[key;value]{
#		Получаем хэш с информацией о валюте
		^if($elementCurrencyID<1 || $elementCurrency.[$elementCurrencyID].char_code ne $value.currency_char_code){
			$elementCurrency[^self.currencies.select($self.currencies.char_code eq $value.currency_char_code)]
			$elementCurrencyID($elementCurrency.id)
			$elementCurrency[^elementCurrency.hash[id]]
		}
		$answer.[$key][^hash::create[$elementCurrency.[$elementCurrencyID]]]
#		Считаем цену
		^if($params.cityPrice){
#			Берём цену города
			$elementPrices[^cityPrices.select($cityPrices.element_id == $key)]
			$elementPrices[^elementPrices.select($elementPrices.city_id == $params.cityID)]
			^if(def $elementPrices){
				$answer.[$key].price(^elementPrices.price.format[%.${params.accuracy}f])
				$answer.[$key].char_code[$elementPrices.currency_char_code]
			}{
				^if(^params.defaultCityID.int(0)>0){
					$elementPrices[^cityPrices.select($cityPrices.element_id == $key)]
					$elementPrices[^elementPrices.select($elementPrices.city_id == $params.defaultCityID)]
				}
				^if(def $elementPrices){
					$answer.[$key].price(^elementPrices.price.format[%.${params.accuracy}f])
					$answer.[$key].char_code[$elementPrices.currency_char_code]
				}{
					$answer.[$key].price(^value.price.format[%.${params.accuracy}f])
					$answer.[$key].char_code[$value.currency_char_code]
				}
			}
		}{
#			Выводим цену напрямую
			$answer.[$key].price(^value.price.format[%.${params.accuracy}f])
			$answer.[$key].char_code[$value.currency_char_code]
		}
		^if($params.convert){
#			Получаем цену в новой валюте
			$answer.[$key].price(^params.exchange.ConvertPrice[$answer.[$key].char_code;$params.toCurrency;$answer.[$key].price;$params.accuracy])
		}
#		Добавляем наценку
		^if($params.withMarkup){
			$answer.[$key].price($answer.[$key].price+$answer.[$key].price*$value.markup)
			$answer.[$key].price(^answer.[$key].price.format[%.${params.accuracy}f])
		}
	}
# Возвращаем указатель на первый элемент таблицы
	^self.currencies.offset[set](0)
# Если информация только для 1 элемента
	^if(^answer.count[]==1 && $params.pruning){
		$elementID(^answer.at[first;key])
		$answer.[$elementID].element_id($elementID)
		$answer[$answer.[$elementID]]
	}
# Возвращаем результат
	$result[$answer]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetCityPrice[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[city]}
^if(!def $params.orderType){$params.orderType[ASC]}
^if(!def $params.offsetCount){$params.offsetCount(0)}
^if(!def $params.limitCount){$params.limitCount(-1)}
^try{
	$sql[
		SELECT p.id, p.city_id, c.name AS city, p.element_id, p.price, cur.char_code AS currency_char_code
		FROM $self.catalogPricesTable.name AS p
		LEFT JOIN $catalogCurrenciesTable.name AS cur ON cur.id=p.currency_id
		LEFT JOIN $contacts:contactsCitiesTable.name AS c ON c.id=p.city_id
		WHERE 1=1
			^if(def $params.elementIDs){AND element_id IN ($params.elementIDs)}
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
# @GetProductPrice[id]
# ^connect[$site:connectString]{
# 	$result(^int:sql{SELECT price FROM $self.catalogTable.name WHERE id=$id}[$.default(0)])
# }
################################################################################
# @CreatePrices[element_id]
# ^try{
# 	$cities[^table::sql{SELECT id FROM $contacts:contactsCitiesTable.name}]
# 	^cities.menu{
# 		$res[^void:sql{INSERT INTO $self.catalogPricesTable.name (city_id, element_id) VALUES ($cities.id, $element_id)}]
# 	}
# 	$result(1)
# }{
# 	$exception.handled(true)
# 	$result(0)
# }
################################################################################
# @EditContact[element_id;city_id;field;value]
# $result[^void:sql{UPDATE $self.catalogPricesTable.name SET $field='$value' WHERE element_id=$element_id AND city_id=$city_id}]
################################################################################
# ----------------------------- Единицы измерения ------------------------------
################################################################################
@GetUnits[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[id]}
^if(!def $params.orderType){$params.orderType[ASC]}
^if(!def $params.offsetCount){$params.offsetCount(0)}
^if(!def $params.limitCount){$params.limitCount(-1)}
^try{
	$sql[
		SELECT id, name, point
		FROM $self.catalogUnitsTable.name AS p
		WHERE 1=1
			^if(def $params.unitIDs){AND id IN ($params.unitIDs)}
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
# -------------------------------- Отображение ---------------------------------
################################################################################
@Show[params]
^if($self.settings.showAll){
	$elements[^self.GetElements[$.block_id($self.blockId)$.limitCount(999999)]]
	^use[${site:templateFolder}$self.catalogFolder/allCatalog.html]
	^ShowAllCatalog[$elements]
}{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.id && def $form:idc){$params.id($form:idc)}
# Определяем текущую страницу
	^if(def $params.id){$idc($params.id)}{$idc(0)}
	$element_type(^int:sql{SELECT type FROM $self.catalogTable.name WHERE block_id=$self.blockId AND id=$idc}[$.default(0)])
	^switch($element_type == 1){
		^case(1){
# Если в настройках стоит совмещённый вид
			^if($self.settings.joint){
				$params[
					$.parent(^self.GetParentById[$idc])
					$.visible(1)
				]
				$cpage(^self.GetElementPageCount[$idc;$self.blockId;$params])
				$params[
					$.block_id($self.blockId)
					$.parent(^self.GetParentById[$idc])
					$.visible(1)
					$.offsetCount(^eval(($cpage-1)*$self.elementsPerPage))
				]
				$elements[^self.GetElements[$params]]
				$allElementsCount[^self.GetCountElements[$params]]
				^use[${site:templateFolder}$self.catalogFolder/jointElements.html]
				^ShowJointElements[$elements;$cpage;$allElementsCount]
			}{
				$params[
					$.element_ids($idc)
					$.visible(1)
				]
				$element[
					$.catalog[^self.GetElements[$params]]
					$.images[^self.GetImages[$idc;$.visible(1)]]
					$.files[^self.GetFiles[$idc;$.visible(1)]]
					$.video[^video:GetVideo[$.blockIDs($idc)$.blockName[$self.className]]]
				]
				^use[${site:templateFolder}$self.catalogFolder/element.html]
				^try{^ShowCatalogElementTemplate[$element]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
			}
		}
		^case[DEFAULT]{
			^if(def $form:page){$cpage($form:page)}{$cpage(1)}
			$params[
				$.block_id($self.blockId)
				$.parent($idc)
				$.visible(1)
				$.offsetCount(^eval(($cpage-1)*$self.elementsPerPage))
			]
			$elements[^self.GetElements[$params]]
			$allElementsCount[^self.GetCountElements[$params]]
			^if($elements.type == 0){
				^use[${site:templateFolder}$self.catalogFolder/folder.html]
				^try{^ShowCatalogFolderTemplate[$elements;$allElementsCount]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
			}{
# Если в настройках стоит совмещённый вид
				^if($self.settings.joint){
					^use[${site:templateFolder}$self.catalogFolder/jointElements.html]
					^ShowJointElements[$elements;$cpage;$allElementsCount]
				}{
					^if(^elements.count[]>1){
						^use[${site:templateFolder}$self.catalogFolder/elements.html]
						^try{^ShowCatalogElementsTemplate[$elements;$allElementsCount]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
					}{
						$element[
							$.catalog[$elements]
							$.images[^self.GetImages[$elements.id;$.visible(1)]]
							$.files[^self.GetFiles[$elements.id;$.visible(1)]]
							$.video[^video:GetVideo[$.blockIDs($elements.id)$.blockName[$self.className]]]
						]
						^use[${site:templateFolder}$self.catalogFolder/element.html]
						^try{^ShowCatalogElementTemplate[$element]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
					}
				}
			}
		}
	}
}
################################################################################
@ShowCompare[params]
^if(def $params.template){$template[$params.template]}{$template[compare.html]}
^if(def $cookie:catalog_compare){
	$elements[^self.GetElements[$.element_ids[$cookie:catalog_compare]]]
}
^use[/${site:templateFolder}$self.catalogFolder/${template}]
^try{^ShowCompareTemplate[$elements;$self]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################
@ShowCatalogMenu[page;template;parent;visible]
^if(!def $page){$page($self.pageId)}
^if(!def $template){$template[catalog.html]}
^if(!def $parent){$parent(0)}
^if(!def $visible){$visible(1)}
$block_id(^textext:GetBlockIdByPageId[$page;$self.className])
$pages[^table::sql{SELECT * FROM $self.catalogTable.name WHERE block_id=$block_id AND parent=$parent AND visible=$visible ORDER BY sortir}]
^if(def $pages){
 ^use[/${site:templateFolder}/menus/${template}]
 ^try{^ShowCatalogMenuTemplate[$pages;$page]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}
################################################################################
@ShowBasket[params]
^try{
	^use[${site:templateFolder}${self.basketFolder}/basket.html]
	^ShowBasketTemplate[$params]
}{
	^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]
}
################################################################################
@ShowOrder[params]
^try{
	^use[${site:templateFolder}${self.basketFolder}/order.html]
	^ShowOrderTemplate[$params]
}{
	^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]
}
################################################################################
# ---------------------------------- Корзина -----------------------------------
################################################################################
@OpenBasket[session_id]
# Если файл ещё ниразу не открыт
^if(!def $self.basketFile){
#	Создаем/открываем файл с информацией по товарам в корзине
	$self.basketFile[^hashfile::open[${self.basketFiles}/basket_${session_id}]]
}
# Возвращаем файл
$result[$self.basketFile]
################################################################################
@AddProductToBasket[session_id;id;count;reset;params]
^switch[$reset]{
	^case[true]{$reset(true)}
	^case[false]{$reset(false)}
	^case(1){$reset(true)}
	^case(0){$reset(false)}
	^case[DEFAULT]{$reset(false)}
}
# Если переданы важные параметры
^if(def $session_id && def $id){
#	Если кол-во не передаётся, считаем что равно 1
	^if(!def $count){$count(1)}
#	Пробуем записать данные
	^try{
		$newCount(0)
		$successText[Товар добавлен]
#		Создаем/открываем файл с информацией по товарам в корзине
		$self.basketFile[^self.OpenBasket[$session_id]]
#		Если количество меньше 1
		^if($count<0.1){
#		Удаляем запись
			^self.basketFile.delete[$id]
			$successText[Товар удалён]
		}{
#		Перезаписываем значение
			^if($reset){
				$newCount($count)
				$self.basketFile.[$id][
					$.expires(0.5)
					$.value($newCount)
				]
			}{
				$newCount(^eval($count+$self.basketFile.[$id]))
				$self.basketFile.[$id][
					$.expires(0.5)
					$.value($newCount)
				]
			}
			^if(def $params.url){
				$self.basketFile.lastURL[
					$.expires(0.5)
					$.value[$params.url]
				]
			}
		}
		$result[
			$.error(false)
			$.text[$successText]
			$.count($newCount)
		]
	}{
		$exception.handled(true)
		$result[
			$.error(true)
			$.text[Ошибка выполнения]
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
@ClearBasket[session_id]
#	Пробуем очистить корзину
^try{
#	Создаем/открываем файл с информацией по товарам в корзине
	$self.basketFile[^self.OpenBasket[$session_id]]
# Очищаем корзину
	^self.basketFile.delete[]
# Возвращаем результат
	$result(1)
}{
#	Отключаем ошибку
	$exception.handled(true)
#	Возвращаем результат
	$result(0)
}
################################################################################
@OrderBasket[user_id;id_session;extra_fields;params]
$basketInfo[^self.GetBasketInfo[$id_session;$params]]
^if($basketInfo.elementsCount>0){
	if(def $extra_fields){
		^extra_fields.foreach[key;value]{
			$fields[${fields}, $key]
			$values[${values}, "$value"]
		}
	}
	$orderName[^file::load[text;${site:templateFolder}$self.basketFolder/order-name.html]]
	$replaceTemplates[
		$._DATE_[^dtf:format[%d %h %Y;$site:currentDate;$dtf:rr-locale]]
		$._COUNT_[$basketInfo.elementsCount]
		$._SUMM_[$basketInfo.basketSumm]
	]
	^void:sql{INSERT INTO $self.orderTable.name (name, user_id, date, summa_with_skidka $fields) VALUES ('^str_replace[$orderName.text;$replaceTemplates]', $user_id, '^site:currentDate.sql-string[]', '$basketInfo.basketSumm' $values)}
	$order_id(^int:sql{SELECT id FROM $self.orderTable.name WHERE date='^site:currentDate.sql-string[]' AND summa_with_skidka=$basketInfo.basketSumm})
	^basketInfo.elements.foreach[key;value]{
		^void:sql{INSERT INTO $self.orderArchiveTable.name (id_order, artikul, name, counts, price) VALUES ($order_id, '$value.artikul', '$value.name', '$basketInfo.basket.[$key]', '$basketInfo.prices.[$key].price')}
	}
	$res[^self.ClearBasket[$id_session]]
	$result($order_id)
}{
	$result(-1)
}
################################################################################
@GetBasketSum[session_id;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.element){$params.element[^self.GetElementsInBasket[$session_id]]}
#Создаем/открываем файл с информацией по товарам в корзине
$self.basketFile[^self.OpenBasket[$session_id]]
$basket[^self.basketFile.hash[]]
$prices[^self.GetPrice[^hash::create[$params]]]
$sum(0)
^params.element.menu{
	$sum(^eval($sum+$prices.[$params.element.id].price*$basket.[$params.element.id]))
}
$result($sum)
################################################################################
@GetBasket[session_id]
#	Пробуем получить данные
^try{
#	Создаем/открываем файл с информацией по товарам в корзине
	$self.basketFile[^self.OpenBasket[$session_id]]
# Получение хэша из файла
	$res[^self.basketFile.hash[]]
# Если в хэше есть данные корзины
	^if(^res._count[]>0){
#	Возвращаем данные корзины
		$result[$res]
	}{
# Удаляем файл
		^self.basketFile.delete[]
# Возвращаем пустой хэш
		$result[^hash::create[]]
	}
}{
#	Отключаем ошибку
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения]
		$.exception[$exception]
	]
}
################################################################################
@GetElementsInBasket[session_id;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.basket){$params.basket[^self.GetBasket[$session_id]]}
$counter(0)
^params.basket.foreach[key;value]{
	^if($key ne 'lastURL'){
		^counter.inc[]
		^if($counter>1){$id[$id, $key]}{$id[$key]}
	}
}
$result[^self.GetElements[$.element_ids[^if(!def $id){0}{$id}]]]
################################################################################
@GetBasketInfo[session_id;params][params]
^if(!def $params){$params[^hash::create[]]}
$basketInfoAnswer[
	$.elementsCount(0)
	$.basketSumm(0)
]
^if(!def $params.basket){$basketInfoAnswer.basket[^self.GetBasket[$session_id]]}{$basketInfoAnswer.basket[$params.basket]}
$counter(0)
^basketInfoAnswer.basket.foreach[key;value]{
	^if($key ne 'lastURL'){
		$basketInfoAnswer.elementsCount(^eval($basketInfoAnswer.elementsCount+$value))
		^counter.inc[]
		^if($counter>1){$id[$id, $key]}{$id[$key]}
	}
}
$basketInfoAnswer.stringIDs[$id]
$basketInfoAnswer.elements[^self.GetElements[$.element_ids[^if(!def $id){0}{$basketInfoAnswer.stringIDs}]$.resultType[hash]]]
^if(def $basketInfoAnswer.elements){
	$params.element[$basketInfoAnswer.elements]
	$params.pruning(false)
	$basketInfoAnswer.productsCount(^basketInfoAnswer.elements.count[])
	$basketInfoAnswer.prices[^self.GetPrice[^hash::create[$params]]]
	^basketInfoAnswer.basket.foreach[key;value]{
		^if(^key.int(0)>0){
			$basketInfoAnswer.basketSumm($basketInfoAnswer.basketSumm+$basketInfoAnswer.prices.[$key].price*$value)
		}
	}
}
$result[$basketInfoAnswer]
################################################################################
# ----------------------------------- Заказ ------------------------------------
################################################################################
@GetOrders[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[id]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	^if(def $params.count){
		$sqlParams[
			$.fields[count(o.id)]
			$.joins[]
			$.order[]
		]
	}{
		$sqlParams[
			$.fields[o.*, u.first_name AS user_first_name, u.last_name AS user_last_name, u.email AS user_email, u.phone AS user_phone, c.name AS city]
			$.joins[
				LEFT JOIN $user:usersTable.name AS u ON u.id=o.user_id
				LEFT JOIN $contacts:contactsCitiesTable.name AS c ON c.id=o.city_id
			]
			$.order[ORDER BY o.${params.order} $params.orderType]
		]
	}
	$sql[
		SELECT $sqlParams.fields
		FROM $self.orderTable.name AS o
		$sqlParams.joins
		WHERE 1=1
			^if(def $params.orderIDs){ AND o.id IN ($params.orderIDs)}
			^if(def $params.userIDs){ AND o.user_id IN ($params.userIDs)}
			^if(def $params.cityIDs){ AND o.city_id IN ($params.cityIDs)}
			^if(def $params.status){ AND o.status='$params.status'}
		$sqlParams.order
	]
	^if(def $params.count){
		$result(^int:sql{$sql})
	}{
		^if($params.resultType eq hash){
			$result[^hash::sql{$sql}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
		}{
			$result[^table::sql{$sql}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
		}
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
@GetArchiveOrders[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[id]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$sql[
		SELECT id, artikul, name, counts, price, (counts*price) as itogo
		FROM $self.orderArchiveTable.name
		WHERE 1=1
			^if(def $params.IDs){ AND id IN ($params.IDs)}
			^if(def $params.orderIDs){ AND id_order IN ($params.orderIDs)}
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
# ----------------------------------- Поиск ------------------------------------
################################################################################
@Search[searchString;params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[name]}
^if(!def $params.orderType){$params.orderType[ASC]}
^if(!def $params.offsetCount){$params.offsetCount(0)}
^if(!def $params.limitCount){$params.limitCount(99999)}
^try{
#	Поля поиска
	^if(!def $params.searchFields){$params.searchFields[$.name[]]}{
		^if($params.searchFields.CLASS_NAME eq string){
			$params.searchFields[^params.searchFields.replace[ ;]]
			$params.searchFields[^explode[,;$params.searchFields]]
		}
	}
# Слова поисковой фразы
	$searchWords[^explode[ ;$searchString]]
# Строка запроса поиска слов в поисковой фразе
	$searchQuery[]
	^params.searchFields.foreach[fieldNum;field]{
		$currentQuery[]
		^searchWords.foreach[wordNum;word]{
			$currentQuery[$currentQuery AND $field LIKE '%$word%']
		}
		$searchQuery[$searchQuery OR (^currentQuery.trim[left; AND ])]
	}
# Получение данных из БД
	$result[^table::sql{
		SELECT *
		FROM $self.catalogTable.name
		WHERE 1=1
			^if(def $params.visible){ AND visible=$params.visible}
			^if(def $params.type){ AND type=$params.type}
			AND ( ^searchQuery.trim[left; OR ] )
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Во время выполнения произошла ошибка]
		$.exception[$exception]]
	]
}
################################################################################
@GetSearchedGoods[searchString;cpage;noContent]
^if(!def $cpage){$cpage(1)}
$result[^table::sql{
	SELECT id, block_id, name
#	, parent, url, sortir, price, head, visible, content, type, artikul, to_order, no_sync, favorites, title, keywords, description
	FROM $self.catalogTable.name
	WHERE
				visible=1
		AND type=1
		AND (name LIKE '%$searchString%' OR head LIKE '%$searchString%' OR artikul LIKE '%$searchString%'^if(!def $noContent){ OR content like '%$searchString%'})
	ORDER BY name
}[$.limit($self.elementsPerPage) $.offset(^eval($cpage*$self.elementsPerPage-$self.elementsPerPage))]]
################################################################################
@GetSearchedGoodsByName[searchString;cpage]
^if(!def $cpage){$cpage(1)}
$result[^table::sql{SELECT * FROM $self.catalogTable.name WHERE visible=1 AND type=1 ^if(def $cpage){AND idpage=$cpage }AND name LIKE '%$searchString%' ORDER BY name}[$.limit($self.elementsPerPage) $.offset(^eval($cpage*$self.elementsPerPage-$self.elementsPerPage))]]
################################################################################
@GetSearchedGoodsByArtikul[searchString;cpage]
^if(!def $cpage){$cpage(1)}
$result[^table::sql{SELECT * FROM $self.catalogTable.name WHERE visible=1 AND type=1 ^if(def $cpage){AND idpage=$cpage }AND artikul LIKE '%$searchString%' ORDER BY artikul}[$.limit($self.elementsPerPage) $.offset(^eval($cpage*$self.elementsPerPage-$self.elementsPerPage))]]
################################################################################
# -------------------------------- Изображения ---------------------------------
################################################################################
@GetMainImage[element_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[element_id]}
	^if(!def $params.orderType){$params.orderType[$self.orderType]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$sql[
		SELECT element_id, id, name, descript, visible
		FROM $self.catalogGalleryTable.name
		WHERE
			element_id IN ($element_id)
			AND main=1
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
@GetImages[element_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.elementsPerPage)}
	$result[^table::sql{
		SELECT id, name, descript, main, sortir, visible
		FROM $self.catalogGalleryTable.name
		WHERE element_id=$element_id
					^if(def $params.visible){ AND visible=$params.visible}
					^if(def $params.main){ AND main=$params.main}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
# ----------------------------------- Файлы ------------------------------------
################################################################################
@GetFiles[element_id;params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount($self.newsPerPage)}
	$result[^table::sql{
		SELECT id, name, descript, sortir, visible
		FROM $self.catalogFilesTable.name
		WHERE element_id=$element_id^if(def $params.visible){ AND visible=$params.visible}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
# --------------------------------- Доп. поля ----------------------------------
################################################################################
@GetExpandFields[]
^try{
	$answer[^table::sql{SELECT id, field, title, type_id FROM $self.catalogExpandFieldsTable.name}]
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]
}
$result[$answer]
################################################################################
# ---------------------------------- Фильтры -----------------------------------
################################################################################
@GetFilterFields[]
^try{
	$result[^table::sql{SELECT id, field, label FROM $self.catalogFilterFieldsTable.name}]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetElementsFilters[params]
^if(!def $params){$params[^hash::create[]]}
^try{
	$result[^table::sql{
		SELECT f.id, f.element_id, f.filter, ff.label
		FROM $self.catalogFiltersTable.name AS f
		LEFT JOIN $self.catalogFilterFieldsTable.name AS ff ON ff.field=f.filter
		WHERE
			1=1
			^if(def $params.element_id){ AND f.element_id IN ( $params.element_id )}
		ORDER BY label
	}]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
# ---------------------------- Сопутствующие товары ----------------------------
################################################################################
@GetElementsRelateds[params]
^if(!def $params){$params[^hash::create[]]}
^try{
	$result[^table::sql{
		SELECT id, element_id, related_id
		FROM $self.catalogRelatedsTable.name
		WHERE
			1=1
			^if(def $params.element_id){ AND element_id IN ( $params.element_id )}
	}]
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]
}
################################################################################
# ---------------------------------- Размеры -----------------------------------
################################################################################
@GetSizes[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$result[^table::sql{
		SELECT *
		FROM $self.catalogSizesTable.name
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetSizesRelations[params]
^try{
	$result[^table::sql{
		SELECT *
		FROM $self.catalogSizesRelationsTable.name
		WHERE 1=1
		^if(def $params.elementIDs){AND element_id IN ($params.elementIDs)}
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
# ----------------------------------- Цвета ------------------------------------
################################################################################
@GetColors[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$result[^table::sql{
		SELECT *
		FROM $self.catalogColorsTable.name
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetColorsRelations[params]
^try{
	$result[^table::sql{
		SELECT *
		FROM $self.catalogColorsRelationsTable.name
		WHERE 1=1
		^if(def $params.elementIDs){AND element_id IN ($params.elementIDs)}
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
# ---------------------------------- Стикеры -----------------------------------
################################################################################
@GetStickers[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$result[^table::sql{
		SELECT s.*, c.color, c.text_color
		FROM $self.catalogStickersTable.name AS s
		LEFT JOIN $self.catalogStickersColorsTable.name AS c ON c.id=s.color_id
		WHERE 1=1
		^if(def $params.IDs){AND id IN ($params.IDs)}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetStickerColors[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sortir]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	$result[^table::sql{
		SELECT *
		FROM $self.catalogStickersColorsTable.name
		WHERE 1=1
		^if(def $params.IDs){AND id IN ($params.IDs)}
		ORDER BY $params.order $params.orderType
	}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
		$.exception[$exception]
	]
}
################################################################################
@GetStickersRelations[params]
^try{
	$result[^table::sql{
		SELECT *
		FROM $self.catalogStickersRelationsTable.name
		WHERE 1=1
		^if(def $params.elementIDs){AND element_id IN ($params.elementIDs)}
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
# --------------------------------- Сравнение ----------------------------------
################################################################################
@GetCompareElements[params]
^if(def $params.field){$field[$params.field]}{$field[piece]}
$result[^cookie:catalog_compare.split[,;;$field]]
################################################################################
@AddToCompare[element_id]
^if(def $element_id){
	^try{
		$addToCompare(true)
		$elements[^self.GetCompareElements[]]
		^if(def $elements){
			^if(^elements.select($elements.piece eq $element_id)){
				$addToCompare(false)
				$answer[
					$.error(false)
					$.text[Элемент уже добавлен к сравнению]
				]
			}
		}
		^if($addToCompare){
			$cookie:catalog_compare[${cookie:catalog_compare},$element_id]
			$cookie:catalog_compare[^cookie:catalog_compare.trim[left;,]]
			$answer[
				$.error(false)
				$.text[Элемент добавлен к сравнению]
			]
		}
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[Ошибка выполнения]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Не передан ID элемента]
	]
}
$result[$answer]
################################################################################
@RemoveFromCompare[element_id]
^if(def $element_id){
	^try{
		$elements[^self.GetCompareElements[]]
		^if(def $elements){
			$removeFlag(false)
			$newValue[]
			^elements.menu{
				^if($elements.piece ne $element_id){
					$newValue[${newValue},$elements.piece]
				}{
					$removeFlag(true)
				}
			}
			^if(def $removeFlag){
				$cookie:catalog_compare[^newValue.trim[left;,]]
				$answer[
					$.error(false)
					$.text[Элемент удалён из списка для сравнения]
				]
			}{
				$answer[
					$.error(true)
					$.text[Элемент не найден в списке для сравнения]
				]
			}
		}{
			$answer[
				$.error(true)
				$.text[Элементы для сравнения не найдены]
			]
		}
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[Ошибка выполнения]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Не передан ID элемента]
	]
}
$result[$answer]
################################################################################
@CheckComapare[element_id]
$answer(false)
$elements[^cookie:catalog_compare.split[,]]
^if(def $elements){
	^if(^elements.select($elements.piece eq $element_id)){
		$answer(true)
	}
}
$result($answer)
################################################################################
# ----------------------------------- Разное -----------------------------------
################################################################################
@SendMail[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.tmpl){$params.tmpl[sendMail.html]}
^if(!def $params.email){$params.email[$site:email]}
^if(!def $params.user){$params.user[$site:user]}
^if(!def $params.from){$params.from[postmaster]}
^if(!def $params.charset){$params.charset[UTF-8]}
^if(!def $params.subject){$params.subject[В Ваш Интернет-магазин $env:SERVER_NAME поступил заказ]}
^try{
	^use[${site:templateFolder}${self.basketFolder}/$params.tmpl]
	$orderTableValues[^self.GetOrders[$.userIDs($params.user.id)$.orderIDs($params.order_id)]]
	$orderArchTableValues[^self.GetArchiveOrders[$.orderIDs($params.order_id)]]
	$sendParams[
		$.from[$params.from]
		$.to[$params.email]
		$.charset[$params.charset]
		$.subject[$params.subject]
		$.html{^ShowSendMailFormTemplate[$params.user;$orderTableValues;$orderArchTableValues]}
	]
	^if($params.createFile){
		$date_now[^date::now[]]
		^use[${site:templateFolder}${self.basketFolder}/file.html]
		$fileName[d_^date_now.day.format[%02d]^date_now.month.format[%02d]${date_now.year}^date_now.hour.format[%02d]^date_now.minute.format[%02d]^date_now.second.format[%02d]480]
		^orderArchTableValues.menu{$itogo_ves($itogo_ves+$orderArchTable.itogo)}
		$sendParams.subject[$fileName]
		$sendParams.file[^file::create[text;${fileName}.xml;^untaint[xml]{^ShowSendMailFileFormTemplate[$params.userInfo;$itogo_ves;$orderArchTableValues]};$.charset[UTF-8]]]
	}
	^mail:send[$sendParams]
	$result[
		$.error(false)
		$.text[Письмо отправлено]
	]
}{
	$exception.handled(0)
	$result[
		$.error(true)
		$.text[Ошибка выполнения функции]
	]
}
################################################################################
@GetFirstParent[id][parent;res]
$parent(^int:sql{SELECT parent FROM $self.catalogTable.name WHERE id=$id}[$.default(0)])
$res(^int:sql{SELECT parent FROM $self.catalogTable.name WHERE id=$parent}[$.default(0)])
^if($res == 0){$result($parent)}{$result(^self.GetFirstParent[$parent])}
################################################################################
# Используется для получения id и количества товаров, из которых состоит
# составной товар. Возвращает хэш, у которого ключ - ID товара,
# а значение - его количество.
@ParseParts[str]
$partsTable[^str.split[,]]
$parts[^hash::create[]]
$ids[]
^partsTable.menu{
	$vals[^partsTable.piece.split[x;lh]]
	^if(def $vals.1){
		$parts.[^vals.0.int[]]($vals.1)
	}{
		$parts.[^vals.0.int[]](1)
	}
	^if($ids ne ""){
		$ids[${ids}, $vals.0]
	}{
		$ids[$vals.0]
	}
	$parts.ids[$ids]
}
$result[$parts]
################################################################################
@GetElementTexts[element_id]
^try{
	$answer[^table::sql{SELECT id, element_id, top_text, bottom_text FROM $self.catalogTextsTable.name WHERE element_id=$element_id}]
}{
	$exception.handled(true)
	$answer[
		$.error(true)
		$.text[Ошибка выполнения]
	]
}
$result[$answer]
################################################################################
@SwitchView[action]
$answer[^hash::create[]]
^try{
	$cookie:catalog_view[$action]
	$answer.error(false)
	$answer.view[$action]
}{
	$answer.error(true)
	$answer.text[Ошибка переключения вида]
}
$result[$answer]
################################################################################
@GetBreadcrumbs[pageUrl]
$breadcrumbs[^hash::create[]]
^if(def $form:idc){
	$counter(1)
	$breadcrumbs.[$counter][
		$.name[^self.GetNameById[$form:idc]]
		$.url[^self.GetElementUrl[$.page_url[$pageUrl]$.id($form:idc)]]
		$.module[$self.CLASS_NAME]
		$.opened(true)
	]
	$parent(^self.GetParentById[$form:idc])
	^while($parent>0){
		^counter.inc[]
		$breadcrumbs.[$counter][
			$.name[^self.GetNameById[$parent]]
			$.url[^self.GetElementUrl[$.page_url[$pageUrl]$.id($parent)]]
			$.module[$self.CLASS_NAME]
		]
		$parent(^self.GetParentById[$parent])
	}
}
$result[$breadcrumbs]
################################################################################
@GeneratePromoCode[params]
$maxLength(255)
$coincidence(true)
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.length){$params.length(10)}
^if($params.length>$maxLength){$params.length($maxLength)}
^if(!def $params.table){$params.table[$self.orderTable.name]}
^if(!def $params.field){$params.field[promo_code]}
^if(!def $params.symbols){$params.symbols[QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890]}
^while($coincidence){
	$promoCode[]
	^for[i](1;$params.length){
		$promoCode[${promoCode}^params.symbols.mid(^math:random(^params.symbols.length[]);1)]
	}
	$coincidence(^int:sql{SELECT 1 FROM $params.table WHERE ${params.field}='$promoCode'}[$.default(0)])
}
$result[$promoCode]
################################################################################
@GetOpenGraphData[params][answer]
^if(def $form:idc){
	$currentNews[^self.GetElements[$.element_ids($form:idc)]]
	$description[^htmlToString[^taint[as-is][$currentNews.head]]]
	$answer[
		$.og[
			$.title[^textext:GetFixedText[$currentNews.name;70]]
			$.description[^textext:GetFixedText[$description;200]]
			$.type[website]
			$.url[${env:REQUEST_SCHEME}://${site:domain}${env:REQUEST_URI}]
		]
		$.twitter[^hash::create[]]
	]
	$images[^self.GetImages[$form:idc;$.visible(1)]]
	^if($images.CLASS_NAME eq table){
		$NConvert[^NConvert::create[]]
		$answer.og.image[^hash::create[]]
		$counter(0)
		^images.menu{
			$imageURL[${self.imagesFolder.big}/$images.name]
			$image[^NConvert.info[$imageURL]]
			^counter.inc[]
			$alt[^if(def $images.descript){$images.descript}{$description}]
			$answer.og.image.[$counter][
				$.url[${env:REQUEST_SCHEME}://${site:domain}${imageURL}]
				$.width($image.iWidth)
				$.height($image.iHeight)
				$.type[$NConvert.mimeTypes.[$image.sFormat]]
				$.alt[$alt]
			]
		}
	}
	$result[$answer]
}
################################################################################
@GetSEOData[]
$ID(^form:idc.int(0))
^if($ID>0){
	$element[^self.GetElements[$.element_ids($ID)]]
	$SEOData[
		$.header[$element.name]
		$.fullUrl[${site:currentPage.fullUrl}/^if(def $element.url){$element.url}{$element.id}]
		$.title[$element.title]
		$.keywords[$element.keywords]
		$.description[$element.description]
	]
	^if($site:currentPage.mainPageFlag && $ID>0){$SEOData.mainPageFlag(false)}
}
$result[$SEOData]
################################################################################