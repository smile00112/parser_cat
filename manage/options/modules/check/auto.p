################################################################################
@auto[]
^if(def $cms.cmsUser){
# а»б±аЛаИ аПаАбЂаАаМаЕбІбЂб‚ аПаЕбЂаЕаДаАбѓбІб±бЅ
	^if(def $form:module_name && $cms.cmsUserLevel==$cms.maxUserLevel){
		^connect[$site:connectString]{
			^try{
				^use[${form:module_name}_cms.p;$.replace(true)]
				^process{^$this[^^${form:module_name}_cms::create[]]}
				^cms.SetCurrentModule[$this.className]
			}{
				$exception.handled(true)
				$classNotFound(true)
			}
		}
	}{
		$response:refresh[
			$.value(0)
			$.url[../]
		]
	}
}{
	$response:refresh[
		$.value(0)
		$.url[${cms.cmsFolder}/]
	]
}
################################################################################