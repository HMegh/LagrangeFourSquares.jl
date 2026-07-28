module LagrangeFourSquares

using StaticArrays
using Random: MersenneTwister
using Primes

# Fixed-seed RNG for reproducibility
const RNG = MersenneTwister(42)

export SumOfSquares, four_squares

include("utils.jl")
include("arithmetic.jl")
include("four_squares.jl")

end
