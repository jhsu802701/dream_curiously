#!/bin/bash
# Proper header for a Bash script.

# PREREQUISITES:
# heroku login
# heroku keys:add
# heroku create
# heroku rename

# Check for name of default Heroku repository:
# git remote -v

# To correct the name of the Heroku repository:
# git remote rm heroku
# git remote add heroku git@heroku.com:<name>.git

echo '----------------------'
echo 'git push heroku master'
git push heroku master

echo '--------------------------'
echo 'heroku run rake db:migrate'
heroku run rake db:migrate

echo '-------------'
echo 'git remote -v'
git remote -v
