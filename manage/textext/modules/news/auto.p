################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		^use[news_cms.p;$.replace(true)]
		$this[^news_cms::create[$idblock]]
		^cms.SetCurrentModule[$this.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################
@ShowModalHeader[header]
^if(!def $header){$header[header.html]}
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		^site:ShowTemplate[${cms.templateFolder}/${header}]
	</head>
	<body style="padding: 10px^; background-color: #E0EDF8^;">
################################################################################
@ShowModalFooter[]
	</body>
</html>
################################################################################
@ShowStickerSelect[stickers;sticker_id]
<select name="sticker_id" class="cms_select" onChange="^$(this).Save()^;">
	<option value="0">Не выбран</option>
	^if(def $stickers){
		^stickers.menu{
	<option value="$stickers.id"^if($stickers.id == $sticker_id){ selected}>$stickers.name</option>
		}
	}
</select>
################################################################################
@ShowTypeSelect[types;type_id]
<select name="type_id" class="cms_select" onChange="^$(this).Save()^;">
	<option value="0">Не выбран</option>
	^if(def $types){
		^types.menu{
	<option value="$types.id"^if($types.id == $type_id){ selected}>$types.name</option>
		}
	}
</select>
################################################################################
@ShowAuthorSelect[authors;author_id]
<select name="author_id" class="cms_select" onChange="^$(this).Save()^;">
	<option value="0">Администратор</option>
	^if(def $authors){
		^authors.menu{
	<option value="$authors.id"^if($authors.id == $author_id){ selected}>$authors.name</option>
		}
	}
</select>
################################################################################