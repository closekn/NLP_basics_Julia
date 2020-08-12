#!/bin/bash

# 単語分割
julia split_into_words.jl > ./sample_data/doc_separate.txt

# 単語出現頻度カウント
julia count_word_frequencies.jl > ./sample_data/doc_frequency.txt

# ストップワードの削除
julia eliminate_stop_words.jl > ./sample_data/doc_important.txt
