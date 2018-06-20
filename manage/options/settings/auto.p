################################################################################
@auto[]
^connect[$site:connectString]{
	^cms.SetCurrentModule[settings]
}
################################################################################
@module_info[]
^use[./module_info.p]
$result[^module_information[]]
################################################################################
# создание настроек
@create_new_settings[]
$info_fields[^get_add_info_fields[]]
$info_values[^get_add_info[site_settings;10]]
^void:sql{INSERT INTO site_settings (named, name, value, type_field, $info_fields) VALUES ('301 редирект','redirect_301','1',2,$info_values)}
################################################################################
@GetRadio[name;value]
^switch[$name]{
 ^case[redirect_301]{
  www.${cms.domain}:<input type="radio" name="value" value="1" ^if($value eq 1){checked}>
  ${cms.domain}:<input type="radio" name="value" value="0" ^if($value eq 0){checked}>
 }
 ^case[DEFAULT]{
  Да:<input type="radio" name="value" value="1" ^if($value eq 1){checked}>
  Нет:<input type="radio" name="value" value="0" ^if($value eq 0){checked}>
 }
}
################################################################################
@GetSelect[name;value;style]
^switch[$name]{
 ^case[template_name]{$values[^file:list[$site:templatesFolder]]}
 ^case[DEFAULT]{$values[]}
}
^if(def $values){
 <select name="value" style="$style">
  ^values.menu{
  <option ^if($values.name eq $value){selected} value="$values.name">$values.name</option>
  }
 </select>
}
################################################################################