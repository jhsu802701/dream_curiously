#!/usr/bin/ruby

def devel?
  d1 = size_of_file('log/development.log')
  system('bundle install > /dev/null')
  system('rake db:migrate > /dev/null')
  d2 = size_of_file('log/development.log')
  if d2 > d1
    return true
  else
    return false
  end
end

def size_of_file(filename)
  if File.size(filename).nil?
    return 0
  else
    return File.size(filename)
  end
end
