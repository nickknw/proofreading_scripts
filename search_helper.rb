# searches ignoring newlines, but includes the line number the match started on
def search_file_with_line_numbers(filename, regexp)
    contents_with_newlines = IO.read(filename)
    
    contents = contents_with_newlines.gsub(/\n/, " ")
    matches = contents.scan(/\b#{regexp}\b/)
    matches.flatten!

    indexes_of_matches = []
    matches.each{|m| 
        indexes_of_matches.push contents.index(/\b#{m}\b/)
        contents.sub!(/\b#{m}\b/, string_of_random_symbols(m.length))
    }

    line_nums_of_matches = match_char_indexes_to_line_numbers(indexes_of_matches, contents_with_newlines)
    contents_as_array_of_lines = contents_with_newlines.split("\n")
    lines_of_matches = line_nums_of_matches.map {|line_num| contents_as_array_of_lines[line_num]}

    search_information = line_nums_of_matches.zip(matches).zip(lines_of_matches)

    # debug
    #p matches
    #p indexes_of_matches
    #p line_nums_of_matches
    #p lines_of_matches

    return search_information
end

def search_file(filename, regexp)
    contents = IO.read(filename).gsub(/\n/, " ")
    matches = contents.scan(/\b#{regexp}\b/)
    matches.flatten
end

def pretty_print_search_results(matches, description_of_results)
    if matches.nil? or matches.empty? then
        puts "\nNo #{description_of_results} found!"
        exit
    end

    puts "\n#{description_of_results.capitalize} results:"
    puts ""
    matches.each do |match| 
        line_num = (match[0][0] + 1).to_s.rjust(4)
        words_matched = match[0][1]
        puts "#{line_num} | #{words_matched} - #{match[1].gsub(/(#{words_matched})/, '>\1<')} "
    end
end

def do_basic_argument_check()
    if ARGV[0].nil? then
        puts "usage: #{File.basename(__FILE__)} <file> ..."
        exit 
    end
end

private
def match_char_indexes_to_line_numbers(char_indexes, contents_with_newlines)
    running_char_count = 0
    index_to_line = {}
    contents_with_newlines.each_line.with_index {|line, line_number|
       start = running_char_count
       running_char_count += line.length
       finish = running_char_count - 1

       index_to_line[(start..finish)] = line_number
    }

    return char_indexes.map {|index| index_to_line.select {|key, val| key === index}.values.first }
end

def string_of_random_symbols(length)
    result = ""
    length.times do
        result += (rand(20) + 40).chr
    end
    result
end
