################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		^cms.SetCurrentModule[structure]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################
@del_rewrite_slash[stext]
$nachpos(0)
$kon_pos(^stext.length[])
^if(^stext.left(1) eq "/" || ^stext.left(1) eq "\"){
 $nachpos(1)
 $kon_pos($kon_pos-1)
}
^if(^stext.right(1) eq "/" || ^stext.right(1) eq "\"){
 $kon_pos($kon_pos-1)
}
$result[^stext.mid($nachpos;$kon_pos)]
################################################################################
@show_table_header[]
	<div>
					<div class="form-left">
						<span class="str-name">
							Название
						</span>
					</div><!--
					--><div class="form-right" style="width: ${div_width}px^;">
						<span class="str-id">ID</span><!--
						--><span class="str-parent">
							Роди- тель
						</span><!--
						--><span class="str-porydok">
							Поря- док
						</span><!--
						--><span class="str-link">
							Внешняя ссылка
						</span><!--
						--><span class="str-general">
							Глав- ная
						</span><!--
						--><span class="str-visible">
							Види- мость
						</span><!--
						^if(def $security){--><span class="str-closed">Зак- рытый</span><!--}
						^if($lev==10){--><span class="str-level">Уро- вень</span><!--}	
						--><span class="str-deystv">
							Действия
						</span>
					</div>
	</div>
################################################################################
@show_fixed_table_header[]
<div id="fixHead">
	<div>
		<div>
			<div>
			 ^show_table_header[]
			</div>
		</div>
	</div>
</div>
################################################################################
@module_info[]
^use[./module_info.p]
$result[^module_information[]]
################################################################################
# удаление из строки instr всех символов перечисленных в del_array_chars
# ^str_delete_chars[Мария, ивановна;, ]
@str_delete_chars[instr;del_array_chars]
$temp[]

^for[i](0;^instr.length[]){
	$char[^instr.mid($i;1)]

	^if(^del_array_chars.pos[$char]==-1){
		$temp[${temp}${char}]
	}
}
$result[$temp]
################################################################################
@insert_error_fields[text]
<br>
<form name="redirect">
<center>
 ^if(!def $text){
 <font face="Arial"><b>ВНИМАНИЕ!!! Заполнены не все поля<br><br>
 <font face="Arial"><b>Вы вернетесь на предыдущую  страницу через<br><br>
 }{
 <font face="Arial">$text</font>
 }
 <form>
 <input type="text" size="3" name="redirect2">
 </form>
 секунд</b></font>
</center>

<script>
var countdownfrom=5
var currentsecond=document.redirect.redirect2.value=countdownfrom+1
function countredirect(){
 if (currentsecond!=1){
  currentsecond-=1
  document.redirect.redirect2.value=currentsecond
 }
 else{
  history.back(1)
  return
 }
setTimeout("countredirect()",1000)
}
countredirect()
</script>
################################################################################