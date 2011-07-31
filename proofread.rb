# These scripts are made to proofread technical documents and likely don't apply
# as well to other forms of writing.
filename = ARGV[0]
File.open("feedback-#{filename}", "w+") do |file|
    weasel_results = `ruby weasel_words.rb #{filename}` + "\n"
    puts weasel_results
    file.puts weasel_results

    passive_results = `ruby passive_voice.rb #{filename}` + "\n"
    puts passive_results
    file.puts passive_results

    dup_results = `ruby duplicated_words.rb #{filename}` + "\n"
    puts dup_results
    file.puts dup_results
end

puts "Results saved in: feedback-#{filename}"
