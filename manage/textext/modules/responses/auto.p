################################################################################
@auto[]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$responses[^responses::create[$idblock]]
	^cms.SetCurrentModule[$responses.className]
}
################################################################################