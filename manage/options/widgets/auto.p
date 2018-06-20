################################################################################
@auto[]
^use[widgets.p]
^connect[$site:connectString]{
	$this[^widgets::create[]]
	^cms.SetCurrentModule[$this.className]
}
################################################################################