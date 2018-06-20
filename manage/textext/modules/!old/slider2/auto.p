################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		$slider[^slider::create[$idblock]]
		^cms.SetCurrentModule[$slider.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################