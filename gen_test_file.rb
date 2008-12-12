#!/usr/bin/env ruby
raise "gen_test_file.rb num_items" unless ARGV.length==1
lower = 100000
upper = 1200000
diff = upper - lower
ARGV[0].to_i.times { |i|puts "#{((rand() * diff ) + lower).to_i} ./item.#{i}" }
