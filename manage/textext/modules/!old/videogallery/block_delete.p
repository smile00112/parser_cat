################################################################################
@CLASS
block_delete
################################################################################
@init[idte]
$id_te[$idte]
################################################################################
@deleteall[]
^MAIN:dbconnect[$images[^table::sql{select * from te_gallery where id_te='$id_te'}]]
 ^MAIN:dbconnect[
  ^void:sql{delete from te_gallery where id_te='$id_te'}
  ^void:sql{delete from te_opt where id_te='$id_te'}
  ^void:sql{delete from text_ext where id='$id_te'}
 ]
################################################################################