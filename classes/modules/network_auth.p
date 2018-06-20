################################################################################
@CLASS
network_auth
################################################################################
@BASE
user
################################################################################
@module_info[]
# Сервис: ulogin (https://ulogin.ru/)
$module_info[
 $.version[2.0]
 $.build_date[24.10.2012]
 $.developer[Баранов Вадим Сергеевич]
 $.module_name[network_auth]
 $.module_description[Авторизация из соц. сетей]
 $.whats_new[
  <p align="justify">
   <ol>
    <li>Полностью переработан механизм авторизации.</li>
    <li>Появилась возможность привязывать аккаунт к существующей учётной записи.</li>
    <li>Инициализация учётной записи данными из соц. сети, включая аватарку.</li>
   </ol>
  </p>
 ]
]
$result[$module_info]
################################################################################	
@auto[]
$self.hideLinkAccount(1)
################################################################################
@create[]
# Инициализируем пароль для нового пользователя из соц. сети
$self.socialPassword[djqnbgjlcjwbfkmysvfrrfeynjvctqxfc]
# Строка с параметрами, которые Мы получаем из соц. сети. (Нужное раскомментировать)
$self.fields[first_name,last_name,email,nickname,bdate,sex,phone,photo,photo_big,city,country]
# $fields[first_name,last_name,email,nickname]
# Строка с иконками соц. сетей
$self.providers[facebook]
#$self.providers[vkontakte,odnoklassniki,mailru]
# Строка со скрытыми иконками соц. сетей
$self.hidden[]
#$self.hidden[other]
# Текущее время
$self.now[^date::now[]]
# Инициализируем объект класса auth
$self.auth[^auth::create[]]
# Таблицы
$self.socialAccounts[
 $.table[social_accounts]
 $.file[accounts.table]
]
$self.socialInfo[
 $.table[social_user_info]
 $.file[user_info.table]
]
# Папки
$self.socialFolder[/network_auth]
$self.mysqlTablesPath[/tables/mysql]
# ${self.classesPath}${self.socialFolder}${self.mysqlTablesPath}/${self.socialInfoFile}
################################################################################
# Вывод формы авторизации
@ShowAuthForm[show_script]
^if(!def $show_script){<script src="//ulogin.ru/js/ulogin.js"></script>}
<div id="uLogin" data-ulogin="display=panel;fields=$self.fields;providers=$self.providers;hidden=$self.hidden;redirect_uri=http%3A%2F%2F$env:SERVER_NAME"></div>
################################################################################
@check_user[token;page_id;uri]
# Загружаем информацию о пользователе
 ^try{$file[^file::load[text;http://ulogin.ru/token.php?token=$token&host=$env:SERVER_NAME]]}{$exception.handled(1)}
# Преобразуем JSON-строку в хеш
 $user[^json:parse[^taint[as-is][$file.text]]]    
# Если скрипт не выдал ошибку 
 ^if(!def $user.error){
#  Имя пользователя:     $user.first_name<br> 
#  Фамилия пользователя: $user.last_name<br>
#  Соц. сеть:            $user.network<br>
#  Профиль пользователя: $user.identity<br>
#  E-mail:               $user.email<br>
#  Логин:                $user.nickname<br>
#  Дата рождения:        $user.bdate<br>
#  Пол:                  ^if($user.sex eq 1){Женский}{Мужской}<br>
#  Телефон:              $user.phone<br>
#  Аватарка:             $user.photo<br>
#  Аватарка (большая):   $user.photo_big<br>
#  Город:                $user.city<br>
#  Страна:               $user.country<br>
# Проверяем, есть ли такой пользователь в нашей БД
  $cms_user[^table::sql{SELECT * FROM $self.socialAccounts.table WHERE network='$user.network' and identity='$user.identity'}]
# Если такой пользователь в нашей БД есть
  ^if(def $cms_user){ 
# Если пользователь привязан к аккаунту
   ^if($cms_user.user_id>0){
# Авторизуемся под этим аккаунтом
    $res[^self.auth.Demon[$cms_user.user_id;$self.auth.session.id]]
# Переходим на текущую страницу
    $response:refresh[$.value(0)$.url[$uri]]
# Если пользователь не привязан к аккаунту  
   }{
# Переходим на страницу выбора действия с аккаунтом
    $response:refresh[$.value(0)$.url[${user:mainFolder}${self.socialFolder}/?id=$cms_user.id&resp=^uri.base64[]]]
   }
# Если такого пользователя в нашей БД нет 
  }{
# Добавляем запись с id пользователя равным 0 
   $res[^void:sql{INSERT INTO $self.socialAccounts.table VALUES ('', 0, '$user.network', '$user.identity', '^self.now.sql-string[]', '^self.now.sql-string[]')}]
# Получаем id связи пользователя и аккаунта 
   $id[^int:sql{SELECT id FROM $self.socialAccounts.table WHERE network='$user.network' and identity='$user.identity'}]
# Разбиваем строку с датой рождения на части с разделителем .  
   $parts[^user.bdate.split[.;lh]]
# Получаем год рождения   
   $year[$parts.2]
# Получаем месяц рождения   
   $month[$parts.1]
# Получаем день рождения   
   $day[$parts.0]
# Получаем дату рождения в нужном формате  
   $bdate[${year}-${month}-${day}] 
# Инициализируем переменную $user_info_values данными о пользователе
   $user_info_values['$user.first_name','$user.last_name','$user.network','$user.identity','$user.email','$user.nickname','$bdate',$user.sex,'$user.phone','$user.photo','$user.photo_big','$user.city','$user.country']    
# Сохраняем информацию об этом пользователе в таблицу social_user_info      
   $res[^void:sql{INSERT INTO $self.socialInfo.table VALUES ('', $id, $user_info_values, '^self.now.sql-string[]', '^self.now.sql-string[]')}]
# Переходим на страницу выбора действия с аккаунтом
   $response:refresh[$.value(0)$.url[${user:mainFolder}${self.socialFolder}/?id=$id]]
  }                  
# Если скрипт выдал ошибку  
 }{                  
# Переходим на страницу вывода ошибки авторизации
  $response:refresh[$.value(0)$.url[${user:mainFolder}${self.socialFolder}/error.html]]
 }
################################################################################
@UpdateSocialUser[user_id;id]
$result[^void:sql{UPDATE $self.socialAccounts.table SET user_id='$user_id', modify_date='^self.now.sql-string[]' where id='$id'}]
################################################################################
@ShowBindingForm[]
^self.ShowTemplate[${site:templateFolder}${user:mainFolder}/bindingForm.html]
################################################################################
@GetSocialUserInfo[id]
$result[^table::sql{SELECT * FROM $self.socialInfo.table WHERE account_id='$id'}]
################################################################################
@GetNewUserLogin[login;begin;cnt]
^if(^self.auth.checkUserByLogin[$login] eq 0){
 $result[$login]
}{
 ^if(!def $begin){$begin[$login]}
 ^if(!def $cnt){$counter(1)}{$counter(^eval($cnt+1))}
 $newLogin[${begin}_$counter]
 $result[^self.GetNewUserLogin[$newLogin;$begin;$counter]]
}
################################################################################
@ConvertRegUserField[reg_fields;user_info]
$result[
^reg_fields.menu{
 ^switch[$reg_fields.name]{
  ^case[fio]{$.fio[$user_info.last_name $user_info.first_name]}
  ^case[skype]{^if($user_info.network eq 'skype'){$.skype[$user_info.identity]}}
  ^case[facebook]{^if($user_info.network eq 'facebook'){$.facebook[$user_info.identity]}}
  ^case[vkontakte]{^if($user_info.network eq 'vkontakte'){$.vkontakte[$user_info.identity]}}
  ^case[odnoklassniki]{^if($user_info.network eq 'odnoklassniki'){$.odnoklassniki[$user_info.identity]}}
  ^case[mailru]{^if($user_info.network eq 'mailru'){$.mailru[$user_info.identity]}}
  ^case[twitter]{^if($user_info.network eq 'twitter'){$.twitter[$user_info.identity]}}
  ^case[phone]{$.phone[$user_info.phone]}
  ^case[live]{$.live[$user_info.city, $user_info.country]}
  ^case[bdate]{$.bdate[$user_info.bdate]}
  ^case[DEFAULT]{}
 }
}
]
################################################################################
@BindUserBySocialNetwork[id;login;password]
$flag(1)
# Авторизуемся под этим аккаунтом
$answer[^self.auth.LogIn[$login;$password]]
# Если такой пользователь есть
^if($answer eq login){
 $flag(0)
# Записываем его данные в таблицу связей
 ^self.UpdateSocialUser[$self.auth.session.user_id;$id]
}
$result[$flag]
################################################################################
@NewUserBySocialNetwork[id]
# Получаем информацию о пользователе
$user_info[^self.GetSocialUserInfo[$id]]
# Если информация о пользователе есть
^if(def $user_info){
# Инициализируем логин для нового пользователя
 $username[^self.GetNewUserLogin[$user_info.nickname]]
# Получаем поля для регистрации
 $reg_fields[^self.auth.allFields[]]
# Инициализируем необходимые переменные информацией о пользователе
 $values[^self.ConvertRegUserField[$reg_fields;$user_info]]
################################################################################
# Формируем строку с полями для вставки
 $new_sql_fields[username, fio, u_password_md5, user_email, user_regdate]
# Формируем строку со значениями полей для вставки
 $new_sql_values['$username', '$user_info.last_name $user_info.first_name','^math:md5[$self.socialPassword]', '$user_info.email', '^self.now.unix-timestamp[]']
# Доформировываем эти строки
 ^reg_fields.menu{
  ^if(($reg_fields.project eq network || $reg_fields.project eq main) && ($reg_fields.troub ne y) && ($reg_fields.event eq all || $reg_fields.event eq new)){
   $new_sql_fields[$new_sql_fields, $reg_fields.sqlField]
   $new_sql_values[$new_sql_values, '$values.[$reg_fields.name]']
  }
 }
# Создаём запись о пользователе в таблице пользователей
 $tmp[^void:sql{INSERT INTO $user:usersTable.name ($new_sql_fields) values ($new_sql_values)}]
# Авторизуемся под этим аккаунтом
 $res[^self.auth.LogIn[$username;$self.socialPassword]]
# Получаем id нового пользователя
 $new_user_id(^int:sql{SELECT user_id FROM $user:usersTable.name WHERE username='$username'})
# Привязываем пользователя к новому аккаунту
 $tmp[^self.UpdateSocialUser[$new_user_id;$id]]
#-------------------------------------------------------------------------------
# Если соц. сеть вернула путь на аватарку
 ^if((def $user_info.photo_big) && ($user_info.network eq 'vkontakte' || $user_info.network eq 'odnoklassniki' || $user_info.network eq 'mailru')){
 $self.GetAvatarFromURL[$user_info.photo_big]
 }
}
################################################################################