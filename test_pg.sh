#!/bin/bash
# Proper header for a Bash script.

echo '******************'
echo 'PostgreSQL testing'
echo
echo 'This script (test_pg.sh) and the test_pg.rb script are intended'
echo 'for use in developing the Generic App Template and are not'
echo 'intended for projects created with the Generic App gem.'
echo
echo 'Please note that the following files tracked by Git may change:'
echo 'config/database.yml'
echo 'db/schema.rb'
echo
echo "Do you still wish to continue?  If so, please enter 'Y' or 'y'."
read input_continue

if [ $input_continue = "Y" ] || [ $input_continue = "y" ]
then
  ruby test_pg.rb
  echo '**************************'
  echo 'PostgreSQL tests completed'
  echo '**************************'
  echo 'If all went well, no tests failed.'
  echo 'The screen output has been saved in the log directory.'
  echo
  echo 'Please note that the following files tracked by Git may have changed:'
  echo 'config/database.yml'
  echo 'db/schema.rb'
  echo
else
  echo 'Exiting . . . . .'
  echo
fi



