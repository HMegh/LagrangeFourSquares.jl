
# ── arithmetic.jl ─────────────────────────────────────────────────────────────
# Low-level number-theory primitives for the Rabin-Shallit algorithm.

"""
    isqrt_check(n::T) -> (Bool, T)

Return `(true, r)` if `n` is a perfect square with `r² = n`,
or `(false, isqrt(n))` otherwise.
"""
function isqrt_check(n::T) where {T<:Integer}
    n < 0 && return (false, zero(T))
    r = isqrt(n)
    r * r == n ? (true, r) : (false, r)
end


"""
    sqrt_neg1_mod_p(p::T) -> T

Given an odd prime `p ≡ 1 (mod 4)`, return `r` such that `r² ≡ -1 (mod p)`.

Uses the identity `r = g^((p-1)/4) mod p` where `g` is a quadratic non-residue
mod `p` (i.e. the Legendre symbol `(g/p) = -1`).
"""
function sqrt_neg1_mod_p(p::T) where {T<:Integer}
    # Find a quadratic non-residue g by trial (on average ~2 tries).
    # g is a non-residue mod p iff g^((p-1)/2) ≡ -1 (mod p)  (Euler's criterion).
    g = T(2)
    while powermod(g, (p - one(T)) ÷ T(2), p) != p - one(T)
        g += one(T)
    end
    # r = g^((p-1)/4) mod p
    powermod(g, (p - one(T)) ÷ T(4), p)
end


"""
    cornacchia(p::T) -> (T, T)

Given a prime `p` with `p == 2` or `p ≡ 1 (mod 4)`, return `(a, b)` with
`a ≥ b ≥ 0` and `a² + b² = p`, using Cornacchia's algorithm.

Throws `ArgumentError` if no solution exists (i.e. p is not a sum of two squares).
"""
function cornacchia(p::T) where {T<:Integer}
    if p == T(2)
        return (one(T), one(T))
    end
    p % T(4) == T(1) || throw(ArgumentError("p must be 2 or ≡ 1 (mod 4), got $p"))

    # Step 1: find r with r² ≡ -1 (mod p), 0 < r < p/2
    r = sqrt_neg1_mod_p(p)
    # Ensure r < p/2
    if r > p ÷ T(2)
        r = p - r
    end

    # Step 2: Euclidean algorithm on (p, r), stopping when remainder < √p
    sqrtp = isqrt(p)
    a, b = p, r
    while b > sqrtp
        a, b = b, a % b
    end
    # Now b² + c² = p where c² = p - b²
    ok, c = isqrt_check(p - b * b)
    ok || throw(ArgumentError("Cornacchia failed for p = $p"))
    return b >= c ? (b, c) : (c, b)
end
