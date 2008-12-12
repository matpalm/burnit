#!/usr/bin/env ruby
MAX_SIZE = (4.3 * 1024 * 1024 * 0.99).to_i

sizes = []
names = []
IO.read(ARGV[0]).each do |line|
	line =~ /(.*?)\s+\.\/(.*)/
	size = $1; name = $2
	sizes << size.to_i
	names << name
end

max = -1.0 / 0.0 # -ve infinity
max_combo = nil
combos = 2**sizes.length 
combos.times do |n|

	sum = 0; i = 0; n_ = n
	while n > 0
		bitset = (n & 1)==1
		sum += sizes[i] if bitset
		i += 1
		n >>= 1
	end

	if (sum < MAX_SIZE and sum > max) 
		max = sum
		max_combo = n_
	end
end

idxs = []; i = 0
while max_combo!=0
	idxs << i if (max_combo & 1)==1
	max_combo >>=1
	i += 1
end

puts "max=#{max} idxes=#{idxs.inspect}"
puts idxs.collect { |i| names[i] }.join(', ')
