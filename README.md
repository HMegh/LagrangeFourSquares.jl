# LagrangeFourSquares

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://HMegh.github.io/LagrangeFourSquares.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://HMegh.github.io/LagrangeFourSquares.jl/dev/)
[![Build Status](https://github.com/HMegh/LagrangeFourSquares.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/HMegh/LagrangeFourSquares.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/HMegh/LagrangeFourSquares.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/HMegh/LagrangeFourSquares.jl)

This package provides function for finding the four squares representation of a given integer.


[Lagrange's four-square theorem](https://en.wikipedia.org/wiki/Lagrange%27s_four-square_theorem) states that every natural number can be represented as the sum of four integer squares. This package implements an efficient algorithm to find such a representation.

## Usage

This package export one main function `four_squares(n::Integer)` which returns a tuple of four integers `(a, b, c, d)` such that: `n=a^2 + b^2 + c^2 + d^2`.

```julia
julia> using LagrangeFourSquares
julia> four_squares(1001)
1001 = 28² + 10² + 9² + 6²
```


