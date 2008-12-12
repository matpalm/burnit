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

N = sizes.length
solution = [false] * N
max = 0
sum = 0

iter = 0
while true 

	idx = (rand() * N).to_i		
	solution[idx] = !solution[idx]
	sum += (solution[idx] ? 1 : -1) * sizes[idx]

	if (sum < MAX_SIZE and sum > max) 
		max = sum
		combo_names = []
		solution.each_with_index { |included,idx| combo_names << names[idx] if included }
		puts "iter=#{iter} new max=#{sum} #{combo_names.join(", ")}"
	end

	iter += 1
end


