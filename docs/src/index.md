```@meta
CurrentModule = LagrangeFourSquares
```

# LagrangeFourSquares


This package provides a simple implementation of Lagrange's Four Square Theorem, which states that every natural number can be represented as the sum of four integer squares. 

That is, given a natural number $ n $, there exist integers $ a, b, c, d $ such that:
$$n= a^2 + b^2 + c^2 + d^2$$

## Quick start
The function `lagrange_four_squares(n)` returns a representation of the natural number `n` as a sum of four squares. For example:

```julia-repl
julia> using LagrangeFourSquares

julia> four_squares(1001)
1001 = 28² + 10² + 9² + 6²
```

The output is a struct ` SumOfSquares{N, T<:Integer}` which contains the
summands $(28,10,9,6)$ and the original number $1001$. You can access the
summands using the `summands` field, or by using `collect(four_squares(1001))` to get a vector of the summands.

```julia-repl
julia> s=four_squares(1001)
1001 = 28² + 10² + 9² + 6²

julia> s.n
1001

julia> s.summands
4-element StaticArraysCore.SVector{4, Int64} with indices SOneTo(4):
  6
  9
 10
 28

julia> collect(s)
4-element Vector{Int64}:
  6
  9
 10
 28

```





