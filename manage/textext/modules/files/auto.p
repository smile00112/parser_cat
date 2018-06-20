################################################################################
@auto[]
$this[^files::create[]]
################################################################################
@cms_page_id[]
$cms_page_id[textext/modules/files]
################################################################################
@show_label[label;field;order;o_type]
^if($field eq $order){
 $order_type[^get_order_type[$o_type]]
 ^show_order_link[$field;$order_type;$label]
}{
 $request_query[^prepare_query[]]
 <a href="?^if(^request_query.length[]>0){$request_query}order=$field&order_type=$order_type">$label</a>
}
################################################################################
@prepare_query[]
$request_query[$request:query]
$pos(^request_query.pos[order=])
^if($pos>-1){
 $request_query[^request_query.left($pos)]
}{
 $length(^request_query.length[])
 ^if($length>0){
  ^if(^request_query.right($length) ne '&'){$request_query[$request_query&]}
 }
}
$result[$request_query]
################################################################################
@add_actions[name;description;id;show_edit_action;parameters]
$params[id=$id]
^if(def $parameters){$params[id=${id}&${parameters}]}
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  ^if($show_edit_action eq 1){
  <td align="center">
   <input type="image" src="/manage/i/actions/save.gif" style="cursor:pointer" title="Изменить">
   <br>
   Изменить
  </td>
  </form>
  <td>
   &nbsp^;&nbsp^;
  </td>
  }
  <td align="center">
	 <a href="edit_${name}.html?$params" title="Редактировать">Редактировать</a>
  </td>
  <td>
   &nbsp^;&nbsp^;
  </td>
  <td align="center">
		<a href="del_${name}.html?$params" title="Удалить">Удалить</a>
  </td>
 </tr>
</table>
################################################################################