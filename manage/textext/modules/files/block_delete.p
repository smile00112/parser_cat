################################################################################
@CLASS
block_delete
################################################################################
@init[idte]
$id_te[$idte]
################################################################################
@deleteall[]
$files[^files:GetFilesByBlockId[$id_te]]
^files.menu{
 $path[$files:filesPath/$files.block_id/${files.name}.${files.ext}]
 ^if(-f $path){$res[^file:delete[$path]]}
}	
$res[^files:DeleteByBlockId[$id_te]]
$res[^void:sql{DELETE FROM text_ext WHERE id='$id_te'}]
################################################################################