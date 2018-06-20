################################################################################
@auto[]
^if(def $cms.cmsUser){
	^use[contacts.p]
	$this[^contacts::create[]]
	^connect[$site:connectString]{
		^cms.SetCurrentModule[$this.className]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################