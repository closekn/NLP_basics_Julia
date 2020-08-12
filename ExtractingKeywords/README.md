# Extracting Keywords

## How to

- Need  
Prepare an English file and a stop-word list file.  
("./sample_data/doc.txt", "./sample_data/stop_words_list.txt")
- Run  
`$ ./extracting_kwywords.sh`
- Make  
Files showing split words and frequency of occurrence, excluding stop words.  
("./sample_data/doc_important.txt")

## Files

|  Files                       |  Brief                                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------------------ |
|  split_into_words.jl         |  "./sample_data/doc.txt" into words.                                                       |
|  count_words_frequencies.jl  |  Count the frequency of occurrence of the segmented words and arrange them in that order.  |
|  eliminate_stop_words.jl     |  Eliminate the stop words marked in "./sample_data/stop_words_list.txt".                   |
|  extracting_keywords.sh      |  Run the above files in order.                                                             |
