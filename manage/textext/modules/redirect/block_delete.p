################################################################################
@CLASS
block_delete
################################################################################
@init[idte]
$id_te[$idte]
################################################################################
@deleteall[]
^MAIN:dbconnect[^void:sql{DELETE FROM text_ext WHERE id='$id_te'}]
################################################################################