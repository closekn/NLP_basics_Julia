module evaluation

  #=
   * @fn TF値(単語の文書内出現頻度の割合)の算出
   * @brief 文書内対象単語出現頻度 / 文書内総単語数
   * @param [1] (Int64 word_num) 文書内総単語数
            [3] (Dict{String, Int64} frequency) 文章内の単語出現頻度 (辞書キー:単語 辞書値:章内出現頻度)
            [4] (String keyword) 対象単語
   * @return (Float64 result) TF値
  =#
  function tf(word_num, frequency, keyword)
    result = ( haskey(frequency, keyword) ) ? frequency[keyword]/word_num : 0.0
    return result
  end

  #=
   * @fn IDF値(対象単語が含まれる文書頻度の逆数)の算出
   * @brief log(総文書数 / 対象単語が含まれる文書数) + 1
   * @param [1] (Dict{String, Int64}[] frequencys) 文書章内の単語出現頻度配列 (引数:文書番号 (辞書キー:単語 辞書値:章内出現頻度))
            [2] (String keyword) 対象単語
   * @return (Float64 result) IDF値
  =#
  function idf(frequencys, keyword)
    chapter_num = size(frequencys)[1]
    df = 0
    for i in 1:chapter_num
      if haskey(frequencys[i], keyword)
        df += 1
      end
    end

    result = ( df != 0 ) ? log(chapter_num/df)+1.0 : 1.0
    return result
  end

  #=
   * @fn 内積の算出
   * @param [1] (Float64[][] vector_space_model) ベクトル空間モデル (引数1:キーワード番号 引数2:文書番号)
            [2] (Float64[] keyword_vec) キーワードベクトル (引数:キーワード番号)
   * @return (Float64 result) 内積
  =#
  function inner_product(vector_space_model, keyword_vec)
    chapter_num = size(vector_space_model[1])[1]
    keyword_num = size(keyword_vec)[1]
    result = Dict{Int64, Float64}()

    for chap in 1:chapter_num
      result[chap] = 0.0
      for key in 1:keyword_num
        result[chap] += vector_space_model[key][chap] * keyword_vec[key]
      end
    end

    return result
  end

  #=
   * @fn コサイン類似度の算出
   * @param [1] (Float64[][] vector_space_model) ベクトル空間モデル (引数1:キーワード番号 引数2:文書番号)
            [2] (Float64[] keyword_vec) キーワードベクトル (引数:キーワード番号)
   * @return (Float64 result) コサイン類似度
  =#
  function cos_similarity(vector_space_model, keyword_vec)
    chapter_num = size(vector_space_model[1])[1]
    keyword_num = size(keyword_vec)[1]
    result = Dict{Int64, Float64}()

    for chap in 1:chapter_num
      numerator = 0.0
      denominator_doc = 0.0
      denominator_key = 0.0
      for key in 1:keyword_num
        denominator_doc += vector_space_model[key][chap] ^ 2
        denominator_key += keyword_vec[key] ^ 2
        numerator += vector_space_model[key][chap] * keyword_vec[key]
      end
      result[chap] = ( numerator != 0.0 ) ? numerator / (sqrt(denominator_doc) * sqrt(denominator_key)) : 0.0
    end

    return result
  end

end
