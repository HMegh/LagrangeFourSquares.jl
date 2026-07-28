module LagrangeFourSquares

using StaticArrays
using Random: MersenneTwister
using Primes


export SumOfSquares, four_squares

include("utils.jl")
include("arithmetic.jl")
include("four_squares.jl")

end
