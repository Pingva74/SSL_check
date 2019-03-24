# SSL_check

Script to verify the validity of SSL certificates on web sites.

Runs as follows ./check_expired_https_certs.sh

The file DOMAINS_TO_CHECK_CERTIFICATES stores a list of domains that we check.

As a result of the script, you will receive a list of domains for which certificates will expire in 30 days. The check interval can be changed, this is the variable DAYS_TO_END

