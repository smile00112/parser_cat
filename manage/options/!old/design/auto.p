################################################################################
@auto[]
^if(def $cms.cmsUser){
	^connect[$site:connectString]{
		^use[design_cms.p]
		$this[^design_cms::create[]]
		^cms.SetCurrentModule[$this.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################