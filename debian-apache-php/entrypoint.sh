#!/bin/bash -e

# www-data user 
usermod -o -u $APACHE_RUN_UID www-data
groupmod -o -g $APACHE_RUN_GID www-data

