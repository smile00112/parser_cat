################################################################################
@auto[]
^use[catalog.p]
^connect[$site:connectString]{
	$blockId(^if(def $form:idblock){$form:idblock}{$form:id})
	$catalog[^catalog::create[$blockId]]
	^cms.SetCurrentModule[$catalog.className;true]
}
################################################################################