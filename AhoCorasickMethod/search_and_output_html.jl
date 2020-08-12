include("./count_AC_order.jl")
using .CountOrderOfAhoCorasick

function read_txt_file(filename::String) :: String
  txt = ""

  file = open(filename)
  for line in readlines(file)
    txt = txt * line * "\n"
  end
  close(file)

  return txt
end

function insert_str(base_str::String, insert_index::Int64, insert_str::String) :: String
  return base_str[1:insert_index-1] * insert_str * base_str[insert_index:length(base_str)]
end

function make_output_txt(input_txt::String, match_result::Dict{Int64, Array{String, 1}}) :: String
  output_txt = input_txt

  num_b_tag = 0
  before_key_pos = -1
  before_end_pos = -1
  for i in 1:length(input_txt)
    if haskey(match_result, i)
      max_len = 0
      for key in match_result[i]
        max_len = max(max_len, length(key))
      end
      end_pos = i+1 + (7*num_b_tag)
      output_txt = insert_str(output_txt, end_pos, "</b>")
      start_pos = ( i-max_len > before_key_pos ) ? i-max_len+1 + (7*num_b_tag) : before_end_pos+7
      output_txt = insert_str(output_txt, start_pos, "<b>")
      num_b_tag += 1
      before_key_pos = i
      before_end_pos = end_pos
    end
  end

  return output_txt
end

#===============================#
#== Search using Aho Corasick ==#
#===============================#

# Input English Text file based Search
print("Input text file pass : ")
input_txt_file_name = String(chomp(readline()))

# Input search keywords
print("Input search keywords : ")
keywords = Array{String, 1}(split(replace(chomp(readline()), r"[A-Z]" => lowercase), r"[\s-]"))

# Read text
input_txt = read_txt_file(input_txt_file_name)

# make AC Trie
trie_by_keywords = CountOrderOfAhoCorasick.Trie(keywords)

# AC patternmatching
result_tuple = CountOrderOfAhoCorasick.pattern_matching_machine(trie_by_keywords, input_txt)
match_result = result_tuple[1]
comparison = result_tuple[2]

# make output txt
output_txt = make_output_txt(input_txt, match_result)

# make output html file
print("output html file pass : ")
output_html_file_name = String(chomp(readline()))
run(`touch $(output_html_file_name)`)
output_html_file = open(output_html_file_name, "w")
write(output_html_file, "<h1> Search Information </h1>\n")
write(output_html_file, "<ul><li> Search keywords <ul><li> $keywords </li></ul> </li>\n")
write(output_html_file, "<li> Number of comparisons required to build a Trie based on keywords <ul><li> $(trie_by_keywords.comparison) </li></ul> </li>\n")
write(output_html_file, "<li> Number of characters in the document <ul><li> $(length(input_txt)) </li></ul> </li>\n")
write(output_html_file, "<li> Number of document comparisons based on the constructed Trie <ul><li> $comparison </li></ul> </li></ul>\n")
write(output_html_file, "<h1> Document </h1>\n")
write(output_html_file, replace(output_txt, r"\n" => " <br>\n"))
close(output_html_file)
