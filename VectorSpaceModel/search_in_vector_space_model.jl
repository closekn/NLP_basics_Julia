include("./handle_document.jl")
include("./evaluation_method.jl")
using .handle_document
using .evaluation

# 文書情報の生成
file_name = "./../data_file/doc_set.txt"
titles, first_sentences, frequencys, words_num = handle_document.make_chapter_info(file_name)
chapter_num = size(titles)[1]

#== 検索 ==#
while true
  # 検索キーワード入力
  print("Search : ")
  input_str = chomp(readline())
  if input_str == "\\end" || input_str == "\\quit"  # "\end" or "\quit" で検索終了
    break
  end
  keywords = split(input_str, r"[\s-]")

  vector_space_model = []                   # ベクトル空間モデル
  keyword_vec = fill(1.0, size(keywords))   # キーワードベクトル
  # ベクトル空間モデルの作成
  for keyword in keywords
    keyword = replace(keyword, r"[A-Z]" => lowercase) # 英大文字を英小文字へ置換
    model = Float64[]
    idf = evaluation.idf(frequencys, keyword)
    for i in 1:chapter_num
      tf = evaluation.tf(words_num[i], frequencys[i], keyword)
      push!(model, tf*idf)
    end
    push!(vector_space_model, model)
  end

  # 類似度の算出
  similarity = evaluation.inner_product(vector_space_model, keyword_vec)  # 内積
  similarity = sort(collect(similarity), by = x -> x[2], rev=true)        # 類似度降順ソート

  # 検索結果上位10件表示
  println("")
  for result in similarity[1:10]
    chap = result[1]
    sim = result[2]
    if sim == 0.0
      break
    end
    println("No.$(chap) [Title: $(titles[chap])] similarity = $(sim)")
    println("$(first_sentences[chap])\n")
  end
end
