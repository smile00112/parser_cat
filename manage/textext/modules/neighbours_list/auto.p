################################################################################
@auto[]
^connect[$site:connectString]{
	$this[^neighbours_list::create[]]
	^cms.SetCurrentModule[$this.className]
}
################################################################################