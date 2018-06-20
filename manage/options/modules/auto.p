################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		$this[^modules::create[]]
		^cms.SetCurrentModule[$this.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################