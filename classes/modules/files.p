################################################################################
@CLASS
files
################################################################################
@auto[]
#---------------------------- Информация о классе ------------------------------
$self.className[files]
$self.classVersion[1.0]
$self.classBuildDate[15.10.2013]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.classDescription[Файлы]
$self.classhistory[
 <p align="justify">
  <strong><u>Версия 1.0 (15.10.2013):</u></strong>
  <ol>
   <li>Создан класс <font color="red">files</font> для работы с файлами</li>
  </ol>
 </p>
]
#----------------------------- Рабочие переменные ------------------------------
$self.filesTable[
 $.name[module_files]
 $.file[module_files.table]
]
$self.filesFolder[/files]
$self.filesPath[${self.filesFolder}/module]
$self.downloadFilePath[${self.filesFolder}/download.html?path=]
$self.error[<font color="red"><strong>Ошибка</strong></font>]
# Количество файлов на странице
$self.filesPerPage(1000)
# Папка файлов
$self.filesFolder[/$self.className]
################################################################################
@create[blockId]
$self.blockId($blockId)
################################################################################
@GetClassInfo[]
$result[
 $.module_name[$self.className]
 $.version[$self.classVersion]
 $.build_date[$self.classBuildDate]
 $.developer[$self.classDeveloper]
 $.module_description[$self.classDescription]
 $.history[$self.classHistory]
]
################################################################################
@GetQueryTable[table;query;order;order_type;limitCount;field]
^if(!def $limitCount){$limitCount($self.filesPerPage)}
$result[^table::sql{SELECT *^if(def $field){,$field} FROM $table $query ORDER BY $order $order_type}[$.limit($limitCount)]]
################################################################################
@GetFileById[id]
$result[^table::sql{SELECT * FROM $self.filesTable.name WHERE id=$id}]
################################################################################
@GetFilesByBlockId[block_id]
$result[^table::sql{SELECT * FROM $self.filesTable.name WHERE block_id=$block_id ORDER BY date DESC}]
################################################################################
@Insert[page_id;block_id;name;ext;comment]
$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.filesTable.name WHERE page_id=$page_id AND block_id=$block_id}+10))
$now[^date::now[]]
$result[^void:sql{INSERT INTO $self.filesTable.name (page_id, block_id, name, ext, comment, sortir, date, creation_date) VALUES ($page_id, $block_id, "$name","$ext","$comment",$sortir,"^now.sql-string[]","^now.sql-string[]")}]
################################################################################
@Delete[id]
$result[^void:sql{DELETE FROM $self.filesTable.name WHERE id=$id}]
################################################################################
@DeleteByBlockId[block_id]
$result[^void:sql{DELETE FROM $self.filesTable.name WHERE block_id=$block_id}]
################################################################################
@Update[id;value;field]
^if(!def $field){$field[comment]}
$result[^void:sql{UPDATE $self.filesTable.name SET $field="$value" WHERE id=$id}]
################################################################################
@GetCheckedName[name;page_id;block_id]
$count(^int:sql{SELECT COUNT(id) FROM $self.filesTable.name WHERE name="$name" AND page_id=$page_id AND block_id=$block_id})
$result[${name}^if($count>0){_${count}}]
################################################################################
@Show[block_id]
^if(!def $block_id){$block_id($self.blockId)}
^use[${site:templateFolder}$self.filesFolder/files.html]
^ShowFilesTemplate[$block_id;$self]
################################################################################
@ShowLastFiles[limitCount;tmpl;link]
^if(!def $tmpl){$tmpl[last_files.html]}
^if(-f "${site:templateFolder}${self.filesFolder}/${tmpl}"){
	^try{
		$files[^self.GetLastFilesFromAll[$limitCount]]
		^use[${site:templateFolder}$self.filesFolder/${tmpl}]
		^ShowLastFilesTemplate[$files;$link]
	}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона $tmpl!</h1>]}
}{<p>Невозможно найти шаблон "${site:templateFolder}$self.filesFolder/${tmpl}"</p>}
################################################################################
@GetLastFilesFromAll[limitCount;order;order_type]
^if(!def $limitCount){$limitCount($self.filesPerPage)}
^if(!def $order){$order[date]}
^if(!def $order_type){$order_type[DESC]}
$result[^table::sql{SELECT * FROM $self.filesTable.name ORDER BY $order $order_type}[$.limit($limitCount)]]
################################################################################
@GetSearchedFiles[searchString;cpage]
$result[^table::sql{SELECT * FROM $self.filesTable.name WHERE comment like '%$searchString%' ORDER BY date}[$.limit($self.filesPerPage) $.offset(^eval($cpage*$self.filesPerPage-$self.filesPerPage))]]
################################################################################