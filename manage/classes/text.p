################################################################################
@CLASS
text
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[30.09.2014]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[text]
$self.classDescription[Класс модуля 'Текст и изображение']
$self.classModuleDescription[Модуль 'Текст и изображение']
$self.classHistory[
 <p align="justify">
  <strong><u>Версия 1.0 (30.09.2014):</u></strong>
  <ol>
   <li>Создан класс для модуля "Текст и изображение"</li>
  </ol>
 </p>
]
# Таблица "text"
$self.textTable[
 $.name[te_text]
 $.file[te_text.table]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
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
@GetBlock[id]
$result[^table::sql{SELECT id, content FROM $self.textTable.name WHERE id='$id'}]
################################################################################
# Создание настроек
@CreateOptions[id]
^void:sql{INSERT INTO $textext:pageBlockOptionsTable.name (id_te, named, name, value, type_field) VALUES
('$id','Изображение','block_image','noImage.png',10)}
################################################################################