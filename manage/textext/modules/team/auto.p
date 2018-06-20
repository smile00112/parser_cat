################################################################################
@auto[]
^if(def $cms.cmsUser){
	^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
	^connect[$site:connectString]{
		^use[team.p;$.replace(true)]
		$team[^team::create[$idblock]]
		^cms.SetCurrentModule[$team.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################