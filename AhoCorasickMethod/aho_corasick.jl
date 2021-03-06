module AhoCorasick

  mutable struct Trie
    goto::Dict{Tuple{Int64, Char}, Int64}
    failure::Dict{Int64, Int64}
    output::Dict{Int64, Array{String, 1}}

    function Trie(keywords::Array{String, 1})
      goto, output, node_num = construct_goto(keywords)
      output = complement_output(output, node_num)
      failure = construct_failure(goto, output)
      new(goto, failure, output)
    end

    function construct_goto(keywords::Array{String, 1}) :: (Dict{Tuple{Int64, Char}, Int64}, Dict{Int64, Array{String, 1}}, Int64)
      g = Dict{Tuple{Int64, Char}, Int64}()
      output = Dict{Int64, Array{String, 1}}()
      newstate = 0
      for y in keywords
        state = 0
        j = 1
        while !goto_is_fail(g, (state, y[j]))
          state = g[(state, y[j])]
          j += 1
        end
        for p in j:length(y)
          newstate += 1
          g[(state, y[p])] = newstate
          state = newstate
        end
        output[state] = [y]
      end
      for a in 'a':'z'
        if goto_is_fail(g, (0, a))
          g[(0, a)] = 0
        end 
      end
      return g, output, newstate
    end

    function construct_failure(g::Dict{Tuple{Int64, Char}, Int64}, output::Dict{Int64, Array{String, 1}}) :: Dict{Int64, Int64}
      f = Dict{Int64, Int64}()
      queue = []
      for a in 'a':'z'
        s = g[(0, a)]
        if s != 0
          push!(queue, s)
          f[s] = 0
        end
      end
      while !isempty(queue)
        r = popfirst!(queue)
        for a in 'a':'z'
          if !goto_is_fail(g, (r, a))
            s = g[(r, a)]
            push!(queue, s)
            state = f[r]
            while goto_is_fail(g, (state, a))
              state = f[state]
            end
            f[s] = g[(state, a)]
            append!(output[s], output[f[s]])
          end
        end
      end
      return f
    end

    function complement_output(output::Dict{Int64, Array{String, 1}}, node_num::Int64) :: Dict{Int64, Array{String, 1}}
      for i in 0:node_num
        if !haskey(output, i)
          output[i] = []
        end
      end
      return output
    end
  end

  function pattern_matching_machine(trie::Trie, a::String)
    a = replace(a, r"[A-Z]" => lowercase)
    n = length(a)
    state = 0
    for i in 1:n
      if !('a' <= a[i] <= 'z')
        state = 0
        continue
      end
      while goto_is_fail(trie.goto, (state, a[i]))
        state = trie.failure[state]
      end
      state = trie.goto[(state, a[i])]
      if !isempty(trie.output[state])
        println("[find] (index):$(i) (keyword):$(trie.output[state])")
      end
    end
  end

  goto_is_fail(g::Dict{Tuple{Int64, Char}, Int64}, key::Tuple{Int64, Char}) :: Bool = !haskey(g, key)
end
