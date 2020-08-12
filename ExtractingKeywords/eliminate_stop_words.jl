file = open("./sample_data/stop_words_list.txt")  # ストップワードファイル
stop_words = Set{String}()                        # set型(ストップワード集合)

for word in readlines(file)
  push!(stop_words, chomp(word))                  # ストップワードをset型へ挿入
end

close(file)

file = open("./sample_data/doc_frequency.txt")    # 単語頻度ファイル
important_words = Pair{String, Int64}[]           # pair型(重要語=>頻度)

for line in readlines(file)
  word_info = split(chomp(line), r"[\t]")         # タブで分割
  if !in(word_info[1], stop_words)                # ストップワードで無ければ、重要語として挿入
    push!(important_words, word_info[1] => parse(Int64, word_info[2]))
  end
end

close(file)

for pair in important_words
  println("$(pair[1])\t$(pair[2])")   # "[単語]\t[頻度]"の形式
end
