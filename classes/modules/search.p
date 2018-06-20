################################################################################
@CLASS
search
################################################################################
@auto[]
$self.classVersion[1.1]
$self.classBuildDate[14.08.2014]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[search]
$self.classDescription[Класс модуля "Поиск"]
$self.classModuleDescription[Поиск]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.1 (14.08.2014):</u></strong>
  <ol>
   <li>Класс переписан с учётом новой архитектуры</li>
  </ol>
 </p>
 <p align="justify">
  <strong><u>Версия 1.0 (04.07.2013):</u></strong>
  <ol>
   <li>Создан класс <font color="red">search</font> для поиска по сайту</li>
  </ol>
 </p>
]
#----------------------------- Рабочие переменные ------------------------------
# Строка поиска
$self.searchString[$form:search]
# Определяем максимальное кол-во отображаемых элементов
$self.perPage(200)
# Путь к шаблону
$self.folders[
	$.templates[/$self.className]
	$.handlers[/modules/$self.className]
]
################################################################################
@create[params]
^if(def $params.searchString){$self.searchString[$params.searchString]}
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
@GetSearchedText[cpage;noContent]
$result[^table::sql{
	SELECT m.id, m.name, m.head, m.keywords, m.descript, c.content
	FROM $site:menusTable.name AS m
	LEFT JOIN (SELECT b.idpage, t.content FROM $textext:pageBlocksTable.name AS b LEFT JOIN $textext:pageBlockTextsTable.name AS t ON t.id=b.id) AS c ON c.idpage=m.id
	WHERE
		m.visible=1 AND
		m.id_menu<>'c' AND
		(
		m.name like '%$self.searchString%'
		OR m.head like '%$self.searchString%'
		OR m.keywords like '%$self.searchString%'
		OR m.descript like '%$self.searchString%'
		^if(!def $noContent){OR c.content like '%$self.searchString%'}
		)
	ORDER BY name
}[$.limit($self.perPage) $.offset(^eval($cpage*$self.perPage-$self.perPage))]]
################################################################################
@SearchElements[params]
$answer[^hash::create[]]
$allBlocks[^site:GetInstalledBlocks[]]
^allBlocks.menu{
	^try{
		$blockParams[$params.[$allBlocks.nameblock]]
		$answer.[$allBlocks.nameblock][^process{^^${allBlocks.nameblock}:Search[^$self.searchString^;^$blockParams]}]
	}{
		$exception.handled(true)
	}
}
$result[$answer]
################################################################################
@Show[params]
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.template){$params.template[index.html]}
$elements[^self.SearchElements[$params]]
^if(-f "${site:templateFolder}${self.folders.templates}/${params.template}"){
	^try{
		^use[${site:templateFolder}${self.folders.templates}/${params.template}]
		^ShowSearchTemplate[$elements]
	}{
		^site:Catch[$exception;<h1>Ошибка в шаблоне ${self.classModuleDescription}!</h1>]
	}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.folders.templates/${params.template}"</p>}
################################################################################
# ------------------------------------ OLD -------------------------------------
################################################################################
@GetSearchedFiles[cpage]
$result[^files:GetSearchedFiles[$self.searchString;$cpage]]
################################################################################
@GetSearchedNews[cpage]
$result[^news:GetSearchedNews[$self.searchString;$cpage]]
################################################################################
@GetSearchedGoods[cpage;noContent]
$result[^catalog:GetSearchedGoods[$self.searchString;$cpage;$noContent]]
################################################################################
@GetSearchedGoodsByName[cpage]
$result[$result[^catalog:GetSearchedGoodsByName[$self.searchString;$cpage]]]
################################################################################
@GetSearchedGoodsByArtikul[cpage]
$result[$result[^catalog:GetSearchedGoodsByArtikul[$self.searchString;$cpage]]]
################################################################################
@GetSearchedVideos[cpage]
$result[^table::sql{SELECT * FROM $video:videoTable.name WHERE name like '%$self.searchString%' ORDER BY id}[$.limit($self.perPage) $.offset(^eval($cpage*$self.perPage-$self.perPage))]]
################################################################################
@ColorSelect[text]
$rep[^table::create{from	to
$self.searchString	<b class="search">$self.searchString</b>}]
$result[^text.replace[$rep]]
################################################################################