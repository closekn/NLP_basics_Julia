# Aho Corasick

Implementation of Aho-Corasick based on the original paper and its implementation.

## How to

```julia
include("./aho_corasick.jl")
using .AhoCorasick
# Building a Trie from Keywords
trie = AhoCorasick.Trie(["he", "she", "his", "hers"])
# Use Trie to find the position of the keyword from a string
AhoCorasick.pattern_matching_machine(trie, "ushers")
```

## Files

|  Files            |  Brief                                                        |
| ----------------- | ------------------------------------------------------------- |
|  aho_corasick.jl  |  Building Trie based on AC and pattern matching of keywords.  |

## Test files

|  Files                      |  Brief                                                                              |
| --------------------------- | ----------------------------------------------------------------------------------- |
|  test_use_AC.jl             |  [How to] & Checking the trie.                                                      |
|  count_AC_order.jl          |  Module to find the number of AC comparisons.                                       |
|  search_and_output_html.jl  |  Output(html) information of the input keywords searched from document(txt) by AC.  |

## Reference

[Alfred V.Aho, Margaret J.Corasick, "Efficient string matching: an aid to bibliographic search", Communications of the ACM, 1975.](https://cr.yp.to/bib/1975/aho.pdf)
