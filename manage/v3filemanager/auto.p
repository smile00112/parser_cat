################################################################################
@auto[]
$request:charset[utf-8]
$response:charset[utf-8]
################################################################################
@cms_page_id[]
$cms_page_id[v3filemanager]
################################################################################
#uri_way[] - проверяет правильность пути
################################################################################
@uri_way[]
^if(def $form:drag&&def $form:pos&&def $form:cop_file){
$drag[$form:drag]
$cop_file[$form:cop_file]
$pos[$form:pos]
$folder[$form:folder]
$name_d[$form:name_d]
}
^if(def $form:type){
	^trim_url_name[]
	$uri_get[$url]
}{
	$uri_get[$form:url]
}
$uri_get[^uri_get.trim[both;/]]
^if(def $uri_get){
	^if(def $form:type){
		^trim_url_name[]
		$uri_get[$url]
	}{
		$uri_get[$form:url]
	}
}{
	$uri_get[/$bank_name/]
}

######################
#Разбитие на части uri
######################
$parts[^uri_get.split[/]]
$parts_w[^uri_get.split[/;1h]]
$summ(-1)
^parts.menu{
	^summ.inc[]
}
############################
#Разбитие на части bank_name
############################
$parts_bank[^bank_name.split[/]]
$parts_w_bank[^bank_name.split[/;1h]]
$summ_bank(0)
^parts_bank.menu{
	^summ_bank.inc[]
}

^if($summ_bank>$summ){
	<script>window.location.href='?url=/$bank_name/'</script>
}

^if($summ_bank==$summ){
	^if($uri_get eq $bank_name_slesh){
	}{
		<script>window.location.href='?url=/$bank_name/'</script>
	}
}{
#	Если в url нет такой папки то переходит в корень
#	back_var[]-в back хранится переменная uri чтобы перейти назад
#	$back_link-используется в функции back_link для ссылки

	^back_var[]
	$back_link[$back]
	$back_test[${parts_w.$summ2}]
	$slesh[/]
	^if($back eq $slesh){
	$exist_folder(1)
	}{
		$test_back[^file:list[$back]]
		^if($test_back){
			^test_back.menu{
				^if($back_test eq $test_back.name){
					^if(-f "$back/$test_back.name"){
					}{
						$exist_folder(1)
					}	
				}
			}
		}
	}
	^if(def $exist_folder){
	}{
		<script>window.location.href='?url=/$bank_name/'</script>
	}
}

#############################################################################################################
#file_exist[] - Проверка на существование ссылки
#############################################################################################################
@file_exist[]
^if(def $form:type){
	^trim_url_name[]
	$file_exist[^file:list[$url]]
	^if($file_exist){
		^file_exist.menu{
			^if($name eq $file_exist.name){
				$file_e(0)
			}	
		}
	}
}{
$file_e(0)
}
#если есть $file_e то значит есть файл если нет то переходим в корень
^if(def $file_e){
}{
<script>window.location.href='?url=/$bank_name/'</script>
}

#############################################################################################################
#trim_url_name - обрезает на url и name
#############################################################################################################
@trim_url_name[]
$uri[$form:url]
$uri[$uri/]

$slesh[/]
$parts[^uri.split[/]]
$parts_w[^uri.split[/;1h]]
$summ(-1)
^parts.menu{
	^summ.inc[]
	$url[$parts.piece]
}

$url[]
$summ2(0)
^while($summ!=$summ2){
	$url[${url}${parts_w.$summ2}/]
	^summ2.inc[]
}

^if(def $parts_w.$summ2){
	$name[$parts_w.$summ2]
}{
	$name[error]
}

#############################################################################################################
#back - кнопка назад
#############################################################################################################
@back[]
^back_var[]
<a href="$main_way?url=${back_link}&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder"><img src="picturies/back.png" width="23px" height="23px"></a>

#############################################################################################################
#back_main - кнопка назад в главном поле
#############################################################################################################
@back_main[]
^back_var[]
<a href="$main_way?url=${back_link}&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder"><img src="picturies/up.png"></a>

@back_main_text[]
^back_var[]
<a href="$main_way?url=${back_link}&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder" style="text-decoration:none;color:black;">[..]</a>


#############################################################################################################
#back_var - переменная back
#############################################################################################################
@back_var[]

$parts[^uri_get.split[/]]
$parts_w[^uri_get.split[/;1h]]
$summ(-1)
^parts.menu{
	^summ.inc[]
	$back[$parts.piece]
}

$back[]
$summ2(0)
^summ_bank.inc[]
^while($summ!=$summ2){
	^if($summ2<$summ_bank){
		^summ2.inc[]
	}{
		$back[${back}${parts_w.$summ2}/]
		^summ2.inc[]
	}
}
$back[${bank_name_slesh}${back}]

^if($back eq $slesh){
	$back[/$bank_name/]
}
^if($uri_get eq $bank_name_slesh){
	$back[/$bank_name/]
}

#################################
#@way[]-отображение путь к файлу
#################################
@way[]
<div class="back" id="way_name">
$link_way[<a href="$main_way?url=${bank_name_slesh}&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder" class="class">$bank_name/</a>]
$nothing[]
$way[^uri_get.replace[$rep_bank_name]]
$way_part[^uri_get.replace[$rep_bank_name]]
^if($way ne $nothing || $way_part ne $nothing){
$way[^way.split[/]]
$way_part[^way_part.split[/;1h]]
$counter(-1)
^way.menu{
	^counter.inc[]
	^switch[$way.piece]{
		^case[$nothing]{}
		^case[DEFAULT]{
			$way_way[]
			$counter2(0)
			$summer($counter+1)
			^while($summer!=$counter2){
				$way_way[${way_way}${way_part.$counter2}/]
				
				^counter2.inc[]
			}
			
			$link_way[$link_way<a href="$main_way?url=${bank_name_slesh}${way_way}&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder" class="class">$way.piece</a>/]
		}
	}
}
}

$link_way
</div>

#############################################################################################################
#var_plupload[] - переменные для загрузчика
#ext_filters-список расширений возможных
#spisok_file-список файлов
#spisok-полный список
#############################################################################################################
@var_plupload[]	
$ext_filters[]
^ext_table.menu{
	$ext_filters[${ext_filters}${ext_table.ext}|]	
}
$list[^file:list[$uri_get]]
$spisok[]
^list.sort{$list.name}
^list.menu{
#	Чтобы не видел t.t
	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
#		Проверка если файл или папка
		^if(-f "$uri_get/$list.name"){
		}{
			$spisok[${spisok}${list.name}|]	
		}
	}	
}


^list.sort{$list.name}
$spisok_file[]
^list.menu{

	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
		^if(-f "$uri_get/$list.name"){	
			^if(^name_file.match[-preview.+]){
			}{
				$spisok[${spisok}${list.name}|]
				$spisok_file[${spisok_file}${list.name}|]
			}
		}
		
	}	
}

#############################################################################################################
#toolbar_checkbox - отображение файлов и папок
#############################################################################################################
@toolbar_checkbox[]	
<td class="left_bg">&nbsp;</td>
<td width="10px"></td>
<td width="30px" class="toolbar_up" onClick='javascript:folderADD("$uri_get");'>^create_folder_up[]</td>
<td width="30px" class="toolbar_up" onClick='javascript:fileADD("$uri_get","$spisok_file","$ext_filters");'>^file_load_up[]</td>
<td width="30px" class="toolbar_up" onClick='javascript:location.reload();'>^file_refresh_up[]</td>
<td width="10px"><div style="border-left:1px solid rgb(200,200,200);">&nbsp;</div></td>
<td width="30px" class="toolbar_up" onClick='javascript:cut_file("$uri_get","$spisok");'>^file_cut_up[]</td>
<td width="30px" class="toolbar_up" onClick='javascript:copy_file("$uri_get","$spisok");'>^file_copy_up[]</td>
<td width="30px" class="toolbar_up">^file_paste_up[]</td>
<td width="10px"><div style="border-left:1px solid rgb(200,200,200);">&nbsp;</div></td>
<td width="30px" class="toolbar_up" onClick='javascript:rename("$uri_get","$spisok_file","$ext_filters","$spisok");'>^file_rename_up[]</td>
<td width="30px" class="toolbar_up" onClick='javascript:file_download("$uri_get","$spisok");'>^file_download_up[]</td>
<td width="10px"><div style="border-left:1px solid rgb(200,200,200);">&nbsp;</div></td>
<td width="30px" class="toolbar_up" onClick='javascript:if (confirm("Вы действительно хотите удалить выделенные элементы?")){ document.s.submit()}'>^file_delete_up[]</td>
<td></td>
<td class="switch_view">^switch_view[]</td>
<td class="right_bg">&nbsp;</td>

#############################################################################################################
#toolbar_icon- отображение файлов и папок
#############################################################################################################
@toolbar_icon[]	
<td class="left_bg">&nbsp;</td>
<td width="10px"></td>
<td width="120px" class="toolbar_up" onClick='javascript:folderADD("$uri_get");'>^create_folder_up[]<font color="white" size=2>Создать папку</font></td>
<td width="120px" class="toolbar_up" onClick='javascript:fileADD("$uri_get","$spisok_file","$ext_filters");'>^file_load_up[]<font color="white" size=2>Добавить файл</font></td>
<td width="140px" class="toolbar_up" onClick='javascript:location.reload();'>^file_refresh_up[]<font color="white" size=2>Обновить страницу</font></td>
<td></td>
<td class="switch_view">^switch_view[]</td>
<td class="right_bg">&nbsp;</td>

#############################################################################################################
#footer_status_checkbox- отображение файлов и папок
#############################################################################################################
@footer_status_checkbox[]	
<span class="one_file_size">0</span>Кб из <span class="summ_file_size">${summ_file_size}</span>Кб, 
Файлов <span class="count_file">0</span> из $id_number 


#############################################################################################################
#navigation_checkbox - отображение файлов и папок
#############################################################################################################
@navigation_checkbox[]	
$summ_file_size(0)
<div class="main">
<table class="navigation_table">
<tr class="zagolovok">
	<td class="checkbox_table_z" onClick='javascript:checkbox_all("$spisok");'>&nbsp;<input id="all_chek" type="checkbox"></td>
	<td class="img_table_z"></td>
	<td class="name_table_z">Имя файла</td>
	<td class="size_table_z"><center>Размер</center></td>
	<td class="date_table_z"><center>Дата</center></td>
</tr>
<tr class="zagolovok">
	<td class="checkbox_table">&nbsp;</td>
	<td class="img_table">^back_main[]</td>
	<td class="name_table">^back_main_text[]</td>
	<td class="size_table"></td>
	<td class="date_table"></td>
</tr>

$list[^file:list[$uri_get]]
^list.sort{$list.name}
^list.menu{
#	Чтобы не видел t.t
	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
#		Проверка если файл или папка
		^if(-f "$uri_get/$list.name"){
		}{
			^id_number.inc[]
			$url_way[${uri_get}${name_file}/]
			$name_file_n[^file:justname[$name_file]]
			^directory_checkbox[]
			
		}
	}	
}

^list.sort{$list.name}
$spisok_file[]
^list.menu{

	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
		^if(-f "$uri_get/$list.name"){
#			Проверка чтобы файл небыл превью		
			^if(^name_file.match[-preview.+]){
				
			}{
				^id_number.inc[]
				^file_checkbox[]
				$spisok_file[${spisok_file}${list.name}|]
			}
		}{

		}
	}	
}
</table>
</div>


@directory_checkbox[]
<tr id="$id_number" class="zagolovok">
	<td class="checkbox_table" onClick='javascript:click_checkbox("$id_number");'>&nbsp;<input id="${id_number}_chek" class="checkbox" type="checkbox"></td>
	<td class="img_table"  onClick="javascript:window.location.href='?url=$url_way&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder';" ><img src="picturies/folder_t.png"></td>
	<td class="name_table" onClick="javascript:window.location.href='?url=$url_way&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder';">$name_file</td>
	<td class="size_table" onClick="javascript:window.location.href='?url=$url_way&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder';" ></td>
	<td class="date_table" onClick="javascript:window.location.href='?url=$url_way&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder';" ></td>
</tr>


@file_checkbox[]
$part[^name_file.split[.;1h]]
$cnt(^part.count[])
$ext[$part.$cnt]
$preview[-preview.]
$dote[.]

#$ext-рарсширение
^ext_table.menu{
		^if($ext_table.ext eq $ext){
			$ext_tables_exist(1)
		}
	}
	
$uri_src[${uri_get}$name_file]
^switch[$ext]{
	^case[jpg]{^exist_preview[] $uri_min[picturies/extension_table/img.png] ^exif_img[]}
	^case[jpeg]{^exist_preview[] $uri_min[picturies/extension_table/img.png] ^exif_img[]}
	^case[png]{^exist_preview[] $uri_min[picturies/extension_table/img.png] ^exif_img[]}
	^case[gif]{^exist_preview[] $uri_min[picturies/extension_table/img.png] ^exif_img[]}
	^case[bmp]{^exist_preview[] $uri_min[picturies/extension_table/img.png]}
	^case[ico]{^exist_preview[] $uri_min[picturies/extension_table/img.png]}
	^case[icon]{^exist_preview[] $uri_min[picturies/extension_table/img.png]}
	^case[jpe]{^exist_preview[] $uri_min[picturies/extension_table/img.png] ^exif_img[]}
	^case[DEFAULT]{
		$img_w[] $img_h[]
		^if($ext_tables_exist){
			$uri[picturies/extension/${ext}.png]
			$uri_min[picturies/extension_table/${ext}.png]
		}{
			$uri[picturies/extension_table/file.png]
			$uri_min[picturies/extension_table/file.png]
		}
	}
}
$uri_src[${uri_get}$name_file]
$name_file_n[^file:justname[$name_file]]

$f[^file::stat[$uri_src]]


$size_file(^eval($f.size/1024)[%.0f])
$summ_file_size($summ_file_size+$size_file)
$day[${f.cdate.day}]
$month[${f.cdate.month}]
$hours[${f.cdate.hour}]
$menute[${f.cdate.minute}]

^if(^menute.length[]==1){
$menute[0${menute}]
}
^if(^day.length[]==1){
$day[0${day}]
}
^if(^month.length[]==1){
$month[0${month}]
}
^if(^hours.length[]==1){
$hours[0${hours}]
}
<tr id="$id_number" class="zagolovok">
	
	<td class="checkbox_table" >&nbsp;<input id="${id_number}_chek" onClick='javascript:click_checkbox("$id_number","$uri","$original","$img_w","$img_h","$ext");' class="checkbox" type="checkbox"></td>
	<td class="img_table"  onDblClick="javascript:insertURL('$uri_src');" onClick='javascript:click_tr("$id_number","$uri","$original","$img_w","$img_h","$ext");'><img src="$uri_min"></td>
	<td class="name_table" onDblClick="javascript:insertURL('$uri_src');" onClick='javascript:click_tr("$id_number","$uri","$original","$img_w","$img_h","$ext");'>$name_file</td>
	<td class="size_table" onDblClick="javascript:insertURL('$uri_src');" onClick='javascript:click_tr("$id_number","$uri","$original","$img_w","$img_h","$ext");'><center><span>$size_file</span> Кб</center></td>
	<td class="date_table" onDblClick="javascript:insertURL('$uri_src');" onClick='javascript:click_tr("$id_number","$uri","$original","$img_w","$img_h","$ext");'><center>${day}.${month}.${f.cdate.year} ${hours}:$menute</center></td>
</tr>

#####################################
#Переменные ширины и высоты картинки
@exif_img[]
#$img_file[^file::stat[$uri_src]]
#$img_f[^image::measure[$uri_src]]
#$img_w[$img_f.width] 
#$img_h[$img_f.height]


#############################################################################################################
#navigation - отображение файлов и папок
#############################################################################################################
@navigation[]	
<div class="main">
$list[^file:list[$uri_get]]
^list.sort{$list.name}
^list.menu{
#	Чтобы не видел t.t
	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
#		Проверка если файл или папка
		^if(-f "$uri_get/$list.name"){
		}{
			^id_number.inc[]
			$url_way[${uri_get}${name_file}/]
			$name_file_n[^file:justname[$name_file]]
			$str_id[$id_number]

			^directory_show[]

			
		}
	}	
}

^list.sort{$list.name}
$spisok_file[]
^list.menu{

	$exception[t.t]
	$name_file[$list.name]
	^if($list.name eq $exception){
	}{
		^if(-f "$uri_get/$list.name"){
#			Проверка чтобы файл небыл превью		
			^if(^name_file.match[-preview.+]){
				
			}{
				^file_show[]
				$spisok_file[${spisok_file}${list.name}|]
			}
		}{

		}
	}	
}

</div>
	

###################################
#@directory_show[]-Показывает папки
###################################
@directory_show[]
#^id_number.inc[]
$url_way[${uri_get}${name_file}/]
$name_file_n[^file:justname[$name_file]]
$str_id[$id_number]
<div id="$id_number" class="left" onDblClick="javascript:window.location.href='?url=$url_way&name_d=$name_d&drag=$drag&pos=$pos&cop_file=$cop_file&folder=$folder';">
<div class="file_context_menu_folder" id="$id_number">
	<a id="$name_file_n" class="tit" title="$name_file">
		<div class="picture">
			<img class="img_size" src="picturies/extension/folder.png">
		</div>
		<div class="name">
			<font id="font_${id_number}"><nobr>^name_file.mid(0;11)<font color="#2F4F4F">^name_file.mid(11;1)</font><font color="#696969">^name_file.mid(12;1)</font><font color="#808080">^name_file.mid(13;1)</font><font color="#A9A9A9">^name_file.mid(14;1)</font><font color="#DCDCDC">^name_file.mid(15;500)</font></nobr></font>
		</div>
	</a>
</div>
</div>








##########################################
#@file_show[]-показать файлы			
##########################################
@file_show[]
$part[^name_file.split[.;1h]]
$cnt(^part.count[])
$ext[$part.$cnt]
$preview[-preview.]
$dote[.]

#$ext-рарсширение

^id_number.inc[]
^ext_table.menu{
		^if($ext_table.ext eq $ext){
			$ext_tables_exist(1)
		}
	}
	
$uri_src[${uri_get}$name_file]
^switch[$ext]{
	^case[jpg]{^exist_preview[]}
	^case[jpeg]{^exist_preview[]}
	^case[png]{^exist_preview[]}
	^case[gif]{^exist_preview[]}
	^case[bmp]{^exist_preview[]}
	^case[ico]{^exist_preview[]}
	^case[icon]{^exist_preview[]}
	^case[jpe]{^exist_preview[]}
	^case[DEFAULT]{
		^if($ext_tables_exist){
			$uri[picturies/extension/${ext}.png]
		}{
			$uri[picturies/extension/file.png]
		}
	}
}
$uri_src[${uri_get}$name_file]
$name_file_n[^file:justname[$name_file]]

<div id="$id_number" class="left" onDblClick="javascript:insertURL('$uri_src');">
<div class="file_context_menu" id="$id_number">
	<a id="$name_file_n" class="tit" title="$name_file">
		<div class="picture">
			<img id="$original" class="img_size" src="^uri.js-escape[]">
		</div>
		<div class="name">
			<div style="height:14px;border-bottom:solid grey 2px;">
				<font id="font_${id_number}"><nobr>^name_file.mid(0;11)<font color="#2F4F4F">^name_file.mid(11;1)</font><font color="#696969">^name_file.mid(12;1)</font><font color="#808080">^name_file.mid(13;1)</font><font color="#A9A9A9">^name_file.mid(14;1)</font><font color="#DCDCDC">^name_file.mid(15;500)</font></nobr></font>
			</div>
			
			$f[^file::stat[$uri_src]]
			$size_file(^eval($f.size/1024)[%.0f])
			<div style="text-align:left;padding-top:2px;">
			<font style="text-align:left;width:105px;color:grey;">
				<nobr>${f.cdate.day}.${f.cdate.month}.${f.cdate.year} ${f.cdate.hour}:${f.cdate.minute}</nobr><br>
				<nobr>$size_file Кб</nobr>
			</font>
			</div>
			
		</div>
	</a>
</div>
</div>

#############################################################
#exist_preview[]-Если превью нет то src картинки берется от оригинала			
#############################################################
@exist_preview[]
$pv_name[^file:justname[$name_file]]
$pv_name[${pv_name}${preview}${ext}]
$pv[^file:list[$uri_get]]
^pv.menu{
	$exist_pv(0)
	$original[]
	^if($pv_name eq $pv.name){
		$exist_pv(1)
	}{
	}
	^if($exist_pv==1){
		$uri[${uri_get}${pv_name}]
		^break[]
	}{	
		$uri[${uri_get}${name_file}]
		$original[original]
	}
}



######################################
#create_folder_up- панель управления
######################################
@create_folder_up[]
<img title="Создать папку" src="picturies/folder_plus.png">
#<font color="white" size="2">Создать папку</font>

######################################
#file_load_up- панель управления
######################################
@file_load_up[]
<img title="Добавить файл" src="picturies/file_load.png">
#<font color="white" size="2">Добавить файл</font>

######################################
#file_refresh_up- панель управления
######################################
@file_refresh_up[]
<img title="Обновить страницу" src="picturies/refresh.png">

######################################
#file_cut_up- панель управления
######################################
@file_cut_up[]
<img title="Вырезать" src="picturies/cut.png">

######################################
#file_copy_up- панель управления
######################################
@file_copy_up[]
<img title="Копировать" src="picturies/copy.png">

######################################
#file_paste_up- панель управления
######################################
@file_paste_up[]
^if(def $cut_cookie || def $copy_cookie){
	$opacity[1]
}{
	$opacity[0.6]
}
<img id="picturies_paste" style="opacity:$opacity;" title="Вставить" src="picturies/paste.png" onClick='javascript:paste_file("$uri_get","$cut_cookie","$copy_cookie","$paste_cookie","$spisok");'>

######################################
#file_rename_up- панель управления
######################################
@file_rename_up[]
<img id="picturies_rename" style="opacity:0.7;" title="Переименовать файл" src="picturies/rename.png">

######################################
#file_download_up- панель управления
######################################
@file_download_up[]
<img style="opacity:0.7;" id="picturies_load" title="Скачать файл" src="picturies/load.png">

######################################
#file_delete_up- панель управления
######################################
@file_delete_up[]
&nbsp;
<img title="Удалить" src="picturies/delete.png">
#<font color="white" size="2">Удалить</font>

######################################
#switch_view- панель управления
######################################
@switch_view[]
<font color="white" size="2">Переключить вид</font>
#<img src="picturies/list.png">
#<img src="picturies/img.png">




######################################
#delete_footer- панель управления cdth[e
######################################
@delete_footer[]
<div class="delete" id="delete_basket">
<div class="picture">
	<img id="basket" class="img_size" src="picturies/delete-clear.png">
</div>
<font>&nbsp;&nbsp;&nbsp;Корзина</font>
</div>

	


######################################
#Toolbar- панель управления справа
######################################
@toolbar_show[]
#Добавление папки
<div class="toolbar" id="dr_add" onClick='javascript:folderADD("$uri_get");'>
	<a>
		<div class="picture">
			<img class="img_size" src="picturies/add_folder.png">
		</div>
		<div class="name">
			<font>Создать папку</font>
		</div>
	</a>
</div>


$ext_filters[]
^ext_table.menu{
	$ext_filters[${ext_filters}${ext_table.ext}|]	
}		
#Добавление файла
<div class="toolbar" id="fl_add" onClick='javascript:fileADD("$uri_get","$spisok_file","$ext_filters");' >
	<a>
		<div class="picture">
			<img class="img_size" src="picturies/add_file.png">
		</div>
		<div class="name">
			<font>Добавить файл</font>
		</div>
	</a>
</div>
		
#корзина
<div class="delete" id="delete_basket">
	<a>
		<div class="picture">
			<img id="basket" class="img_size" src="picturies/delete-clear.png">
		</div>
		<div class="name">
			<font>Корзина</font>
		</div>
	</a>
</div>	

##################################
#@delete_drop[]-Форма для удаления
##################################
@delete_drop[]								
<div style='position:absolute;background:#cccccc;height:110;width:300;top:30%;left:30%;z-index:400;display:none;' id='deletedrop'>
</div>

#####################################################################
#name_replace[name_replace]-функция стирает все запрещенные символы
#$name_rep-результат функции
#####################################################################
@name_replace[name_replace]
$counter(0)
$dote[.]
$replace_symbol[^table::create{from	to}]
$replace_test[^table::create{from	to}]
	$drName_length(^name_replace.length[])
	^while($counter!=$drName_length){
		$symbol[^name_replace.mid($counter;1)]
		^switch[$symbol]{
			^case[a]{}
			^case[b]{}
			^case[c]{}
			^case[d]{}
			^case[e]{}
			^case[f]{}
			^case[g]{}
			^case[h]{}
			^case[i]{}
			^case[j]{}
			^case[k]{}
			^case[l]{}
			^case[m]{}
			^case[n]{}
			^case[o]{}
			^case[p]{}
			^case[q]{}
			^case[r]{}
			^case[s]{}
			^case[t]{}
			^case[u]{}
			^case[v]{}
			^case[w]{}
			^case[x]{}
			^case[y]{}
			^case[z]{}
			^case[0]{}
			^case[1]{}
			^case[2]{}
			^case[3]{}
			^case[4]{}
			^case[5]{}
			^case[6]{}
			^case[7]{}
			^case[8]{}
			^case[9]{}
			^case[-]{}
			^case[_]{}
			
#Если такого символа нет то добавляем в таблицу и стираем этот символ
#replace_test-нужен для того чтобы проверять есть ли папки с непрвильным именем

			^case[DEFAULT]{$err_symbol[$symbol]
							^replace_symbol.append{$err_symbol	}	
							^if($err_symbol eq $dote){
							}{
							^replace_test.append{$err_symbol	&}
							}
			}
		}
		^counter.inc[]
	}
$name_rep[^name_replace.replace[$replace_symbol]]
$name_test[^name_replace.replace[$replace_test]]

#############################################################################################################
#test[] - проверка на зарпрещенные имена в папках или файлах
#############################################################################################################
@test[]
$way[/$bank_name/]
$table_way[^table::create{cnt	name	way}]
$summ(0)
^table_way.append{$summ	$name	$way}
$exit(1)
^deleter[]

#Удаление Внутри папки и папки
@deleter[][$table_way]
$exception[t.t]
$t(0)
^while($exit!=-1){
	$tables[^table_way.select($table_way.cnt==$summ)]
	^if($tables){
		^summ.inc[]
		^tables.menu{
			$back_way[$tables.way]
#				Поиск в $tables.way<br>	
			$list[^file:list[$tables.way]]
			^if($list){
			}{
				$t(-1)
			}
			^list.menu{
				^ext[$list.name]		
				^if(-f "${tables.way}${name_file}"){
						^name_replace[$name_file]
						$name_file_rep[$name_test]
						
						$name_file_rep(^name_file_rep.pos[&])
						^if($name_file_rep!=-1){
							Неправильное имя в папке $tables.way - $name_file<br>
						}
					}{
					$way[${tables.way}${name_file}/]
						^name_replace[$name_file]
						$name_file_rep[$name_test]
						
						$name_file_rep(^name_file_rep.pos[&])
						^if($name_file_rep!=-1){
							Неправильное имя в папке $tables.way - $name_file<br>
						}
					^table_way.append{$summ	$name_file	$way}
					}	
			}
		}
	}{
		$exit(-1)
	}
}

##################################
#Разрешение файла
@ext[name]
$name_file[$name]
$ext[^file:justext[$name_file]]
$preview[-preview.]
$name_f[^file:justname[$name_file]]
$preview_name[${name_f}${preview}${ext}]
#$ext-рарсширение
#$name_f-имя файла
#$name_file-имя файла с расширением
#$preview_name-имя превью


