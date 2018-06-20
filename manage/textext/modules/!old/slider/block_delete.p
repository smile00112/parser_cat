@CLASS
block_delete
###############################################################
@init[idte]
$id_te[$idte]
###############################################################
@deleteall[]
^try{
	^MAIN:dbconnect[$images[^table::sql{select * from te_slideshow where id_te='$id_te'}]]
	^images.menu{
		^deletefile[$prefpath/block/slider/big/${images.id}.${images.ext}]
		^deletefile[$prefpath/block/slider/normal/${images.id}.${images.ext}]
		^deletefile[$prefpath/block/slider/small/${images.id}.${images.ext}]
	}
}{
	$exception.handled(true)
}

^MAIN:dbconnect[
	^try{^void:sql{delete from te_slideshow where id_te='$id_te'}}{$exception.handled(true)}
	^void:sql{delete from te_opt where id_te='$id_te'}
	^void:sql{delete from text_ext where id='$id_te'}
]