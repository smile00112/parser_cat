################################################################################
@CLASS
block_delete
################################################################################
@init[idblock]
$self.idblock[$idblock]
################################################################################
@deleteall[]
^connect[$site:connectString]{
	^use[news_cms.p;$.replace(true)]
	^news_cms:DeleteBlock[$self.idblock]
}
################################################################################