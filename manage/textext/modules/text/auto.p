################################################################################
@auto[]
^use[text.p]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$text[^text::create[$idblock]]
	^cms.SetCurrentModule[$text.className]
}
################################################################################