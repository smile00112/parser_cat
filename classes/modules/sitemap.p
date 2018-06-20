################################################################################
@CLASS
sitemap
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[06.09.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[sitemap]
$self.classDescription[Класс модуля "Карта сайта"]
$self.classModuleDescription[Карта сайта]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс для модуля "$self.classModuleDescription"</li>
		</ol>
	</p>
]
# Путь к шаблону
$self.folders[
	$.main[/$self.className]
]
# Настройки модуля
$self.settings[
	$.template[]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
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
@Show[params]
^use[${site:templateFolder}$self.folders.main/sitemap.html]
$sitemap[^site:GetPages[;;a,b]]
^try{^ShowSitemapTemplate[$sitemap]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
################################################################################