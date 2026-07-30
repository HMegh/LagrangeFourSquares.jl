
# ── four_squares.jl ───────────────────────────────────────────────────────────
# Rabin-Shallit algorithm for the four-square representation.

"""
    _make_sum(n::T, summands::NTuple) -> SumOfSquares

Build a `SumOfSquares` from a tuple, dropping zero summands so the returned
type has the minimal number of squares.
"""
function _make_sum(n::T, raw::NTuple{N, T}) where {N, T<:Integer}
    nonzero = filter(x -> x != zero(T), raw)
    k = length(nonzero)
    if k == 0
        # n must be 0
        return SumOfSquares(n, SVector{1, T}(zero(T)))
    end
    sv = SVector{k, T}(nonzero...)
    return SumOfSquares(n, sv)
end


"""
    four_squares(n::T) -> SumOfSquares{K,T}

Return a representation of the non-negative integer `n` as a sum of `K`
perfect squares, where `K ∈ {1,2,3,4}` is minimal.

Uses the **Rabin-Shallit** probabilistic algorithm (expected O((log n)²) bit
operations).
"""
function four_squares(n::T) where {T<:Integer}

    RNG=MersenneTwister(42)


    n >= zero(T) || throw(ArgumentError("n must be non-negative, got $n"))

    # ── Step 0: n = 0 ────────────────────────────────────────────────────────
    n == zero(T) && return SumOfSquares(n, SVector{1, T}(zero(T)))

    # ── Step 1: strip powers of 4 ────────────────────────────────────────────
    # Write n = 4^a * m; solve for m, then scale result by 2^a.
    m, a = n, 0
    while m % 4 == zero(T)
        m ÷= 4
        a += 1
    end
    scale = T(2)^a  # multiply each summand by this at the end

    # ── Step 2: 1 square ─────────────────────────────────────────────────────
    ok, r = isqrt_check(m)
    if ok
        return _make_sum(n, (scale * r, zero(T), zero(T), zero(T)))
    end

    # ── Step 3: 2 squares ────────────────────────────────────────────────────
    # Iterate x from 1 upward; check if m - x² is a perfect square.
    sq_m = isqrt(m)
    for x in 1:sq_m
        ok, y = isqrt_check(m - x * x)
        if ok
            return _make_sum(n, (scale * x, scale * y, zero(T), zero(T)))
        end
    end

    # ── Step 4: 4 squares via Rabin-Shallit ──────────────────────────────────
    # Randomly pick x, y until p = m - x² - y² is prime and ≡ 1 (mod 4) or 2.
    # Then Cornacchia gives z, w with z² + w² = p.
    # Zeros are pruned at the end (handles the 3-square case).
    while true
        x = T(rand(RNG, 0:Int(sq_m)))
        rem_x = m - x * x
        rem_x <= zero(T) && continue

        sq_rem_x = isqrt(rem_x)
        y = T(rand(RNG, 0:Int(sq_rem_x)))
        p = rem_x - y * y
        p <= zero(T) && continue

        # Check p is a usable prime
        (p == 2 || (Primes.isprime(p) && p % 4 == 1)) || continue

        # Cornacchia: p = z² + w²
        z, w = cornacchia(p)

        return _make_sum(n, (scale * x, scale * y, scale * z, scale * w))
    end
end
