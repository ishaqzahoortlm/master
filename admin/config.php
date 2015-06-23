<?php
// HTTP
define('HTTP_SERVER', 'http://localhost/tlm/admin/');
define('HTTP_CATALOG', 'http://localhost/tlm/');

// HTTPS
define('HTTPS_SERVER', 'http://localhost/tlm/admin/');
define('HTTPS_CATALOG', 'http://localhost/tlm/');

$root_path = $_SERVER['DOCUMENT_ROOT'].'/tlm/';


// DIR
define('DIR_APPLICATION', $root_path.'admin/');
define('DIR_SYSTEM', $root_path.'system/');
define('DIR_LANGUAGE', $root_path.'admin/language/');
define('DIR_TEMPLATE', $root_path.'admin/view/template/');
define('DIR_CONFIG', $root_path.'system/config/');
define('DIR_IMAGE', $root_path.'image/');
define('DIR_CACHE', $root_path.'system/cache/');
define('DIR_DOWNLOAD', $root_path.'system/download/');
define('DIR_UPLOAD', $root_path.'system/upload/');
define('DIR_LOGS', $root_path.'system/logs/');
define('DIR_MODIFICATION', $root_path.'system/modification/');
define('DIR_CATALOG', $root_path.'catalog/');

// DB
define('DB_DRIVER', 'mpdo');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root'); // Stephaniecox23
define('DB_PASSWORD', 'root'); // .FH~=4}GiMg=
define('DB_DATABASE', 'tlm');
define('DB_PREFIX', 'oc_');