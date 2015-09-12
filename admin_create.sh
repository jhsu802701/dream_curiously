#!/bin/bash
# Proper header for a Bash script.

echo '**********************'
echo 'Entering rails console'
bundle exec rails runner "eval(File.read 'admin_create.rb')"
