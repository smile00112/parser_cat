################################################################################
@auto[]
^connect[$site:connectString]{
	$textext[^textext::create[]]
	$fields[
		$.name[$textext.className]
		$.path[$textext.className]
		$.caption[$textext.classModuleDescription]
	]
	^cms.SetCurrentModule[$textext.className;$fields]
}
################################################################################