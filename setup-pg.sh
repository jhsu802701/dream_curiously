#!/bin/bash
# Proper header for a Bash script.

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
n="$(date +%s)"

# Output:
# First argument if it is not blank
# Second argument if first argument is blank
anti_blank () {
  if [ -z "$1" ]; then
    echo $2
  else
    echo $1
  fi
}

dir_root=${PWD##*/} # This directory
db_root_def="db_${dir_root}_${n}" # Default root name of database
echo '*******************************'
echo 'SELECTING POSTGRESQL PARAMETERS'
echo
echo "Default database root name: ${db_root_def}"
echo "Default database name (development): ${db_root_def}_dev"
echo "Default database name (testing): ${db_root_def}_test"
echo "Default database name (production): ${db_root_def}_pro"
echo 'Enter your desired database root name:'
read db_root_sel
db_root=$(anti_blank $db_root_sel $db_root_def)

db_dev="${db_root}_dev"
db_test="${db_root}_test"
db_pro="${db_root}_pro"

env_var_root_def="var_${dir_root}_${n}"
echo
echo 'Default environmental variable names'
echo "Username: ${env_var_root_def}_username"
echo "Password: ${env_var_root_def}_password"
echo 'Enter your desired root name for the environmental variables'
echo 'that store your database username and password:'
read env_var_root_sel
env_var_root=$(anti_blank $env_var_root_sel $env_var_root_def)

env_var_username="${env_var_root}_username"
env_var_password="${env_var_root}_password"

db_username_def="username_${dir_root}_${n}"
echo
echo "Default username: ${db_username_def}"
echo 'Enter the desired username for the database:'
read db_username_sel
db_username=$(anti_blank $db_username_sel $db_username_def)

db_password_def="long_way_stinks"
echo
echo "Default password: ${db_password_def}"
echo 'Enter the desired password for the database:'
read db_password_sel
db_password=$(anti_blank $db_password_sel $db_password_def)

echo
echo "Database name (development): ${db_dev}"
echo "Database name (testing): ${db_test}"
echo "Database name (production): ${db_pro}"
echo
echo 'Environmental variable names'
echo "Username: ${env_var_username}"
echo "Password: ${env_var_password}"
echo
echo "Username: ${db_username}"
echo "Password: ${db_password}"

ruby setup-pg.rb $db_dev $db_test $db_pro $env_var_username $env_var_password $db_username $db_password

sh test_app.sh
