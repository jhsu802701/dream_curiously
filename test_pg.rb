#!/usr/bin/ruby

load 'get_env.rb'

def change_pg_params
  n = Time.now.to_i
  time_str = Time.now.strftime('%Y_%m%d_%H%M_%S')
  dirname = File.basename(Dir.getwd)
  d1 = "db_#{dirname}_#{n}_dev" # Database name (development)
  d2 = "db_#{dirname}_#{n}_test" # Database name (testing)
  d3 = "db_#{dirname}_#{n}_pro" # Database name (production)
  v1 = "var_#{dirname}_#{n}_u" # Environmental variable storing the username
  v2 = "var_#{dirname}_#{n}_p" # Environmental variable storing the password
  u = "user_#{dirname}_#{n}" # Username
  p = 'long_way_stinks' # Password
  command1 = "ruby setup-pg.rb #{d1} #{d2} #{d3} #{v1} #{v2} #{u} #{p} "
  command2 = "2>&1 | tee log/test_pg_#{time_str}.log"
  system("#{command1}#{command2}")
  system("sh test_app.sh 2>&1 | tee -a log/test_pg_#{time_str}.log")
end

if devel? == true
  change_pg_params
  change_pg_params
else
  puts 'This script only works in the development environment.'
end
