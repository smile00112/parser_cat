################################################################################
@CLASS
neighbours_list
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[11.07.2014]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[neighbours_list]
$self.classDescription[Класс модуля списка соседних страниц]
$self.classModuleDescription[Список соседних страниц]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.0 (18.12.2013):</u></strong>
  <ol>
   <li>Создан класс для модуля "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# Путь к шаблону
$self.neighboursFolder[/$self.className]
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
@Show[block_id]
^if(!def $block_id){$block_id($self.blockId)}
^use[${site:templateFolder}${self.neighboursFolder}/index.html]
^ShowNeighboursTemplate[$block_id]
################################################################################