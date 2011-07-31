# translated from these scripts:
# http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/   

require './search_helper.rb'

do_basic_argument_check

# http://stackoverflow.com/questions/1058783/regular-expression-to-find-and-remove-duplicate-words/1212118#1212118
duplicates_regex = /\b(\S+)\b(?=\s+\b\1\b)/

matches = search_file(ARGV[0], duplicates_regex)
if !matches.empty?
    duplicates_with_context_regex = /#{matches.map{|m| "#{m}\\s+#{m}"}.join("|")}/
    matches = search_file_with_line_numbers(ARGV[0], duplicates_with_context_regex)
end
pretty_print_search_results(matches, "duplicated words")

