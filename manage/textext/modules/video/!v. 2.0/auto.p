################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		^use[video_cms.p;$.replace(true)]
		$this[^video_cms::create[$idblock]]
		^cms.SetCurrentModule[$this.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################