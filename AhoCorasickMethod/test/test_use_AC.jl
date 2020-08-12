include("./../aho_corasick.jl")
using .AhoCorasick

function print_elem(self::AhoCorasick.Trie)
  println("== goto ==")
  println(self.goto)
  println()
  println("== failure ==")
  println(self.failure)
  println()
  println("== output ==")
  println(self.output)
  println()
end

test1 = AhoCorasick.Trie(["ab", "bc", "bab", "d", "abcde"])
print_elem(test1)
AhoCorasick.pattern_matching_machine(test1, "babcdex")
println()

test2 = AhoCorasick.Trie(["he", "she", "his", "hers"])
print_elem(test2)
AhoCorasick.pattern_matching_machine(test2, "ushers")
