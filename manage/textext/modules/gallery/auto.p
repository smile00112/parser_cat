################################################################################
@auto[]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$this[^gallery_cms::create[$idblock]]
	^cms.SetCurrentModule[$this.className]
}
################################################################################