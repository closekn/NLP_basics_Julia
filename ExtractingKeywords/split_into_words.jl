file = open("./sample_data/doc.txt")            # 文章ファイル

for line in readlines(file)[2:end]
  words = split(chomp(line), r"[\s-]")          # 空白かハイフンで分割
  for word in words
    word = replace(word, r"[A-Z]" => lowercase) # 英大文字を英小文字へ置換
    word = replace(word, r"[^a-z0-9\']" => "")  # アポストロフィ以外の記号を処理
    println(word)                               # 1行1単語の形式
  end
end

close(file)
