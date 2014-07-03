# encoding : utf-8
######################################
# Cucure 
# Cucumber refactoring tool
# by Victor Aguilera
# www.vaguilera.com
######################################

require 'colorize'

	version = 0.1
	num_files = 0
	steps_def = Array.new	
	steps_tests = Array.new
	base_path = "."
	
	
	
	ARGV.each do|arg|
		if arg == "-v" then
			puts "Cucure (Cucumber refactoring tool) V#{version}\n"
		end
		if arg.start_with?("-F") then
			base_path = arg[2, arg.length - 2] 
			puts base_path
		end

	end

	puts "\nSearching in: #{base_path}/features/step_definitions/"
	puts "Searching in: #{base_path}/features/web/\n\n"
	
	Dir.glob("#{base_path}/features/step_definitions/**/*.rb") do |file|
		num_files+=1
		File.open(file, "r").each_line do |line|
			if line.strip.start_with?('Then', 'When', 'Given', 'And') 
				steps_def.push({ :regexp =>  Regexp.new(line.match(/\/(.*?)\//)[1]), :found =>false } )				
			end
		end
	end
	
	
	puts "Step Files:\t #{num_files} - Defintion Steps:\t #{steps_def.length}".yellow
	
	num_files = 0
	
	Dir.glob("#{base_path}/features/web/**/*.feature") do |file|
		num_files+=1		
		File.open(file, "r").each_line do |line|
			if line.strip.start_with?('Then', 'When', 'Given', 'And') 
	
				current_step = line.strip.gsub(/^Then |^When |^Given |^And /,'').strip
				steps_tests.push(current_step)		

			end
		end		
	end
	
	puts "Features files:\t #{num_files} - Steps in features:\t #{steps_tests.length}".yellow
	puts "\n"

	steps_tests.each do |step|
		steps_def.each do |step_def|
			unless step.match(step_def[:regexp]).class == NilClass
				step_def[:found] = true
				break
			end
		end
	end
	
	puts "Unused steps:"
	steps_def.each do |step_def|
		
		unless step_def[:found] 
			step = step_def[:regexp].to_s
			puts step[7, step.length - 8] 
		end
	
	end

	













