# translated from these scripts:
# http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/   

require 'proofreading_help'

irregulars="awoken|been|born|beat|become|begun|bent|beset|bet|bid|bidden|bound|bitten|bled|blown|broken|bred|brought|broadcast|built|burnt|burst|bought|cast|caught|chosen|clung|come|cost|crept|cut|dealt|dug|dived|done|drawn|dreamt|driven|drunk|eaten|fallen|fed|felt|fought|found|fit|fled|flung|flown|forbidden|forgotten|foregone|forgiven|forsaken|frozen|gotten|given|gone|ground|grown|hung|heard|hidden|hit|held|hurt|kept|knelt|knit|known|laid|led|leapt|learnt|left|lent|let|lain|lighted|lost|made|meant|met|misspelt|mistaken|mown|overcome|overdone|overtaken|overthrown|paid|pled|proven|put|quit|read|rid|ridden|rung|risen|run|sawn|said|seen|sought|sold|sent|set|sewn|shaken|shaven|shorn|shed|shone|shod|shot|shown|shrunk|shut|sung|sunk|sat|slept|slain|slid|slung|slit|smitten|sown|spoken|sped|spent|spilt|spun|spit|split|spread|sprung|stood|stolen|stuck|stung|stunk|stridden|struck|strung|striven|sworn|swept|swollen|swum|swung|taken|taught|torn|told|thought|thrived|thrown|thrust|trodden|understood|upheld|upset|woken|worn|woven|wed|wept|wound|won|withheld|withstood|wrung|written"

do_basic_argument_check

passives_regex = /(?:am|are|were|being|is|been|was|be)\b[ ]*(?:\w+ed|(?:#{irregulars}))/

matches = search_file_with_line_numbers(ARGV[0], passives_regex)
pretty_print_search_results(matches, "passive voice")

puts "\nFor each use of the passive highlighted, ask:\n" +
    "    1. Is the agent relevant yet unclear?\n" +
    "    2. Does the text read better with the sentence in the active?\n" +
    "If the answer to both questions is 'yes,' then change to the active.\n" +
    "If only the answer to the first question is 'yes,' then specify the agent. "