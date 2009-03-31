<?php 

$file = $_SERVER['DOCUMENT_ROOT'].$_SERVER["REQUEST_URI"].'README.markdown';

$raw = file_get_contents($file);

include(dirname(__FILE__).'/markdown/markdown.php');
$html = Markdown($raw);

preg_match('~^#([^#].*)~', $raw, $matches);
$title=$matches[1];

if (!trim($html)) {
	$html = "<h1>huh?</h1><p>There was some kind of problem, I suppose.</p>";
	$title = "whaa?";
}

ob_start();

?>
<!DOCTYPE html>
<html>
<head>
<style>
* {
	margin:0; padding:0; font-weight:normal;
}
strong, b {
	font-weight:bold;
}
a {
	color:#009;
}
a:hover, a:active {
	color:#900;
}
body {
	width:600px;
	margin:0 auto;
	font-size:16px;
	font-family:serif;
	background:#f8ffee;
	color:#000;
	line-height:24px;
}
body::after {
	content:"XXX";
	font-weight:bold;
	color:#ddd;
	font-family:sans-serif;
	text-align:center;
	display:block;
	font-size:8px;
	line-height:160px;
}
h1, h2, h3, h4, h5, h6, dt {
	font-family:sans-serif;
	color:#060;
	font-size:16px;
}
h1 {
	font-size:48px;
	line-height:48px;
	margin:16px 0;
}
h2 {
	font-size:12px;
	line-height:16px;
	font-weight:bold;
	margin:20px 0 -16px;
	padding-top:2px;
	border-top:2px solid #eee;
	text-align:right;
	font-style:italic;
	font-family:serif;
}
h3 {
	margin:16px 0 0;
	font-weight:bold;
}
h3 a {
	color:#000;
	text-decoration:none;
}
ul, ol, p, dl {
	margin:0 0 16px;
}
dt, dd p {
	margin:0;
}
dd {
	margin: 0 0 0 2ex;
}
</style>
<title><?php echo $title ?></title>
</head>
<body>
<?php echo $html; ?>
</body></html>
<?php
$page = ob_get_contents();
ob_end_flush();
file_put_contents(dirname($file).'/index.html', $page);
