
import Base: show, collect

"""
    SumOfSquares{N,T<:Integer}

Represents an integer `n` as a sum of `N` squares: `n = a₁² + a₂² + … + aₙ²`.
Summands are stored in non-decreasing order.
"""
struct SumOfSquares{N, T<:Integer}
    n::T
    summands::SVector{N, T}

    function SumOfSquares(n::T, summands::SVector{N, T}) where {N, T<:Integer}
        sum(s -> s * s, summands) == n ||
            throw(ArgumentError("Sum of squares of $summands does not equal $n"))
        new{N, T}(n, sort(summands))
    end
end


# Other constructors: Vectors and n-tuples
SumOfSquares(n::T, summands::NTuple{N, T}) where {N, T<:Integer} =
    SumOfSquares(n, SVector{N, T}(summands...))

SumOfSquares(n::T, summands::AbstractVector{T}) where {T<:Integer} =
    SumOfSquares(n, SVector{length(summands), T}(summands))

function Base.show(io::IO, s::SumOfSquares{N, T}) where {N, T}
    parts = join(["$(x)²" for x in reverse(s.summands)], " + ")
    print(io, "$(s.n) = $parts")
end

Base.collect(s::SumOfSquares) = collect(s.summands)
