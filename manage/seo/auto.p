################################################################################
@auto[]
^connect[$site:connectString]{
	^cms.SetCurrentModule[seo]
}
################################################################################
@module_info[]
^use[./module_info.p]
$result[^module_information[]]
################################################################################