################################################################################
@CLASS
block_delete
################################################################################
@init[idte]
$id_te[$idte]
################################################################################
@deleteall[]
^connect[$site:connectString]{
	$images[^table::sql{select * from te_gallery where id_te='$id_te'}]
	^images.menu{
		^file:delete[$prefpath/block/gallery/big/${images.id}.${images.ext};$.exception(false)]
		^file:delete[$prefpath/block/gallery/small/${images.id}.${images.ext};$.exception(false)]
		^file:delete[$prefpath/block/gallery/src/${images.id}.${images.ext};$.exception(false)]
	}
	^void:sql{delete from te_gallery where id_te='$id_te'}
	^void:sql{delete from te_opt where id_te='$id_te'}
	^void:sql{delete from text_ext where id='$id_te'}
}
################################################################################