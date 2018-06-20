################################################################################
@CLASS
textext
################################################################################
@OPTIONS
locals
################################################################################
@auto[]
$self.classVersion[1.82]
$self.classBuildDate[14.07.2017]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[textext]
$self.classDescription[Класс модуля отображения страницы]
$self.classModuleDescription[Отображение страницы]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Удалена функция <font color="red">^@GetNonPagedBlocks</font>[].</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.82 (14.07.2017):</u></strong>
		<ol>
			<li>В функции <font color="red">^@GetPageBlocks</font>[id], переименовано поле <strong>name</strong> в <strong>caption</strong> и поле <strong>pref_block</strong> в <strong>name</strong> в возвращаемой таблице (table).</li>
			<li>Исправлены названия этих полей в функциях <font color="red">^@GetDisabledBlocks</font>[idpage], <font color="red">^@CheckPageBlocks[pageId^;blockType]</font>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.81 (30.11.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@SetDefaultBlockOptions</font>[block_id^;params], инициализирующая значения опций по умолчанию.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.8 (17.11.2015):</u></strong>
		<ol>
			<li>Переделан интерфейс модуля.</li>
			<li>Функция добавления блока свёрнута в кнопку.</li>
			<li>Добавлена ссылка на страницы сайта</li>
			<li>Добавлена функция <font color="red">^@UpdateModulePathByName</font>[name^;path]</font>, изменяющая путь к модулю <strong>path</strong> по его имени <strong>name</strong>.</li>
			<li>Добавлена функция <font color="red">^@GetBlocksListByName</font>[block_name]</font>, которая возвращает список всех блоков типа <strong>block_name</strong>, созданных в системе.</li>
			<li>Добавлена функция <font color="red">^@RenameOption[block_id^;name^;new_name^;caption]</font>, которая изменяет имя настройки <strong>name</strong> и описание <strong>caption</strong> блока <strong>block_id</strong> на имя <strong>new_name</strong>.</li>
			<li>Добавлена функция <font color="red">^@DeleteOption[block_id^;name]</font>, которая удаляет настройку <strong>name</strong> блока <strong>block_id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.7 (29.07.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetCmsSections[level]</font>, возвращающая таблицу с блоками CMS, доступных для уровня пользователя level.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.6 (12.02.2015):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@GetBlockTypeById[id]</font>, возвращающая тип блока по его id.</li>
			<li>Добавлена функция <font color="red">^@IsSetBlockTypeInPage[page_id^;block_type]</font>, проверяющая, присутствует ли блок типа block_type на странице page_id.</li>
			<li>Переписана функция <font color="red">^@InsertOption[params]</font>, добавляющая настройку для блока.</li>
			<li>Добавлена функция <font color="red">^@CreateBlockContent[blockId^;content]</font>, добавляющая строку с контентом для блока.</li>
			<li>Добавлена функция <font color="red">^@CheckBlockContent[blockId]</font>, проверяющая существование строки с контентом для блока.</li>
			<li>Добавлена функция <font color="red">^@SaveBlockContent[blockId^;content]</font>, сохраняющая строку с контентом для блока.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.5 (30.09.2014):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.imagesPath</font>, содержащая пути к изображениям.</li>
			<li>Добавлена функция <font color="red">^@GetMaterialsImages[idpage]</font>, возвращающая хэш с путями изображений из материалов.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.4 (08.06.2014):</u></strong>
		<ol>
			<li>Добавлена переменная <font color="red">^$self.pageBlockTextsTable</font>, содержащая путь к таблице с контентом.</li>
			<li>Добавлена функция <font color="red">^@GetBlockContent[blockId]</font>, возвращающая контент блока.</li>
			<li>Добавлена функция <font color="red">^@GetFixedText[text^;count^;end]</font>, возвращающая count символов текста от начала и добавляя end в конце текста.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.3 (08.04.2014):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@CheckPageBlocks[pageId^;blockType]</font>, проверяющая блоки страницы.</li>
		</ol>
	</p>
 <p align="justify">
  <strong><u>Версия 1.2 (02.03.2014):</u></strong>
  <ol>
   <li>Добавлена функция <font color="red">^@GetOptions[blockId]</font>, возвращающая настройки для блока blockId.</li>
   <li>Добавлена функция <font color="red">^@GetOptionsCount[blockId]</font>, возвращающая количество настроек для блока blockId.</li>
   <li>Добавлена функция <font color="red">^@InsertOption[id_te^;named^;name^;value^;type_field]</font>, записывающая соответствующую опцию в таблицу.</li>
   <li>Добавлена функция <font color="red">^@UpdateOptionValue[id^;value]</font>, заменяющая значение опции id в таблицу на value.</li>
   <li>Добавлена функция <font color="red">^@DeleteOptions[blockId]</font>,удаляющая все опции блока blockId.</li>
   <li>Перенесена функция <font color="red">^@GetBlockNameById[id]</font> из класса site.</li>
   <li>Добавлена функция <font color="red">^@GetBlockIdByPageId[id^;blockType]</font>.</li>
   <li>Добавлена функция <font color="red">^@GetPageIdByBlockId[id]</font>.</li>
   <li>Добавлена функция <font color="red">^@GetPageTitle[id]</font>, возвращающая имя страницы.</li>
   <li>Добавлена функция <font color="red">^@GetPageKeywords[id]</font>, возвращающая ключевые слова страницы.</li>
   <li>Добавлена функция <font color="red">^@GetPageDescription[id]</font>, возвращающая описание страницы.</li>
   <li>Добавлена функция <font color="red">^@GetPageVisible[id]</font>, возвращающая флаг видимости страницы.</li>
  </ol>
 </p>
 <p align="justify">
  <strong><u>Версия 1.1 (28.11.2013):</u></strong>
  <ol>
   <li>Добавлена функция <font color="red">^@GetOptionValue[name^;blockId^;byDefault]</font>, возвращающая значение настройки name для блока blockId.</li>
  </ol>
 </p>
 <p align="justify">
  <strong><u>Версия 1.0 (17.11.2013):</u></strong>
  <ol>
   <li>Создан класс для модуля "Структура"</li>
   <li>В модуль перенесены настройки раздела из модуля "Структура" в связи с его расформированием за ненадобностью</li>
   <li>Добавлена возможность привязывать и отвязывать блоки</li>
  </ol>
 </p>
]
$self.pageBlocksTable[
 $.name[text_ext]
 $.file[text_ext.table]
]
$self.pageBlockTextsTable[
 $.name[te_text]
 $.file[te_text.table]
]
$self.pageBlockOptionsTable[
 $.name[te_opt]
 $.file[te_opt.table]
]
# Пути к изображениям
$self.imagesPath[
 $.root[/images/${self.className}]
 $.small[/images/${self.className}/small]
 $.big[/images/${self.className}/big]
 $.src[/images/${self.className}/src]
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
@GetPageProperties[id]
$result[^table::sql{SELECT id, head, keywords, descript, email, head AS title, descript AS description FROM $site:menusTable.name WHERE id=$id}]
################################################################################
@GetPageTitle[id]
$result[^string:sql{SELECT head FROM $site:menusTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetPageKeywords[id]
$result[^string:sql{SELECT keywords FROM $site:menusTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetPageDescription[id]
$result[^string:sql{SELECT descript FROM $site:menusTable.name WHERE id=$id}[$.default[]]]
################################################################################
@GetPageVisible[id]
$result(^string:sql{SELECT visible FROM $site:menusTable.name WHERE id=$id})
################################################################################
@GetBlockInfo[id]
$result[^table::sql{SELECT * FROM $self.pageBlocksTable.name WHERE id=$id}]
################################################################################
@GetBlockNameById[id]
$result[^string:sql{SELECT name FROM $self.pageBlocksTable.name WHERE id=$id}]
################################################################################
@GetBlockIdByPageId[id;blockType]
^try{$result(^int:sql{SELECT id FROM $self.pageBlocksTable.name WHERE idpage=$id^if(def $blockType){ AND pref_block="$blockType"}}[$.default(0)])}{$exception.handled(1) $result(0)}
################################################################################
@GetPageIdByBlockId[id]
$result(^int:sql{SELECT idpage FROM $self.pageBlocksTable.name WHERE id=$id}[$.default(0)])
################################################################################
@GetPageBlocks[id]
$result[^table::sql{SELECT id, name AS caption, pref_block AS name, sortir, last_page_id FROM $self.pageBlocksTable.name WHERE idpage=$id ORDER BY sortir}]
################################################################################
@UpdatePageBlockName[id;name]
$result(^void:sql{UPDATE $self.pageBlocksTable.name SET name='$name' WHERE id=$id})
################################################################################
@LinkBlock[id;idpage]
$maxId(^int:sql{SELECT MAX(sortir) FROM $self.pageBlocksTable.name WHERE idpage=$idpage}[$.default(0)])
$result(^void:sql{UPDATE $self.pageBlocksTable.name SET idpage=$idpage, sortir=^eval($maxId+1) WHERE id=$id})
################################################################################
@UnLinkBlock[id;idpage]
$result(^void:sql{UPDATE $self.pageBlocksTable.name SET idpage=0, last_page_id=$idpage WHERE id=$id})
################################################################################
@UpdatePageProperty[id;property;value]
^try{
	^void:sql{UPDATE $site:menusTable.name SET $property='$value' WHERE id=$id}
	$result(1)
}{
	$exception.handled(true)
	$result(0)
}
################################################################################
@InsertPageBlock[idpage;name;blockName]
$maxid(^int:sql{SELECT MAX(sortir) FROM $self.pageBlocksTable.name WHERE idpage=$idpage}[$.default(0)])
$result(^void:sql{INSERT INTO $self.pageBlocksTable.name (name, idpage, pref_block, sortir) VALUES ('$name', $idpage, '$blockName', ^eval($maxid+1))})
################################################################################
@Delete[id]
$result[^void:sql{DELETE FROM $self.pageBlocksTable.name WHERE id=$id}]
################################################################################
@ChangeBlockPosition[idpage;id;up]
$curentPosition(^int:sql{SELECT sortir FROM $self.pageBlocksTable.name WHERE idpage=$idpage AND id=$id}[$.default(1000)])
^if(def $up){
 $changeId(^int:sql{SELECT id FROM $self.pageBlocksTable.name WHERE idpage=$idpage AND sortir<$curentPosition ORDER BY sortir DESC LIMIT 1}[$.default(1000)])
}{
 $changeId(^int:sql{SELECT id FROM $self.pageBlocksTable.name WHERE idpage=$idpage AND sortir>$curentPosition ORDER BY sortir LIMIT 1}[$.default(1000)])
}
$changePosition(^int:sql{SELECT sortir FROM $self.pageBlocksTable.name WHERE idpage=$idpage AND id=$changeId}[$.default(1001)])
^void:sql{UPDATE $self.pageBlocksTable.name SET sortir=$changePosition WHERE idpage=$idpage AND id=$id}
^void:sql{UPDATE $self.pageBlocksTable.name SET sortir=$curentPosition WHERE idpage=$idpage AND id=$changeId}
################################################################################
@GetDisabledBlocks[idpage]
$pageBlocks[^self.GetPageBlocks[$idpage]]
# Если есть хоть 1 блок на странице
^if(def $pageBlocks){
# Если нет блока "redirect"
 ^if(^self.GetCountPageBlock[$idpage;redirect]==0){
  $text[redirect^#0A]
  ^pageBlocks.menu{
# Блоки в одном экземпляре
   ^if($pageBlocks.name eq 'news' || $pageBlocks.name eq 'catalog' || $pageBlocks.name eq 'comments' || $pageBlocks.name eq 'responses'){
    ^if(^self.GetCountPageBlock[$idpage;$pageBlocks.name]>0){$text[${text}$pageBlocks.name^#0A]}
   }
  }
# Если есть блок "redirect"
 }{$text[${text}$pageBlocks.name^#0A]}
}
# Возвращаем результат
$result[^table::create{name
$text
}]
################################################################################
@CheckDisabledBlock[blockName;disabledBlocks]
$res(0)
^disabledBlocks.menu{
 ^if($disabledBlocks.name eq $blockName){$res(1)}
}
$result($res)
################################################################################
@GetCountPageBlock[idpage;name]
$result(^int:sql{SELECT COUNT(id) FROM $self.pageBlocksTable.name WHERE pref_block='$name' AND idpage=$idpage}[$.default(0)])
################################################################################
@GetOptions[blockId]
$result[^table::sql{SELECT * FROM $self.pageBlockOptionsTable.name WHERE id_te=$blockId ORDER BY id}]
################################################################################
@GetOptionValue[name;blockId;byDefault]
$res[^string:sql{SELECT value FROM $self.pageBlockOptionsTable.name WHERE id_te=$blockId AND name='$name'}[$.default{$byDefault}]]
$result[^if(def $res){$res}{$byDefault}]
################################################################################
@GetOptionsCount[blockId]
$result(^int:sql{SELECT count(id) FROM $self.pageBlockOptionsTable.name WHERE id_te=$blockId}[$.default(0)])
################################################################################
@UpdateOptionValue[id;value]
$result[^void:sql{UPDATE $self.pageBlockOptionsTable.name SET value='$value' WHERE id=$id}]
################################################################################
@DeleteOptions[blockId]
$result[^void:sql{DELETE FROM $self.pageBlockOptionsTable.name WHERE id_te=$blockId}]]
################################################################################
@CheckPageBlocks[pageId;blockType]
$blocks[^self.GetPageBlocks[$pageId]]
$flag(0)
^blocks.menu{
 ^if($blocks.name eq '$blockType'){$flag(1)}
}
$result($flag)
################################################################################
@GetBlockContent[blockId]
$result[^untaint{^string:sql{SELECT content FROM $self.pageBlockTextsTable.name WHERE id='$blockId'}[$.default[]]}]
################################################################################
@CreateBlockContent[blockId;content]
$result[^void:sql{INSERT INTO $self.pageBlockTextsTable.name (id, content) VALUES ($blockId, "$content")}]
################################################################################
@SaveBlockContent[blockId;content]
^if(^int:sql{SELECT COUNT(id) FROM $self.pageBlockTextsTable.name WHERE id='$blockId'}==0){
	$res[^void:sql{INSERT INTO $self.pageBlockTextsTable.name (id, content) VALUES ($blockId, '$content')}]
	$result(1)
}{
	$res[^void:sql{UPDATE $self.pageBlockTextsTable.name SET content='$content' WHERE id=$blockId}]
	$result(1)
}
################################################################################
@CheckBlockContent[blockId]
$cnt(^int:sql{SELECT COUNT(id) FROM $self.pageBlockTextsTable.name WHERE id=$blockId})
^if($cnt>0){$result(true)}{$result(false)}
################################################################################
@GetFixedText[text;count;end]
^if(^text.length[]>$count){
 $res[^text.left(^eval($count-^end.length[]))]
 $parts[^res.split[ ;rh]]
 $res[^text.left(^eval($count-^end.length[]-^parts.0.length[]))]
 $result[${res}${end}]
}{
 $result[$text]
}
################################################################################
@GetMaterialsImages[idpage]
$path[/images/${textext:className}/small/${idpage}/]
$list[^file:list[$path]]
$counter(0)
$images[
 ^list.menu{
  ^if($list.name ne 'tmp'){
   $.[$counter][
    $.full_name[$list.name]
    $.name[^file:justname[$list.name]]
    $.ext[^file:justext[$list.name]]
   ]
   ^counter.inc[]
  }
 }
]
$result[$images]
################################################################################
@GetBlockTypeById[id]
$result[^string:sql{SELECT pref_block FROM $self.pageBlocksTable.name WHERE id=$id}]
################################################################################
@IsSetBlockTypeInPage[page_id;block_type]
$blocks_count(^int:sql{SELECT COUNT(id) FROM $self.pageBlocksTable.name WHERE idpage=$page_id AND pref_block="$block_type"})
^if($blocks_count>0){$result(true)}{$result(false)}
################################################################################
@InsertOption[params]
^if(def $params.block_id && def $params.name){
	^if(!def $params.type_field){$params.type_field(0)}
	^try{
		$res[^void:sql{
			INSERT INTO $self.pageBlockOptionsTable.name
			(
				id_te,
				named,
				name,
				value,
				type_field
			)
			VALUES
			(
				$params.block_id,
				'$params.caption',
				'$params.name',
				'$params.value',
				$params.type_field
			)
		}]]
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@RenameOption[block_id;name;new_name;caption]
^if(def $block_id && def $name && def $new_name){
	^try{
		^void:sql{UPDATE $self.pageBlockOptionsTable.name SET name='$new_name'^if(def $caption){, named='$caption'} WHERE name='$name'}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteOption[block_id;name]
^if(def $block_id && def $name){
	^try{
		^void:sql{DELETE FROM $self.pageBlockOptionsTable.name WHERE id_te=$block_id AND name='$name'}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@GetBlocksListByName[block_name]
^if(def $block_name){
	^try{
		$result[^table::sql{
			SELECT id, name
			FROM $self.pageBlocksTable.name
			WHERE `pref_block`='$block_name'
		}]
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@SetDefaultBlockOptions[block_id;params]
^if(def $params.moduleName){
	^if(!def $block_id){$block_id($self.blockId)}
	^try{
		$sql_query[INSERT INTO $self.pageBlockOptionsTable.name (id_te, named, name, value, type_field) VALUES]
		$counter(0)
		$this[^reflection:create[${params.moduleName}_cms;create]]
		^this.moduleOptions.main.foreach[key;value]{
			^counter.inc[]
			$sql_query[$sql_query^if($counter>1){,} ($block_id, '$value.caption', '$key', '^if(def $params.[$key]){$params.[$key]}{$value.value}', $value.type_field)]
		}
		^void:sql{$sql_query}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################