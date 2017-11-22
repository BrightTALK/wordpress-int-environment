#!/bin/bash
set -euo pipefail

if [ -e wp-config-sample.php ]; then
	sed -i '/WP_DEBUG/a \
// Cache all the things \
global $memcached_servers; \
$memcached_servers = array( \
	array( "memcached", "11211" ) \
	); \
  \
// Proxy Server Settings \
define("WP_PROXY_HOST", "proxy.gr.brighttalk.com"); \
define("WP_PROXY_PORT", "443"); \
define("WP_PROXY_USERNAME", ""); \
define("WP_PROXY_PASSWORD", ""); \
define("WP_PROXY_BYPASS_HOSTS", "localhost"); \
  \ 
// Allow LB to terminate SSL connection \
$_SERVER["HTTPS"] = "on"; \
$_SERVER["SERVER_PORT"] = 443; \
#define("FORCE_SSL_ADMIN", true); \
  \
// Allos WP to connect to web \
define("FS_METHOD", "direct"); \
  \
define( "WP_CACHE", true );' wp-config-sample.php 

fi
