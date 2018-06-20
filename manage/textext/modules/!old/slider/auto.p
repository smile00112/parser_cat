################################################################################
@module_info[]
$module_info[
    $.version[2.0]
    $.build_date[24.11.2012]
    $.developer[Баранов Вадим Сергеевич]
    $.module_name[slideshow]
    $.module_description[Слайдер]
]
################################################################################
@check_options[]
$table_opt[^int:sql{select count(*) from te_opt where id_te='$form:id'}[$.default{0}]]
^if($table_opt==0){
	^create_new_options[]
	}	
################################################################################
# создание настроек
@create_new_options[]
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Имя эффекта смены слайдов','effect_name','scrollDown',2)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Скорость смены слайдов (мс)','speed',1000,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Время показа одного слайда (мс)','timeout',2000,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Описание слайдшоу','descript','',0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выводить описание фото','view_name_foto',0,1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Оформление','','',10)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Выравнивание','align','center',3)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Отображать тень','show_shadow',0,1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Отображать рамку','show_border',0,1)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина рамки','border_width',1,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Тип рамки','border_type','solid',5)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Цвет рамки','border_color','#000000',4)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Изображение','','',10)}         
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина','width',640,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота','height',999,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Превью','','',10)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Колво колонок','countcol',2,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Ширина превью','preview_width',250,0)}
^void:sql{insert into te_opt (id_te, named, name, value, type_field) values ('$form:id','Высота превью','preview_height',999,0)}
################################################################################
# Загружает таблицу из файла $path
@load_table_from_file[path]
$result[^table::load[$path]]
################################################################################
# Создаёт SQL таблицу с именем $table_name и полями $fields 
@create_sql_table[table_name;fields]
^if(def $fields){
 ^fields.menu{
  $string[$string $fields.field]
 }
# Дополнительные служебные поля
 $info_fields[^load_table_from_file[table/mysql/info.table]]
 ^info_fields.menu{
  $inform[$inform $info_fields.field]
 }
# Создание таблицы
 ^void:sql{CREATE TABLE IF NOT EXISTS $table_name ($string $inform) DEFAULT CHARSET=cp1251}
}
################################################################################
# Формирует часть строки SQL запроса со служебной информацией для таблицы $table
@get_add_info[]
# Инициализируем переменную date_value текущей датой
 $date_now[^date::now[]]
 $date_value[${date_now.year}-${date_now.month}-$date_now.day $date_now.hour:$date_now.minute:$date_now.second]
# Выводим результат
 '$date_value', '$admins.login', '$date_value', '$admins.login'
################################################################################
# Формирует часть строки SQL запроса со служебной информацией для таблицы $table
@get_edit_info[table]
$tbl[^table::sql{select * from $table where id=$form:id}]
# Инициализируем переменную date_value текущей датой
 $date_now[^date::now[]]
 $date_value[${date_now.year}-${date_now.month}-$date_now.day $date_now.hour:$date_now.minute:$date_now.second]
# Инициализируем значение поля sortir
 $sortir($tbl.sortir)
# Инициализируем значение поля creation_date
 $creation_date[$tbl.creation_date]
# Инициализируем значение поля create_user_login
 $create_user_login[$tbl.create_user_login]
# Выводим результат
 sortir='$sortir', creation_date='$creation_date', create_user_login='$create_user_login', modify_date='$date_value', modify_user_login='$admins.login'
################################################################################
@show_preview[table_opt]
<script type="text/javascript" src="/lib/slideshow/jquery.cycle.all.js"></script>
<script type="text/javascript" src="/lib/slideshow/jquery.easing.1.3.js"></script>
<style type="text/css">
.slide-block
{
 width:              100%^;
 text-align:         ^if(^table_opt.locate[name;align]){$table_opt.value}^;
}
.slide-block > div 
{
 width:              ^if(^table_opt.locate[name;preview_width]){$table_opt.value}px !important^;
 display:            inline-block^;  
} 
.slide-block img 
{
 width:              ^if(^table_opt.locate[name;preview_width]){$table_opt.value}px !important^;
 ^if(^table_opt.locate[name;show_border]){
  ^if($table_opt.value==1){
 border:             1px solid #000^;
 border-width:       ^if(^table_opt.locate[name;border_width]){$table_opt.value}px^;
 border-style:       ^if(^table_opt.locate[name;border_type]){$table_opt.value}^;
 border-color:       ^if(^table_opt.locate[name;border_color]){$table_opt.value}^;
  }{
 border:             none^;
  }
 }
 ^if(^table_opt.locate[name;show_shadow]){
  ^if($table_opt.value==1){
 box-shadow:         /*горизонтальное смещение тени*/0 /*вертикальное смещение*/2px /*размытие тени*/4px /*размер тени*/0 /*цвет тени*/#4F4F4F^;
 -moz-box-shadow:    0px 2px 4px 0px #4F4F4F^;
 -webkit-box-shadow: 0px 2px 4px 0px #4F4F4F^;
  }{
 box-shadow:         none^;
 -moz-box-shadow:    none^;
 -webkit-box-shadow: none^;
	}
 }
}
</style>		  		   
<div class="slide-block">		 
 <div> 
  $res[^table_opt.locate[name;descript]]
  ^if(def $table_opt.value){<p align="center">Описание слайдшоу</p>}
  $res[^table_opt.locate[name;view_name_foto]]  
  <div id="slideshow"> 
   <div> 
    <img src="example/example_1.jpg" alt="Пример 1" title="Пример 1" border="0" hspace="0" />
    ^if($table_opt.value eq 1){<p align="center">Пример 1</p>}
   </div>     
   <div> 
    <img src="example/example_2.jpg" alt="Пример 2" title="Пример 2" border="0" hspace="0" />	
	  ^if($table_opt.value eq 1){<p align="center">Пример 2</p>}		  
   </div>
  </div>
 </div>
</div>
<script type="text/javascript">
^$(document).ready(function() {
^$('#slideshow').cycle({ 
	fx:      '^if(^table_opt.locate[name;effect_name]){$table_opt.value}', 
	speed:   ^if(^table_opt.locate[name;speed]){$table_opt.value}, 
	timeout: ^if(^table_opt.locate[name;timeout]){$table_opt.value}
})^;
})^;
</script>
################################################################################
@get_effect_list[]
$result[^table::create{name	description
scrollDown	Сверху вниз
blindX	Смена по горизонтали
blindY	Смена по вертикали
blindZ	Смена по диагонали
scrollUp	Снизу вверх
cover	Покрывание
curtainX	Сворачивание по горизонтали
curtainY	Сворачивание по вертикали
scrollLeft	Скролл влево
scrollRight	Скролл вправо
scrollHorz	Скролл по горизонтали
scrollVert	Скролл по вертикали
fade	Затенение
fadeZoom	Затенение с появлением
growX	Увеличение по горизонтали
growY	Увеличение по вертикали
shuffle	Перемешать
slideX	Листание по горизонтали
slideY	Листание по вертикали
toss	Улетучивание
turnUp	Поворот куба вверх
turnDown	Поворот куба вниз
turnLeft	Поворот куба влево
turnRight	Поворот куба вправо
uncover	Сдвиг
wipe	Появление по диагонали
zoom	Увеличение}] 
################################################################################
@get_align_list[] 
$result[^table::create{name	description
left	По левому краю
center	По центру
right	По правому краю}]	    
################################################################################
@get_border_type_list[] 
$result[^table::create{name	description
solid	Линия
dotted	Точки
dashed	Тире}]  
################################################################################