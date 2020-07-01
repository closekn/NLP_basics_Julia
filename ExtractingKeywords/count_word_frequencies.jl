file = open("./../data_file/doc_separate.txt")   # 分割済単語ファイル
frequency = Dict{String, Int64}()                # 辞書型(key:単語 value:頻度)

for word in readlines(file)
  word = chomp(word)
  if haskey(frequency, word)    # 既出:インクリメント 初出:dict登録
    frequency[word] += 1
  else
    frequency[word] = 1
  end
end

close(file)

frequency = sort(collect(frequency))                  # 辞書順昇順ソート
frequency = sort(frequency, by = x -> x[2], rev=true) # 頻度降順ソート

for pair in frequency
  println("$(pair[1])\t$(pair[2])")   # "[単語]\t[頻度]"の形式
end
