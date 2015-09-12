#!/bin/bash
# Proper header for a Bash script.

bundle install

echo '****************'
echo 'brakeman -Aq -w2'
brakeman -Aq -w2

echo '*******'
echo 'rubocop'
rubocop

echo '***********'
echo 'sandi_meter'
sandi_meter

echo '***************************************************************'
echo 'rails_best_practices -e "app/controllers/users_controller.rb" .'
rails_best_practices -e "app/controllers/users_controller.rb" .

echo '************'
echo 'bundle-audit'
bundle-audit

echo '*******************************'
echo 'metric_fu --no-open > /dev/null'
metric_fu --no-open > /dev/null
echo 'The metric_fu test results are at tmp/metric_fu/output/index.html .'
