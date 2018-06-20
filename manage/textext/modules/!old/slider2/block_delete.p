@CLASS
block_delete
###############################################################
@init[idte]
$id_te[$idte]
###############################################################
@deleteall[]
^MAIN:dbconnect[$images[^table::sql{select * from slider where block_id='$id_te'}]]
^images.menu{
	^deletefile[/images/block/slider/big/${images.id}.${images.ext}]
	^deletefile[/images/block/slider/small/${images.id}.${images.ext}]
	^deletefile[/images/block/slider/src/${images.id}.${images.ext}]
}
^MAIN:dbconnect[
	^void:sql{delete from slider where block_id='$id_te'}
	^void:sql{delete from te_opt where id_te='$id_te'}
	^void:sql{delete from text_ext where id='$id_te'}
]