module LagrangeFourSquares

using StaticArrays
import StableRNGs:StableRNG
using Primes


export SumOfSquares, four_squares

include("utils.jl")
include("arithmetic.jl")
include("four_squares.jl")

end
