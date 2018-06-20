################################################################################
@auto[]
^use[feedback.p]
^connect[$site:connectString]{
	$this[^feedback::create[]]
	^cms.SetCurrentModule[$this.className]
}
################################################################################