################################################################################
@auto[]
^connect[$site:connectString]{
	$this[^registration_data_cms::create[]]
	^cms.SetCurrentModule[registration-data]
}
################################################################################