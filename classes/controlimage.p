# CREATE TABLE `control_image` (                             
#                 `id` int(11) NOT NULL auto_increment,                    
#                 `vopros` int(10) unsigned default NULL,                  
#                 `otvet` int(10) unsigned default NULL,                   
#                 PRIMARY KEY  (`id`)                                      
#               )
#


##############################
# Версия 1.1 от 20080605
# класс предназначен для вставки и проверки контрольных цифр
#
@CLASS
controlimage

@install[]
^void:sql{
CREATE TABLE control_image (                             
                 id int(11) NOT NULL auto_increment,                    
                 vopros int(10) unsigned default NULL,                  
                 otvet int(10) unsigned default NULL,                   
                 PRIMARY KEY  (id)                                      
               )
}
##############################
# вставка в форму поля для уникальности формы
# чтобы не отправлять форму по два раза
@insert_controlform[]
$idc64[^math:uid64[]]
^MAIN:dbconnect{
	^void:sql{insert into control_image (vopros, otvet) values ('$idc64', '$idc64')}
	$maxid[^int:sql{select max(id) from control_image}]
	^void:sql{delete from control_image where id<'^eval($maxid-100)'}
}
$result[<input name="control_form" type="hidden" value="$idc64">]

@proverka_controlform[]
^MAIN:dbconnect{
	^if(^int:sql{select count(*) from control_image where vopros='$form:control_form'}>0){
		$result[true]
	}{
		$result[]
	}
	^void:sql{delete from control_image where vopros='$form:control_form'}
}


##############################
# вставка в форму поля ввода контрольных цифр 
# вставляет картинку цифр и поле maxid (который нужен для проверки введенного значения)
# bgcolor - цвет заднего фона у цифр
# cifr не сделано	- количество цифр 
@insert_controlimage[bgcolor;w;h;cifr]


$counters[^eval(^math:random(8999)+1000)]

^MAIN:dbconnect{
	^void:sql{insert into control_image (vopros, otvet) values ('$counters', '$counters')}
	$maxid[^int:sql{select max(id) from control_image}]
	^void:sql{delete from control_image where id<'^eval($maxid-100)'}
}
^if(def $w){$nw[$w]}{$nw[80]}
^if(def $h){$nh[$h]}{$nh[35]}

<input name="maxid" type="hidden" value="$maxid"> 
<img src="/classes/counter.html?bgcolor=$bgcolor&c=$maxid&w=$nw&h=$nh" />

 	
	
############################## 
# проверка контрольных цифр 
# usercode	код введенный пользователем
# maxid - код записанный в форме
@proverka_controlimage[usercode;maxid]
# возвращает result

^MAIN:dbconnect{$scontrol[^int:sql{select otvet from control_image where id='$maxid'}[$.default[-1000]]]}
^if(def $usercode && $usercode==$scontrol){
$result[true]
^MAIN:dbconnect{^void:sql{delete from control_image where id='$maxid'}}
}{
$result[]
}