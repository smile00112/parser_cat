################################################################################
@auto[]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	$video[^video_cms::create[$idblock]]
}
################################################################################
@showYoutubeVideo[prew]
<div data="$prew">
	<img width="$video.width" height="$video.height" src="http://img.youtube.com/vi/$prew/0.jpg">
</div>
<script type="text/javascript">
	^$('div[data]').click(function(){
		var test = ^$(this).attr('data')^;
		^$(this).addClass('playing')^;
		^$(this).html('<iframe width="$video.width" height="$video.height" src="//www.youtube.com/embed/'+test+'?rel=0&autoplay=1" frameborder="0" allowfullscreen></iframe>')^;
	})^;
</script>
################################################################################
@showFacebookVideo[prew]
<iframe src="https://www.facebook.com/plugins/video.php?href=${prew}" width="$video.width.small" height="$video.height.small" scrolling="no" frameborder="0" allowTransparency="true" allowFullScreen="true"></iframe>
################################################################################