################################################################################
@auto[]
^connect[$site:connectString]{
	^cms.SetCurrentModule[redirects]
}
################################################################################
@module_info[]
^use[./module_info.p]
$result[^module_information[]]
################################################################################
@add_link[section_name;add_phrase]
<table border="0">
	<tr>
		<td>
			<a href="add_${section_name}.html"><strong>Добавить $add_phrase</strong></a>
		</td>
		<td>
			&nbsp^;&nbsp^;&nbsp^;
		</td>
		<td>
			<a href="update_htaccess.html"><strong>Сохранить изменения</strong></a>
		</td>
	</tr>
</table>
################################################################################
@get_link_id_query[table_fields;table_name;order]
^if(^table_fields.locate[type;link_id]){
 $link_id_name[$table_fields.name]
 $link_id_table[^get_table_by_nikname[$table_fields.table]] 
 ^table_fields.offset(-1)
 $counter(0)
 ^table_fields.menu{
  ^counter.inc[]
  ^if($counter eq 1){
   $string_table_fields[${table_name}.$table_fields.name]
  }{
   $string_table_fields[$string_table_fields, ${table_name}.$table_fields.name]
  }
 }
 $order_field[^order.trim[right;_id]] 
 $string_table_fields[$string_table_fields, ${table_name}.sortir, ${link_id_table}.$order_field]
} 
^if($link_id_name eq $order){    
 $result[SELECT $string_table_fields FROM $table_name JOIN $link_id_table ON ${table_name}.$order=${link_id_table}.id ORDER BY $order_field $form:order_type]
}{
 $result[SELECT * FROM $table_name ORDER BY $order $form:order_type]
}
################################################################################
@get_table_count[table;file;folder]
^try{ 
# Пробуем получить количество строк таблицы
 $result(^int:sql{select count(*) from $table})
}{
# Обработали ошибку
 $exception.handled(1)
# Загружаем поля таблицы $table   
 $mysql_table[^table::load[${folder}tables/mysql/${file}]]
# Создаём таблицу $table
 ^create_sql_table[$table;$mysql_table;;$folder]
# Получили результат 
 $result(0)
} 
################################################################################
# Выводит поля таблицы для заполнения
@show_fields[fields;table]
$date_now[^date::now[]]
$month[
 $.0[нет]
 $.1[января]
 $.2[февраля]
 $.3[марта]
 $.4[апреля]
 $.5[мая]
 $.6[июня]
 $.7[июля]
 $.8[августа]
 $.9[сентября]
 $.10[октября]
 $.11[ноября]
 $.12[декабря]
]
^if(def $table){$values[^table::sql{select * from $table where id=$form:id}]}
^if(def $fields){
 ^fields.menu{
  ^if($fields.show eq yes){
   ^switch[$fields.type]{
# ---------------Тип поля text---------------
    ^case[text]{
     <tr>
      <td class="tH">
       $fields.label ^if($fields.main eq yes){<font color="red">*</font>}:
      </td>
      <td class="tN">
       ^if(def $table){$value[$values.[$fields.name]]}{$value[$form:[$fields.name]]}
       <input type="$fields.type" name="$fields.name" value="$value" style="width: $fields.width^;">       
      </td>
     </tr>
    }
# ---------------Тип поля bool---------------
    ^case[bool]{
     <tr>
      <td class="tH">
       $fields.label ^if($fields.main eq yes){<font color="red">*</font>}:
      </td>
      <td class="tN">
       ^if(def $table){$value[$values.[$fields.name]]}{$value[$form:[$fields.name]]}
       <input type="checkbox" name="$fields.name" style="align: left^;" ^if($value eq 1){checked}>            
      </td>
     </tr>
    }
# -------------Тип поля checkbox-------------
    ^case[checkbox]{
     <tr>
      <td class="tH">
       $fields.label ^if($fields.main eq yes){<font color="red">*</font>}:
      </td>
      <td class="tN" align="left">
       ^if(def $table){$value[$values.[$fields.name]]}{$value[$form:[$fields.name]]}
       <input type="$fields.type" name="$fields.name" ^if($value eq 1){checked}>            
      </td>
     </tr>
    }
# ---------------Тип поля memo---------------
    ^case[memo]{
     <tr>
      <td colspan="2" class="tH">
       $fields.label ^if($fields.main eq yes){<font color="red">*</font>}:
      </td>
     </tr>
     <tr> 
      <td colspan="2" class="tN">
       ^if(def $table){$value[$values.[$fields.name]]}{$value[$form:[$fields.name]]}
       <textarea name="$fields.name" rows="6" style="width: $fields.width^;">$value</textarea>
      </td>
     </tr> 
    }
# --------------Тип поля select--------------
    ^case[select]{
     <tr>
      <td class="tH">
       $fields.label <font color="red">*</font>:
      </td>
      <td class="tN">
#      Определяем список выводимых полей в названии
       $str[$fields.view_fields]
			 $parts[^str.split[,;lv;field]]
#      Поля сортировки таблицы	
       $order[]
       ^parts.menu{$order[^if(def $order){$order, $parts.field}{$parts.field}]}
#      Выводим выпадающий список из полей таблицы
       <table border="0" cellspacing="0" cellpadding="0">
        <tr>
         <td>
          $tbl[^table::sql{select * from ^get_table_by_nikname[$fields.table] order by $order}]
          <select name="$fields.name" size="1" class="myselect" style="width: $fields.width^;">
          ^if(def $tbl){
           ^tbl.menu{
#          Название записи таблицы в списке
           $name[]
           ^parts.menu{$name[^if(def $name){$name }$tbl.[$parts.field]]}
           <option value="$tbl.id" ^if(def $table){^if($tbl.id == $values.[$fields.name]){selected}}>$name</option>
           }
          }{
           <option value="0">Нет записей</option>
          }
          </select>
         </td>
         <td>
          &nbsp^;
         </td>
         <td>
          <a href="^get_add_link[$fields.table]"><img src="/manage/$cms.currentModuleName/images/add.png" width="20" height="20" alt="Добавить" title="Добавить"></a>
         </td>
        </tr>
       </table>
      </td>
     </tr> 
    }
# ---------------Тип поля date---------------
    ^case[date]{
     <tr>
      <td class="tH">
       $fields.label ^if($fields.main eq yes){<font color="red">*</font>}:
      </td>
      <td class="tN">
       ^if(def $table){
        ^if($values.[$fields.name] ne '0000-00-00'){
         $date[^date::create[$values.[$fields.name]]]
         $day_value[$date.day]
         $month_value[$date.month]
         $year_value[$date.year]
        }{
         $day_value[00]
         $month_value[00]
         $year_value[0000]
				}
       }{
        ^if(def $form:[${fields.name}_day]){$day_value[$form:[${fields.name}_day]]}{$day_value[$date_now.day]}
        ^if(def $form:[${fields.name}_month]){$month_value[$form:[${fields.name}_month]]}{$month_value[$date_now.month]}
        ^if(def $form:[${fields.name}_year]){$year_value[$form:[${fields.name}_year]]}{$year_value[$date_now.year]}
       }
       <select name="${fields.name}_day">
      	^for[days](0;31){
				<option value="^days.format[%02.2u]" ^if($day_value eq $days){selected}>$days</option>
      	}
		   </select>
		   <select name="${fields.name}_month">
		  	 ^for[months](0;12){
				<option value="^months.format[%02.2u]" ^if($month_value eq $months){selected}>$month.[$months]</option>
		  	 }
       </select>
		   <select name="${fields.name}_year">
		    <option value="0000" ^if($year_value eq '0000'){selected}>0000</option>
				^for[years](^eval($date_now.year-10);^eval($date_now.year)){
				<option value="^years.format[%04.4u]" ^if($year_value eq ^years.format[%04.4u]){selected}>$years</option>
      	}
		   </select>
      </td>
     </tr>
    }
# ----------------По умолчанию----------------
    ^case[DEFAULT]{}
   }
  }
 }
}
################################################################################
@get_order_type[order_type]
^if(def $order_type){
 ^if($order_type eq desc){$result[asc]}{$result[desc]}
}{
 $result[desc]
}
################################################################################
@show_order_link[order;order_type;label]
<table border="0" cellpadding="0" cellspacing="0">
 <tr>
  <td>
   <b><a href="?order=$order&order_type=$order_type">$label</a></b>
	</td>
	<td>
	 &nbsp^;
	</td>
	<td>
	 <a href="?order=$order&order_type=$order_type"><img src="./images/^if($order_type eq desc){down}{up}.png"></a>
	</td>
 </tr>
</table>
################################################################################
@get_search_query[table_fields;table_name;field;search]
$res[^table_fields.locate[name;$field]]
^if($table_fields.type eq link_id){
 $link_id_table[^get_table_by_nikname[$table_fields.table]] 
 $search_field[^field.trim[right;_id]] 
 $result[SELECT * FROM $table_name WHERE $field IN (SELECT id FROM $link_id_table WHERE $search_field LIKE '%$search%')]
}{
 $result[SELECT * FROM $table_name WHERE $field LIKE '%$search%']
}
################################################################################
@get_search_count[table_fields;table_name;field;search]
$res[^table_fields.locate[name;$field]]
^if($table_fields.type eq link_id){
 $link_id_table[^get_table_by_nikname[$table_fields.table]] 
 $search_field[^field.trim[right;_id]] 
 $result[^int:sql{SELECT COUNT(id) FROM $link_id_table WHERE $search_field LIKE '%$search%'}]
}{
 $result[^int:sql{SELECT COUNT(id) FROM $table_name WHERE $field LIKE '%$search%'}]
}
################################################################################
# Проверяем, заполнены ли обязательные поля
@check_fields[fields]
$result(1)
^fields.menu{
 ^if($fields.show_manage eq yes){
  ^if($fields.main eq yes){
   ^switch[$fields.type]{
    ^case[time]{^if(!def $form:[${fields.name}_hour] || !def $form:[${fields.name}_minute]){$result(0) $check_error[$check_error Не заполнено поле '$fields.label'<br>]}}
    ^case[date]{^if(!def $form:[${fields.name}_day] || !def $form:[${fields.name}_month] || !def $form:[${fields.name}_year]){$result(0) $check_error[$check_error Не заполнено поле '$fields.label'<br>]}}
    ^case[DEFAULT]{^if(!def $form:[$fields.name]){$result(0) $check_error[$check_error Не заполнено поле '$fields.label'<br>]}}
	 }
  }
 }
}
################################################################################
# Формирует список имён служебных полей таблицы $table при добавлении элемента
@get_add_info_fields[]
 $result[sortir, creation_date, create_user_login, modify_date, modify_user_login]
################################################################################
# Формирует список значений служебных полей таблицы $table при добавлении элемента
@get_add_info[table;sortir]
# Инициализируем переменную date_value текущей датой
 $date_now[^date::now[]]
 $date_value[${date_now.year}-${date_now.month}-$date_now.day $date_now.hour:$date_now.minute:$date_now.second]
# Определяем значение поля sortir
 ^if(!def $sortir){$sortir(^eval(^int:sql{select count(*) from $table}*10+10))}
# Выводим результат
 $result['$sortir', '$date_value', '$admins.login', '$date_value', '$admins.login']
################################################################################
# Формирует часть строки SQL запроса со служебной информацией для таблицы $table
@get_edit_info[table;edit;id;sortir]
^if(!def id){$id[$form:id]}
$tbl[^table::sql{select * from $table where id=$id}]
# Инициализируем переменную date_value текущей датой
 $date_now[^date::now[]]
 $date_value[${date_now.year}-${date_now.month}-$date_now.day $date_now.hour:$date_now.minute:$date_now.second]
# Инициализируем значение поля sortir
 ^if(!def $sortir){$sortir($tbl.sortir)}
# Инициализируем значение поля creation_date
 $creation_date[$tbl.creation_date]
# Инициализируем значение поля create_user_login
 $create_user_login[$tbl.create_user_login]
# Выводим результат
 sortir='$sortir',^if(!def $edit){ creation_date='$creation_date', create_user_login='$create_user_login',} modify_date='$date_value', modify_user_login='$admins.login'
################################################################################
@add_actions[name;description;id;show_edit_action;parameters]
$params[id=$id]
^if(def $parameters){$params[id=${id}&${parameters}]}
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  ^if($show_edit_action eq 1){
  <td align="center">
   <input type="image" src="./images/save.gif" style="cursor:pointer" title="Изменить">
   <br>
   Изменить
  </td>
  </form>
  <td>
   &nbsp^;&nbsp^;
  </td>
  }
  <td align="center">
   <input type="image" src="./images/edit.gif" style="cursor:pointer" title="Редактировать" onclick="window.location.href='edit_${name}.html?$params'">
   <br>
   Редактировать
  </td>
  <td>
   &nbsp^;&nbsp^;
  </td>
  <td align="center">
   <input type="image" src="./images/delete.gif" style="cursor:pointer" title="Удалить" onclick="if (confirm('Вы действительно хотите удалить $description?')){window.location.href='del_${name}.html?$params'}" >
   <br>
   Удалить
  </td>
 </tr>
</table>
################################################################################