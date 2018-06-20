################################################################################
@conf[filespec][confdir;charsetsdir;sqldriversdir]
$confdir[^file:dirname[$filespec]]
$charsetsdir[$confdir/charsets]
$sqldriversdir[$confdir/lib]
$CHARSETS[
	$.koi8-r[$charsetsdir/koi8-r.cfg]
	$.windows-1250[$charsetsdir/windows-1250.cfg]
	$.windows-1251[$charsetsdir/windows-1251.cfg]
	$.windows-1257[$charsetsdir/windows-1257.cfg]
]
#change your client libraries paths to those on your system
$SQL[
	$.drivers[^table::create{protocol	driver	client
	
mysql	$sqldriversdir/parser3mysql.dll	$sqldriversdir/libmySQL.dll
}]
]

#for ^file::load[name;user-name] mime-type autodetection
$MIME-TYPES[^table::create{ext	mime-type
zip	application/zip
doc	application/msword
xls	application/vnd.ms-excel
pdf	application/pdf
ppt	application/powerpoint
rtf	application/rtf
gif	image/gif
jpg	image/jpeg
png	image/png
tif	image/tiff
html	text/html
htm	text/html
txt	text/plain
mts	application/metastream
mid	audio/midi
midi	audio/midi
mp3	audio/mpeg
ram	audio/x-pn-realaudio
rpm	audio/x-pn-realaudio-plugin
ra	audio/x-realaudio
wav	audio/x-wav
au	audio/basic
mpg	video/mpeg
avi	video/x-msvideo
mov	video/quicktime
swf	application/x-shockwave-flash
}]

$LIMITS[
	$.post_max_size(10*0x400*0x400)
]
################################################################################
@fatal_error[title;subtitle;body]
$response:status(500)
$response:content-type[
	$.value[text/html]
	$.charset[$response:charset]
]
<html>
	<head>
		<title>$title</title>
	</head>
	<body>
		<h1>^if(def $subtitle){$subtitle;$title}</h1>
		$body
#		for [x] MSIE friendly
		^for[i](0;512/8){<!-- -->}
	</body>
</html>
################################################################################
@unhandled_exception_debug[exception;stack]
^fatal_error[Unhandled Exception^if(def $exception.type){ ($exception.type)};$exception.source;
<pre>^untaint[html]{$exception.comment}</pre>
^if(def $exception.file){
^untaint[html]{<tt>$exception.file^(${exception.lineno}:$exception.colno^)</tt>}
}
^if($stack){
	<hr/>
	<table>
	^stack.menu{
		<tr><td>$stack.name</td><td><tt>$stack.file^(${stack.lineno}:$stack.colno^)</tt></td></tr>
	}
	</table>
}
]
################################################################################
@unhandled_exception_release[exception;stack]
^fatal_error[Unhandled Exception;;
<p>The server encountered an unhandled exception 
and was unable to complete your request.</p>
<p>Please contact the server administrator, $env:SERVER_ADMIN
and inform them of the time the error occurred, 
and anything you might have done that may have caused the error.</p>
<p>More information about this error may be available in the Parser error log
or in debug version of unhandled_exception.</p>
]
################################################################################
@unhandled_exception[exception;stack]
#use debug version to see problem details
^unhandled_exception_release[$exception;$stack]
#^unhandled_exception_debug[$exception;$stack]
################################################################################
@auto[]
#source/client charsets
#$request:charset[utf-8]
#$response:charset[utf-8]
$response:content-type[
	$.value[text/html]
	$.charset[$response:charset]
]
################################################################################