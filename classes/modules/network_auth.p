################################################################################
@CLASS
network_auth
################################################################################
@BASE
user
################################################################################
@module_info[]
# ������: ulogin (https://ulogin.ru/)
$module_info[
 $.version[2.0]
 $.build_date[24.10.2012]
 $.developer[������� ����� ���������]
 $.module_name[network_auth]
 $.module_description[����������� �� ���. �����]
 $.whats_new[
  <p align="justify">
   <ol>
    <li>��������� ����������� �������� �����������.</li>
    <li>��������� ����������� ����������� ������� � ������������ ������� ������.</li>
    <li>������������� ������� ������ ������� �� ���. ����, ������� ��������.</li>
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
# �������������� ������ ��� ������ ������������ �� ���. ����
$self.socialPassword[djqnbgjlcjwbfkmysvfrrfeynjvctqxfc]
# ������ � �����������, ������� �� �������� �� ���. ����. (������ �����������������)
$self.fields[first_name,last_name,email,nickname,bdate,sex,phone,photo,photo_big,city,country]
# $fields[first_name,last_name,email,nickname]
# ������ � �������� ���. �����
$self.providers[facebook]
#$self.providers[vkontakte,odnoklassniki,mailru]
# ������ �� �������� �������� ���. �����
$self.hidden[]
#$self.hidden[other]
# ������� �����
$self.now[^date::now[]]
# �������������� ������ ������ auth
$self.auth[^auth::create[]]
# �������
$self.socialAccounts[
 $.table[social_accounts]
 $.file[accounts.table]
]
$self.socialInfo[
 $.table[social_user_info]
 $.file[user_info.table]
]
# �����
$self.socialFolder[/network_auth]
$self.mysqlTablesPath[/tables/mysql]
# ${self.classesPath}${self.socialFolder}${self.mysqlTablesPath}/${self.socialInfoFile}
################################################################################
# ����� ����� �����������
@ShowAuthForm[show_script]
^if(!def $show_script){<script src="//ulogin.ru/js/ulogin.js"></script>}
<div id="uLogin" data-ulogin="display=panel;fields=$self.fields;providers=$self.providers;hidden=$self.hidden;redirect_uri=http%3A%2F%2F$env:SERVER_NAME"></div>
################################################################################
@check_user[token;page_id;uri]
# ��������� ���������� � ������������
 ^try{$file[^file::load[text;http://ulogin.ru/token.php?token=$token&host=$env:SERVER_NAME]]}{$exception.handled(1)}
# ����������� JSON-������ � ���
 $user[^json:parse[^taint[as-is][$file.text]]]    
# ���� ������ �� ����� ������ 
 ^if(!def $user.error){
#  ��� ������������:     $user.first_name<br> 
#  ������� ������������: $user.last_name<br>
#  ���. ����:            $user.network<br>
#  ������� ������������: $user.identity<br>
#  E-mail:               $user.email<br>
#  �����:                $user.nickname<br>
#  ���� ��������:        $user.bdate<br>
#  ���:                  ^if($user.sex eq 1){�������}{�������}<br>
#  �������:              $user.phone<br>
#  ��������:             $user.photo<br>
#  �������� (�������):   $user.photo_big<br>
#  �����:                $user.city<br>
#  ������:               $user.country<br>
# ���������, ���� �� ����� ������������ � ����� ��
  $cms_user[^table::sql{SELECT * FROM $self.socialAccounts.table WHERE network='$user.network' and identity='$user.identity'}]
# ���� ����� ������������ � ����� �� ����
  ^if(def $cms_user){ 
# ���� ������������ �������� � ��������
   ^if($cms_user.user_id>0){
# ������������ ��� ���� ���������
    $res[^self.auth.Demon[$cms_user.user_id;$self.auth.session.id]]
# ��������� �� ������� ��������
    $response:refresh[$.value(0)$.url[$uri]]
# ���� ������������ �� �������� � ��������  
   }{
# ��������� �� �������� ������ �������� � ���������
    $response:refresh[$.value(0)$.url[${user:mainFolder}${self.socialFolder}/?id=$cms_user.id&resp=^uri.base64[]]]
   }
# ���� ������ ������������ � ����� �� ��� 
  }{
# ��������� ������ � id ������������ ������ 0 
   $res[^void:sql{INSERT INTO $self.socialAccounts.table VALUES ('', 0, '$user.network', '$user.identity', '^self.now.sql-string[]', '^self.now.sql-string[]')}]
# �������� id ����� ������������ � �������� 
   $id[^int:sql{SELECT id FROM $self.socialAccounts.table WHERE network='$user.network' and identity='$user.identity'}]
# ��������� ������ � ����� �������� �� ����� � ������������ .  
   $parts[^user.bdate.split[.;lh]]
# �������� ��� ��������   
   $year[$parts.2]
# �������� ����� ��������   
   $month[$parts.1]
# �������� ���� ��������   
   $day[$parts.0]
# �������� ���� �������� � ������ �������  
   $bdate[${year}-${month}-${day}] 
# �������������� ���������� $user_info_values ������� � ������������
   $user_info_values['$user.first_name','$user.last_name','$user.network','$user.identity','$user.email','$user.nickname','$bdate',$user.sex,'$user.phone','$user.photo','$user.photo_big','$user.city','$user.country']    
# ��������� ���������� �� ���� ������������ � ������� social_user_info      
   $res[^void:sql{INSERT INTO $self.socialInfo.table VALUES ('', $id, $user_info_values, '^self.now.sql-string[]', '^self.now.sql-string[]')}]
# ��������� �� �������� ������ �������� � ���������
   $response:refresh[$.value(0)$.url[${user:mainFolder}${self.socialFolder}/?id=$id]]
  }                  
# ���� ������ ����� ������  
 }{                  
# ��������� �� �������� ������ ������ �����������
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
# ������������ ��� ���� ���������
$answer[^self.auth.LogIn[$login;$password]]
# ���� ����� ������������ ����
^if($answer eq login){
 $flag(0)
# ���������� ��� ������ � ������� ������
 ^self.UpdateSocialUser[$self.auth.session.user_id;$id]
}
$result[$flag]
################################################################################
@NewUserBySocialNetwork[id]
# �������� ���������� � ������������
$user_info[^self.GetSocialUserInfo[$id]]
# ���� ���������� � ������������ ����
^if(def $user_info){
# �������������� ����� ��� ������ ������������
 $username[^self.GetNewUserLogin[$user_info.nickname]]
# �������� ���� ��� �����������
 $reg_fields[^self.auth.allFields[]]
# �������������� ����������� ���������� ����������� � ������������
 $values[^self.ConvertRegUserField[$reg_fields;$user_info]]
################################################################################
# ��������� ������ � ������ ��� �������
 $new_sql_fields[username, fio, u_password_md5, user_email, user_regdate]
# ��������� ������ �� ���������� ����� ��� �������
 $new_sql_values['$username', '$user_info.last_name $user_info.first_name','^math:md5[$self.socialPassword]', '$user_info.email', '^self.now.unix-timestamp[]']
# ��������������� ��� ������
 ^reg_fields.menu{
  ^if(($reg_fields.project eq network || $reg_fields.project eq main) && ($reg_fields.troub ne y) && ($reg_fields.event eq all || $reg_fields.event eq new)){
   $new_sql_fields[$new_sql_fields, $reg_fields.sqlField]
   $new_sql_values[$new_sql_values, '$values.[$reg_fields.name]']
  }
 }
# ������ ������ � ������������ � ������� �������������
 $tmp[^void:sql{INSERT INTO $user:usersTable.name ($new_sql_fields) values ($new_sql_values)}]
# ������������ ��� ���� ���������
 $res[^self.auth.LogIn[$username;$self.socialPassword]]
# �������� id ������ ������������
 $new_user_id(^int:sql{SELECT user_id FROM $user:usersTable.name WHERE username='$username'})
# ����������� ������������ � ������ ��������
 $tmp[^self.UpdateSocialUser[$new_user_id;$id]]
#-------------------------------------------------------------------------------
# ���� ���. ���� ������� ���� �� ��������
 ^if((def $user_info.photo_big) && ($user_info.network eq 'vkontakte' || $user_info.network eq 'odnoklassniki' || $user_info.network eq 'mailru')){
 $self.GetAvatarFromURL[$user_info.photo_big]
 }
}
################################################################################