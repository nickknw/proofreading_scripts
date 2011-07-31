# translated from these scripts:
# http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/

require './search_helper.rb'

weasels="many|various|very|fairly|several|extremely|exceedingly|quite|remarkably|few|surprisingly|mostly|largely|huge|tiny|(?:(?:are|is) a number)|excellent|interestingly|significantly|substantially|clearly|vast|relatively|completely"
 
do_basic_argument_check

weasels_regex = /#{weasels}/

matches = search_file_with_line_numbers(ARGV[0], weasels_regex)
pretty_print_search_results(matches, "weasel words")

puts "\nLook out for:\n" +
    "    Salt and Pepper words (various, fairly, quite)\n" +
    "    Beholder words (interestingly, surprisingly, clearly)\n" +
    "    Lazy words (very, extremely, several, most, few)\n" +
    "    Adverbs"
