module CountOrderOfAhoCorasick

  mutable struct Trie
    goto::Dict{Tuple{Int64, Char}, Int64}
    failure::Dict{Int64, Int64}
    output::Dict{Int64, Array{String, 1}}
    comparison::Int64

    function Trie(keywords::Array{String, 1})
      goto, output, node_num, comparison = construct_goto(keywords)
      output = complement_output(output, node_num)
      failure, comparison = construct_failure(goto, output, comparison)
      new(goto, failure, output, comparison)
    end

    function construct_goto(keywords::Array{String, 1}) :: (Dict{Tuple{Int64, Char}, Int64}, Dict{Int64, Array{String, 1}}, Int64, Int64)
      g = Dict{Tuple{Int64, Char}, Int64}()
      output = Dict{Int64, Array{String, 1}}()
      comp = 0
      newstate = 0
      for y in keywords
        state = 0
        j = 1
        while !goto_is_fail(g, (state, y[j]))
          state = g[(state, y[j])]
          j += 1
          comp += 1
        end
        for p in j:length(y)
          newstate += 1
          g[(state, y[p])] = newstate
          state = newstate
          comp += 1
        end
        output[state] = [y]
        comp += 1
      end
      for a in 'a':'z'
        if goto_is_fail(g, (0, a))
          g[(0, a)] = 0
        end 
        comp += 1
      end
      return g, output, newstate, comp
    end

    function construct_failure(g::Dict{Tuple{Int64, Char}, Int64}, output::Dict{Int64, Array{String, 1}}, comp::Int64) :: (Dict{Int64, Int64}, Int64)
      f = Dict{Int64, Int64}()
      queue = []
      for a in 'a':'z'
        s = g[(0, a)]
        if s != 0
          push!(queue, s)
          f[s] = 0
        end
        comp += 1
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
              comp += 1
            end
            f[s] = g[(state, a)]
            append!(output[s], output[f[s]])
          end
          comp += 1
        end
        comp += 1
      end
      return f, comp
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

  function pattern_matching_machine(trie::Trie, a::String) :: Tuple{Dict{Int64, Array{String, 1}}, Int64}
    a = replace(a, r"[A-Z]" => lowercase)
    n = length(a)
    result = Dict{Int64, Array{String, 1}}()
    comparison = 0
    state = 0
    for i in 1:n
      if !('a' <= a[i] <= 'z')
        state = 0
        comparison += 1
        continue
      end
      while goto_is_fail(trie.goto, (state, a[i]))
        state = trie.failure[state]
        comparison += 1
      end
      state = trie.goto[(state, a[i])]
      if !isempty(trie.output[state])
        result[i] = trie.output[state]
      end
      comparison += 1
    end
    return (result, comparison)
  end

  goto_is_fail(g::Dict{Tuple{Int64, Char}, Int64}, key::Tuple{Int64, Char}) :: Bool = !haskey(g, key)
end
