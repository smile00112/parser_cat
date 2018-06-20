################################################################################
@CLASS
accounts_cms
################################################################################
@USE
user.p
################################################################################
@BASE
user
################################################################################
@auto[]
$self.className[accounts]
$self.modulePath[$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.usersTable.name]
		$.2[$self.messagesTable.name]
		$.3[$self.imagesTable.name]
		$.4[$self.blogTable.name]
	]
	$.superfluous[
	]
	$.rename[
	]
]
$self.moduleOptions[
	$.main[
	]
	$.rename[
	]
]
################################################################################
@create[blockId]
################################################################################
@InsertAccount[params]
$answer[^hash::create[]]
^try{
# Если передаётся логин и пароль
	^if(def $params.login && def $params.password){
		^if(^int:sql{SELECT COUNT(id) FROM $self.usersTable.name WHERE username='$params.login'}){
			$answer.error(true)
			$answer.text[Пользователь с таким именем уже существует]
		}{
			$res[^void:sql{
				INSERT INTO $self.usersTable.name
					(username, u_password_md5, user_regdate)
				VALUES
					("$params.login", "^math:md5[$params.password]", "^site:currentDate.unix-timestamp[]")
			}]
# Делаем запись в лог
			$params[
				$.module[$self.className]
				$.module_id[$params.block_id]
				$.method[InsertAccount]
				$.description[Добавление аккаунта]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[Элемент добавлен]
		}
	}{
		$answer.error(true)
		$answer.text[Не хватает параметров]
	}
}{
	$exception.handled(true)
	$answer.error(true)
	$answer.text[Ошибка добавления]
	$answer.detail[
		<p align="center">Функция: <strong>$exception.source</strong>, ошибка: <strong>$exception.comment</strong></p>
		<p align="center">Файл: <strong>$exception.file</strong>, строка: <strong>$exception.lineno</strong></p>
	]
}
$result[$answer]
################################################################################
@SaveProperty[id;name;value]
^if(def $id && def $name){
	^try{
		$res[^void:sql{UPDATE $self.usersTable.name SET $name='$value' WHERE id=$id}]
# Делаем запись в лог
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[$self.blockId]
			$.method[SaveProperty]
			$.description[Поле "$name" изменено]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer[
			$.error(false)
			$.text[Значение сохранено]
		]
	}{
		$exception.handled(true)
		$answer[
			$.error(true)
			$.text[Ошибка выполнения функции]
			$.exception[$exception]
		]
	}
}{
	$answer[
		$.error(true)
		$.text[Переданы не все параметры]
	]
}
$result[$answer]
################################################################################
@DeleteAccount[account_id]
$answer[^hash::create[]]
^if(def $account_id){
	^try{
		$account[^table::sql{SELECT * FROM $self.usersTable.name WHERE id=$account_id}]
		^if(def $account){
			$res[^void:sql{DELETE FROM $self.usersTable.name WHERE id=$account_id}]
	# Делаем запись в лог
			$params[
				$.unit_id[$account_id]
				$.module[$self.className]
				$.module_id[]
				$.method[DeleteAccount]
				$.description[Удаление аккаунта $account.login]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[Аккаунт удалён]
		}{
			$answer.error(true)
			$answer.text[Аккаунт с ID=$account_id не найден]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
		$answer.exception[$exception]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID аккаунта]
}
$result[$answer]
################################################################################
@SetAccountBlock[account_id]
$answer[^hash::create[]]
^if(def $account_id){
	^try{
		$block(^int:sql{SELECT block FROM $self.usersTable.name WHERE id=$account_id})
		^if($block == 1){$block(0)}{$block(1)}
		$res[^void:sql{UPDATE $self.usersTable.name SET block='$block' WHERE id=$account_id}]
# Делаем запись в лог
		$params[
			$.unit_id[$account_id]
			$.module[$self.className]
			$.module_id[]
			$.method[SetAccountBlock]
			$.description[^if($block){Разблокировка}{ Блокировка} аккаунта]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.block($block)
		$answer.error(false)
		$answer.text[Аккаунт^if($block){ заблокирован}{ разблокирован}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[Ошибка выполнения функции]
	}
}{
	$answer.error(true)
	$answer.text[Не передан ID аккаунта]
}
$result[$answer]
################################################################################