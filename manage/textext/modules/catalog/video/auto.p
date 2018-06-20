################################################################################
@auto[]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$video[^video_cms::create[$idblock]]
}
################################################################################