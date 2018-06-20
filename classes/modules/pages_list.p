################################################################################
@CLASS
pages_list
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[18.12.2013]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[pages_list]
$self.classDescription[Класс модуля списка страниц]
$self.classModuleDescription[Список страниц]
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.0 (18.12.2013):</u></strong>
  <ol>
   <li>Создан класс для модуля "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# Путь к шаблону
$self.plFolder[/$self.className]
################################################################################
@create[blockId]
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
^site:ShowTemplate[${site:templateFolder}${self.plFolder}/index.html]
^site:ShowPlTemplate[$block_id]
################################################################################