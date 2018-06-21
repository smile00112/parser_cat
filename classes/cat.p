################################################################################
@CLASS
cat
################################################################################
@auto[]
$self.classVersion[1.00]
$self.classBuildDate[19.06.2018]
$self.classDeveloper[...]
$self.className[auth]
$self.classDescription[Класс для табл cats_list для модуля КОТЫ]
$self.classModuleDescription[КОТЫ]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Добавлена таблица <font color="red">$self.fieldsTable.name</font>, которая содержит регистрационные поля.</li>
			<li>Добавлена функция <font color="red">^@GetFields[params]</font>, которая возвращает список регистрационных полей.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.1 (12.06.2017):</u></strong>
		<ol>
			<li>Добавлена функция <font color="red">^@NewUserBySocial[]</font>, которая создаёт пользователя по полученным данным из соц. сетей.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>Версия 1.0 (24.06.2014):</u></strong>
		<ol>
			<li>Создан класс для модуля "Авторизация"</li>
		</ol>
	</p>
]
# Таблица "Сессии"
$self.sessionsTable[
	$.name[auth_asession]
	$.file[auth_asession.table]
]
# Таблица "Пользователи"
$self.accountsTable[
	$.name[auth_accounts]
	$.file[auth_accounts.table]
]

# Таблица "Список котов"
$self.cats_list_table[
	$.name[cats_list]
	$.file[cats_list.table]
]
# Таблица "фотографии котов"
$self.cats_foto_table[
	$.name[cats_foto]
	$.file[cats_foto.table]
]
# Имя куки
$self.cookiename[auth_sid]
# IP-адрес пользователя
$user_ip[$env:REMOTE_ADDR]
# IP-адрес пользователя в 16-ричном формате
$user_ip16[^user_ip.match[(\d+)\.(\d+)\.(\d+)\.(\d+)][g]{^match.1.format[%02x]^match.2.format[%02x]^match.3.format[%02x]^match.4.format[%02x]}]
# Папка Авторизации
$self.authFolder[/user]
################################################################################
@create[]
# Если куки нет, то создать её
^if(!def $cookie:[$self.cookiename]){
	^self.WriteCookie[$self.cookiename;^self.makeRandomID[]]
}
# Если кука есть
^if(def $cookie:[$self.cookiename]){
	$self.session[^self.FindSession[$cookie:[$self.cookiename];$self.user_ip16]]
	^if($self.session.user_id>0){
		$self.user[^self.getUserByID[$self.session.user_id]]
	}
}{
# куки не поддерживаются
	$self.status[cookie not enabled]
}
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
# Ищем сессию в бд с кукой пользователя и возвращаем строку из таблицы $self.sessionsTable.name
@FindSession[sSid;sIPAddr]
$nowdec1[^date::create($site:currentDate-1/6)]
^connect[$site:connectString]{
	^void:sql{DELETE FROM $self.sessionsTable.name WHERE dt_logon < '^nowdec1.sql-string[]'}
	$findsession[^table::sql{SELECT id, user_id, sid, ipaddr FROM $self.sessionsTable.name WHERE sid='$sSid' AND ipaddr='$sIPAddr'}]
# Если есть, выдергиваем данные из таблицы, если нет, пишем в бд и выдергиваем данные
	^if($findsession){
		^void:sql{UPDATE $self.sessionsTable.name SET dt_logon='^site:currentDate.sql-string[]' WHERE sid='$sSid' AND ipaddr='$sIPAddr'}
		$result[$findsession]
	}{
		$result[^self.WriteAsession[0;$sSid;^site:currentDate.sql-string[];$sIPAddr]]
	}
}
################################################################################
# Записываем в $self.sessionsTable.name строку сессии и возвращаем данные из таблицы $self.sessionsTable.name
@WriteAsession[iUser;sSid;dDtlogon;sIPAddr]
^connect[$site:connectString]{
	^void:sql{INSERT INTO $self.sessionsTable.name (user_id, sid, dt_logon, ipaddr) VALUES ('$iUser', '$sSid', '$dDtlogon', '$sIPAddr')}
	$result[^table::sql{SELECT id, user_id, sid, ipaddr FROM $self.sessionsTable.name WHERE sid='$sSid' AND ipaddr='$sIPAddr'}]
}
#################################################################
@WriteCookie[sName;sValue;iExpires]
^if(def $sName){
	$cookie:[$sName][
		$.value[$sValue]
		^if($iExpires){
			$.expires($iExpires)
		}{
			$.expires[session]
		}
	]
}
$result[]
################################################################################
@makeRandomID[]
$result[
	^math:md5[
		^site:currentDate.sql-string[]
		^math:random(1000000)
	]
]
^if(^result.length[] >= 63){$result[^result.left(63)]}
################################################################################
# Возвращаем все данные пользователя
@getUserByID[iUserID]
^if(def $iUserID){$whereid[$iUserID]}{$whereid(0)}
^connect[$site:connectString]{$result[^table::sql{SELECT * FROM $self.accountsTable.name WHERE id='$whereid'}]}
################################################################################
# Удаление пользователя
@delUserByID[iUserID]
^connect[$site:connectString]{
	^void:sql{DELETE FROM $self.accountsTable.name WHERE id='$iUserID'}
	^void:sql{DELETE FROM $self.sessionsTable.name WHERE id='$iUserID'}
}
################################################################################
# Возвращаем всех пользователей
@getAllUsers[]
^connect[$site:connectString]{$result[^table::sql{SELECT * FROM $self.accountsTable.name ORDER BY id}]}
################################################################################
# Возвращаем кол-во пользователей у которых такой же логин
@checkUserByLogin[sLogin]
$sLogin_no_rus[^sLogin.match[\b([а-я]+)\b(\s+|^$)][gi]{}]
^connect[$site:connectString]{$result(^int:sql{SELECT COUNT(*) FROM $self.accountsTable.name WHERE login='$sLogin'})}
################################################################################
# Проверяем является ли строка адресом электронной почты
@isEmail[sEmail][result]
$result(def $sEmail && ^sEmail.pos[@] > 0 && ^sEmail.match[^^(?:[-a-z\d\+\*\/\?!{}`~_%&'=^^^$#]+(?:\.[-a-z\d\+\*\/\?!{}`~_%&'=^^^$#]+)*)@(?:[-a-z\d_]+\.){1,60}[a-z]{2,6}^$][i])
################################################################################
# Вход
@LogIn[sLogin;sPassword]
$pass_md5[^math:md5[$sPassword]]
^connect[$site:connectString]{
	$currentUser[^table::sql{SELECT * FROM $self.accountsTable.name WHERE login='$sLogin' AND password='$pass_md5'}]
	$currentUser[^currentUser.hash[id]]
	$currentUser[^currentUser.at[first]]
	^if(def $currentUser && def $self.session.id){
		^void:sql{UPDATE $self.sessionsTable.name SET user_id='$currentUser.id' WHERE id='$self.session.id'}
# Проставляем последний визит
		^void:sql{UPDATE $self.accountsTable.name SET last_visit_date='^site:currentDate.sql-string[]' WHERE id='$currentUser.id'}
		$result[
			$.login(true)
			$.user[$currentUser]
		]
	}{
		$result[
			$.login(false)
			$.text[user not fount or sid not defined]
		]
	}
}
################################################################################
# Выход
@LogOut[]
^if(def $self.session.id){
	^connect[$site:connectString]{^void:sql{UPDATE $self.sessionsTable.name SET user_id='0' WHERE id='$self.session.id'}}
	^self.WriteCookie[$cookiename]
	$result[logout]
}{
	$result[sid not defined]
}
################################################################################
# Вход под демоном
@Demon[iUser;iSid;params]
^if(def $iUser){
	^if(!def $iSid){$iSid[$self.session.id]}
	^connect[$site:connectString]{
		^void:sql{UPDATE $self.sessionsTable.name SET user_id='$iUser' WHERE id='$iSid'}
		^if($params.saveVisit){
			^void:sql{UPDATE $self.accountsTable.name SET last_visit_date='^site:currentDate.sql-string[]' WHERE id='$iUser'}
		}
	}
	$result[
		$.error(false)
		$.text[Пользователь авторизован]
	]
}{
	$result[
		$.error(false)
		$.text[iUser or iSid not defined]
	]
}
################################################################################
@NewUser[hParams;sProject]
^if(!def $sProject){$sProject[main]}
$errors[^hash::create[]]
# Проверка поля "Логин"
^if(def $hParams.login){
	^if(^self.checkUserByLogin[$hParams.login] ne 0){
		$errors.login[Логин уже занят]
	}
}{
	$errors.login[Не заполнено поле Логин]
}
# Проверка поля "Пароль"
^if(def $hParams.password){
	^if($hParams.password ne $hParams.confirm){
		$errors.password[Пароли не совпадают]
	}
}{
	$errors.password[Не заполнено поле Пароль]
}
# Проверка поля "E-Mail"
^if(def $hParams.email){
	^if(!^self.isEmail[$hParams.email]){
		$errors.email[Указан не корректный email]
	}
}
# Проверка заполненности необходимых полей проекта
$reg_fields[^self.allFields[]]
^reg_fields.menu{
	^if($reg_fields.project eq $sProject && $reg_fields.ob eq '*' && ($reg_fields.event eq all || $reg_fields.event eq new)){
		^if(!def $hParams.[$reg_fields.name]){
			$errors.[$reg_fields.name][Не заполнено поле $reg_fields.public]
		}
	}
}
# Вывод информации
^if(!def $errors){
	$new_sql_fields[login, password, email, create_date]
	$new_sql_values['$hParams.login','^math:md5[$hParams.password]','$hParams.email','^site:currentDate.sql-string[]']
	^reg_fields.menu{
		^if(($reg_fields.project eq $sProject || $reg_fields.project eq main) && (!$reg_fields.main) && ($reg_fields.event eq all || $reg_fields.event eq new)){
			$new_sql_fields[$new_sql_fields, $reg_fields.sqlField]
			$new_sql_values[$new_sql_values, '$hParams.[$reg_fields.name]']
		}
	}
	^connect[$site:connectString]{^void:sql{INSERT INTO $self.accountsTable.name ($new_sql_fields) VALUES ($new_sql_values)}}
	$answer[^self.LogIn[$hParams.login;$hParams.password]]
	^if($answer.login){
		$result[
			$.error(false)
			$.text[Пользователь создан]
		]
	}{
		$result[
			$.error(true)
			$.text[$answer.text]
		]
	}
}{
	$result[
		$.error(true)
		$.text[Ошибка создания пользователя]
		$.errors[^hash::create[$errors]]
	]
}
################################################################################
@NewUserFromForm[]
$fields[^self.allFields[]]
$create_date[^site:currentDate.sql-string[]]
$sql_fields[create_date]
$sql_values['$create_date']
^fields.menu{
	^if(def $form:[$fields.name]){
		$sql_fields[$sql_fields, $fields.sqlField]
		$sql_values[$sql_values, '$form:[$fields.name]']
	}
}
$res[^void:sql{INSERT INTO $self.accountsTable.name ($sql_fields) VALUES ($sql_values)}]
$result(^int:sql{SELECT id FROM $self.accountsTable.name WHERE create_date='$create_date'}[$.default(0)])
################################################################################
@NewUserfast[hParams]
$gen_logpwd[^self.makeRandomID[]]
^connect[$site:connectString]{
	^if(^self.checkUserByLogin[$gen_logpwd] eq 0){
		^void:sql{INSERT INTO $self.accountsTable.name (login, password, email, first_name, phone) VALUES ('$gen_logpwd', '^math:md5[$gen_logpwd]', '$hParams.email', '$hParams.first_name', '$hParams.phone')}
		^self.LogIn[$gen_logpwd;$gen_logpwd]
		$response:location[/basket/order/]
	}{
		<p>Ошибка, повторите попытку</p>
	}
}
################################################################################
@NewUserBySocial[login;password;userInfo]
^if(def $login && def $password && def $userInfo){
	^if(^self.checkUserByLogin[$login] == 0){
		^try{
			$sql_fields[login, password, create_date]
			$sql_values['$login', '^math:md5[$password]', '^site:currentDate.sql-string[]']
			^userInfo.foreach[key;value]{
				^if($key ne 'id' && $key ne 'user_id' && $key ne 'network' && $key ne 'network_user_id' ){
					$sql_fields[${sql_fields}, $key]
					$sql_values[${sql_values}, '$value']
				}
			}
			^void:sql{INSERT INTO $self.accountsTable.name ($sql_fields) VALUES ($sql_values)}
			$user_id(^int:sql{SELECT id FROM $self.accountsTable.name WHERE login='$login'}[$.default(0)])
			^void:sql{UPDATE $social:socialAccountsTable.name SET user_id=$user_id WHERE network_user_id='$userInfo.network_user_id' AND network='$userInfo.network'}
			$result[
				$.error(false)
				$.user_id($user_id)
			]
		}{
			$exception.handled(true)
			$result[
				$.error(true)
				$.text[Ошибка выполнения функции]
				$.exception[$exception]
			]
		}
	}{
		$result[
			$.error(true)
			$.text[Пользователь с таким логином занят]
			$.user_id(^int:sql{SELECT id FROM $self.accountsTable.name WHERE login='$login'}[$.default(0)])
		]
	}
}{
	$result[
		$.error(true)
		$.text[Недостаточно данных]
	]
}
################################################################################
@EditUser[hParams;sProject]
$edit_user_error[]
$new_password[]
^if(def $hParams.password){
	$new_password[, password='^math:md5[$form:password]']
	^if(def $edit_user_error){
		$edit_user_error
#		^self.registration_form[$sProject;$hParams.faction;$hParams.back]
	}{
#		Проверка заполненности необходимых полей проекта
		$reg_fields[^self.allFields[]]
		^reg_fields.menu{
			^if($reg_fields.project eq $sProject && $reg_fields.ob eq '*' && ($reg_fields.event eq all || $reg_fields.event eq reg)){
				^if(!def $form:[$reg_fields.name]){$form_def_error[error]}
			}
		}
		^if($form_def_error eq error){
			$form_def_error
#			^self.registration_form[$sProject;$hParams.faction;$hParams.back]
		}{
			$new_sql_fields_update[email='$form:email' $new_password]
			^reg_fields.menu{
				^if(($reg_fields.project eq $sProject && ($reg_fields.event eq all || $reg_fields.event eq reg))){
					^if(def $reg_fields.sqlField){
						$new_sql_fields_update[$new_sql_fields_update, $reg_fields.sqlField='$form:[$reg_fields.name]']
					}
				}
			}
			^connect[$site:connectString]{^void:sql{UPDATE $self.accountsTable.name SET $new_sql_fields_update WHERE id='$session.user_id'}}
			$response:location[^untaint{$form:back}]
		}
	}
}
################################################################################
# Задаем новый пароль для пользователя
@User_New_Pass[hParams]
^if(def $hParams.password && $hParams.user_id){
	^connect[$site:connectString]{^void:sql{UPDATE $self.accountsTable.name SET password='^math:md5[$hParams.password]' WHERE id='$hParams.user_id'}}
}
################################################################################
@allFields[]
$result[^table::load[/classes/auth/registration.table]]
################################################################################
@GetFields[params]
^try{
	^if(!def $params){$params[^hash::create[]]}
	^if(!def $params.order){$params.order[sort_id]}
	^if(!def $params.orderType){$params.orderType[ASC]}
	^if(!def $params.offsetCount){$params.offsetCount(0)}
	^if(!def $params.limitCount){$params.limitCount(-1)}
	^if(!def $params.count){$params.count(false)}
	^if($params.count){
		$sql[
			$.fields[COUNT(*)]
			$.order[]
		]
	}{
		$sql[
			$.fields[*]
			$.order[ORDER BY $params.order $params.orderType]
		]
	}
	$sql[
		SELECT $sql.fields
		FROM $self.cats_list_table.name
		WHERE 1=1
					^if(def $params.IDs){ AND id IN ($params.IDs)}
					^if(def $params.type){ AND type=$params.type}
					^if(def $params.main){ AND main=$params.main}
		$sql.order
	]
	^if($params.count){
		$result(^int:sql{$sql})
	}{
		$result[^table::sql{$sql}[$.limit($params.limitCount) $.offset($params.offsetCount)]]
	}
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[Во время выполнения произошла ошибка]
		$.exception[$exception]
	]
}
################################################################################