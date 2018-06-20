################################################################################
@CLASS
users
################################################################################
@auto[]
#---------------------------- Информация о классе ------------------------------
$self.className[users]
$self.classVersion[1.1]
$self.classBuildDate[26.12.2016]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.classDescription[users]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создана переменная <font color="#cc0000">^$self.cmsUserLevels</font>, которая хранит информацию об уровнях доступа пользователя.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (20.11.2014):</u></strong>
		<ol>
			<li>Создан класс ${self.className}.</li>
		</ol>
	</p>
]
#----------------------------- Рабочие переменные ------------------------------
$self.cmsUserLevels[
	$.user[
		$.label[Пользователь]
		$.description[Стандартный пользователь с ограниченными правами доступа]
		$.level(0)
	]
	$.administrator[
		$.label[Администратор]
		$.description[Администратор сайта со всеми права на управление сайтом]
		$.level(1)
	]
	$.programmer[
		$.label[Программист]
		$.description[Имеет неограниченный доступ]
		$.level(10)
	]
]
#------------------------------ Имена SQL-таблиц -------------------------------
# Имена SQL-таблиц
$self.adminsTable[
	$.name[admins]
	$.file[admins.table]
]
$self.cmsAccessTable[
	$.name[cms_access]
	$.file[cms_access.table]
]
$self.blocksTable[
	$.name[cmc_block]
	$.file[cmc_block.table]
]
# ------------------------------------------------------------------------------
################################################################################
@create[]
################################################################################
@GetClassInfo[]
$result[
 $.className[$self.className]
 $.classVersion[$self.classVersion]
 $.classBuildDate[$self.classBuildDate]
 $.classDeveloper[$self.classDeveloper]
 $.classDescription[$self.classVersion]
 $.classHistory[$self.classVersion]
]
################################################################################
@GetAdmins[user_level]
^if(!def $user_level){$user_level(0)}
$result[^table::sql{SELECT login, fio, level FROM $self.adminsTable.name WHERE level<='$user_level' ORDER BY level DESC, login}]
################################################################################
@GetAdmin[login]
$result[^table::sql{SELECT login, fio, level FROM $self.adminsTable.name WHERE login='$login'}]
################################################################################
@UpdateAdminInfo[info]
^if(def $info.login){
 $tmp[^void:sql{UPDATE $self.adminsTable.name SET login='$info.login'^if(def $info.fio){, fio='$info.fio'}^if(def $info.password){, password='$info.password'} WHERE login='$info.login'}]
}
################################################################################
@CryptPassword[pass]
$result[^math:crypt[$pass;^$apr1^$AutoPhS]]
################################################################################
@InsertNewAdmin[info]
^try{
 $tmp[^void:sql{INSERT INTO $self.adminsTable.name (login, password, fio, level) VALUES ('$info.login', '$info.pass', '$info.fio', '$info.level')}]
 $tmp[^self.SetUserAccessByLevel[$info.login;$info.level]]
 $result(1)
}{
 $exception.handled(1)
 $result(0)
}
################################################################################
@AddBlockToUserAccess[login;blockId]
$result[^void:sql{INSERT INTO $self.cmsAccessTable.name (login, block_id) VALUES ('$login', '$blockId')}]
################################################################################
@DelBlockFromUserAccess[login;blockId]
$result[^void:sql{DELETE FROM $self.cmsAccessTable.name WHERE login="$login" AND block_id="$blockId"}]
################################################################################
@InsertAccessModule[login;vblock]
$blockId[^int:sql{SELECT id FROM $self.blocksTable.name WHERE nameblock='$vblock'}[$.default{0}]]
^if($blockId>0){
 $result[^self.AddBlockToUserAccess[$login;$blockId]]
}
################################################################################
@DelAdmin[login]
^try{
 $tmp[^void:sql{DELETE FROM $self.adminsTable.name WHERE login='$login'}]
 $tmp[^void:sql{DELETE FROM $self.cmsAccessTable.name WHERE login='$login'}]
 $result(1)
}{
 $exception.handled(1)
 $result(0)
}
################################################################################
@GetCMSBlocks[blockType]
$result[^table::sql{SELECT * FROM $self.blocksTable.name^if(def $blockType){ WHERE block=$blockType}}]
################################################################################
@SetUserAccessByLevel[login;level]
# Получаем список модулей сайта
$blocks[^self.GetCMSBlocks[]]
# Формируем хэш доступов
$access[^blocks.hash[nameblock][level][$.type[string]]]
# Инициализируем его значениями
^blocks.menu{
 ^if($access.[$blocks.nameblock] > $level){$access.[$blocks.nameblock](0)}{$access.[$blocks.nameblock](1)}
}
# Инициализируем счётчик для правильного отобращения запятой
$counter(0)
# Формируем переменную для запроса
$sql[INSERT INTO $self.cmsAccessTable.name (login, block_id) VALUES]
# Добавляем в неё данные для внесение в БД
$sql[$sql
^blocks.menu{
 ^counter.inc[]
 ^if($access.[$blocks.nameblock]==1){^if($counter > 1){,} ('$login', $blocks.id)}
}
]
# Ставим финальную точку с запятой
$sql[$sql^;]
# Исполняем запрос к БД
$result[^void:sql{$sql}]
################################################################################
@GetUserAccess[login]
$result[^table::sql{SELECT block_id FROM $self.cmsAccessTable.name WHERE login="$login"}]
################################################################################
@UpdateUserAccess[login]
# Получаем информацию о пользователе
$admin[^self.GetAdmin[$login]]
# Получаем список модулей сайта
$blocks[^self.GetCMSBlocks[]]
# Получаем список доступов пользователя
$access[^self.GetUserAccess[$login]]
# Для каждого блока
^blocks.menu{
# Проверяем есть ли он в таблице доступов
 ^if(!^access.locate[block_id;$blocks.id]){
# Если нет, проверяем, есть ли у пользователя к нему доступ
  ^if($admin.level>=$blocks.level){
# Если есть - добавляем
   $tmp[^void:sql{INSERT INTO $self.cmsAccessTable.name (login, block_id) VALUES ('$login', $blocks.id)}]
  }
 }
}
################################################################################
@UpdateUsersAccess[]
$admins[^self.GetAdmins[10]]
^admins.menu{
 ^self.UpdateUserAccess[$admins.login]
}
################################################################################
@CheckUserAccessToBlock[login;blockId]
$access[^self.GetUserAccess[$login]]
^if(^access.locate[block_id;$blockId]){$result(1)}{$result(0)}
################################################################################
@ChangeUserAccessToBlock[login;blockId]
^if(^self.CheckUserAccessToBlock[$login;$blockId]){
 $result[^self.DelBlockFromUserAccess[$login;$blockId]]
}{
 $result[^self.AddBlockToUserAccess[$login;$blockId]]
}
################################################################################
@GetCMSBlocksForUser[login;parent]
^if(!def $parent){$parent(0)}
$result[^table::sql{SELECT * FROM $self.blocksTable.name AS b INNER JOIN (SELECT * FROM $self.cmsAccessTable.name WHERE login="$login") AS a ON a.block_id=b.id WHERE b.block<>1 AND b.parent=$parent ORDER BY b.id}]
################################################################################
@CheckBlockChilds[blockId]
$blocks[^self.GetCMSBlocks[]]
^if(^blocks.locate[parent;$blockId]){$result(1)}{$result(0)}
################################################################################