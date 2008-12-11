#!/usr/bin/env ruby

def encode n
	n ^ n>>1
end

def decode g
	n = g
	s = 1
	while true
		d = n>>s
		n ^= d
		return n if d <= 1 
		s<<=1
	end
end

def log2 n
	Math.log(n) / Math.log(2)
end

MAX_SIZE = (4.3 * 1024 * 1024 * 0.99).to_i

sizes = []
names = []
IO.read('files').each do |line|
	line =~ /(.*?)\s+\.\/(.*)/
	size = $1; name = $2
	sizes << size.to_i
	names << name
end

max = -1.0 / 0.0 # -ve infinity
max_combo = nil
sum = 0; last = 0
combos = 2**sizes.length 
(1...combos).each do |n|	

	g = encode n
	diff = last ^ g
	idx = log2(diff).to_i	
	add = g & diff != 0
	sum += (add ? 1 : -1) * sizes[idx]
	last = g

	if (sum < MAX_SIZE and sum > max) 
		max = sum
		max_combo = g
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
