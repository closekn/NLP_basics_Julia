module handle_document

  #=
   * @fn 文章を章で分割する
   * @param (String file_name) 文書の相対パス
   * @return [1] (String[] titles) 文書のタイトル配列 (引数:文書番号)
             [2] (String[] first_sentences) 文書の1行目配列 (引数:文書番号)
             [3] (Dict{String, Int64}[] frequencys) 文書内の単語出現頻度配列 (引数:文書番号 (辞書キー:単語 辞書値:文書内出現頻度))
             [4] (Int64[] words_num) 文書内単語総数 (引数:章番号)
  =#
  function make_chapter_info(file_name)
    file = open(file_name)
    stop_words = make_stop_word_set()

    titles = String[]
    first_sentences = String[]
    frequencys = []
    words_num = Int64[]

    before_empty = false
    next_chapter = false
    first_line = false
    now_chapter = 0

    for line in readlines(file)
      ## 空行チェック
      if line == ""
        if before_empty
          next_chapter = true
        else
          before_empty = true
        end
        continue
      else
        before_empty = false
      end

      ## 章切替
      if next_chapter
        now_chapter += 1
        push!(titles, chomp(line))
        push!(frequencys, Dict{String, Int64}())
        push!(words_num, 0)
        next_chapter = false
        first_line = true
        continue
      end

      # 1行目
      if first_line
        push!(first_sentences, chomp(line))
        first_line = false
      end

      # 単語登録
      words = split(chomp(line), r"[\s-]")          # 空白かハイフンで分割
      for word in words
        word = replace(word, r"[A-Z]" => lowercase) # 英大文字を英小文字へ置換
        word = replace(word, r"[^a-z0-9\']" => "")  # アポストロフィ以外の記号を処理
        if !in(word, stop_words)                    # ストップワードは除外
          words_num[now_chapter] += 1
          if haskey(frequencys[now_chapter], word)
            frequencys[now_chapter][word] += 1
          else
            frequencys[now_chapter][word] = 1
          end
        end
      end
    end

    close(file)

    return titles, first_sentences, frequencys, words_num
  end

  #=
   * @fn ストップワード集合を作成する
   * @return [1] (Set{String} stop_words) ストップワード集合
  =#
  function make_stop_word_set()
    file = open("./../data_file/stop_words_list.txt")
    stop_words = Set{String}()

    for word in readlines(file)
      push!(stop_words, chomp(word))
    end

    close(file)

    return stop_words
  end

end
