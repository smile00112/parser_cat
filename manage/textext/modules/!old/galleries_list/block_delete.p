################################################################################
@CLASS
block_delete
################################################################################
@init[idte]
$id_te[$idte]
################################################################################
@deleteall[]
^MAIN:dbconnect[^void:sql{delete from text_ext where id='$id_te'}]
################################################################################