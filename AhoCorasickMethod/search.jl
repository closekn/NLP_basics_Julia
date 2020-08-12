include("./aho_corasick.jl")
using .AhoCorasick

function read_txt_file(filename::String) :: String
  txt = ""

  file = open(filename)
  for line in readlines(file)
    txt = txt * line
  end
  close(file)

  return txt
end

# Input English Text file based Search
print("Input text file : ")
input_txt_file_name = chomp(readline())

# Input search keywords
print("Input search keywords : ")
keywords = Array{String, 1}(split(replace(chomp(readline()), r"[A-Z]" => lowercase), r"[\s-]"))

# Read text
input_txt = read_txt_file(String(input_txt_file_name))

# make AC Trie
trie_by_keywords = AhoCorasick.Trie(keywords)

# AC patternmatching
println("txt length : $(length(input_txt))")
AhoCorasick.pattern_matching_machine(trie_by_keywords, input_txt)
