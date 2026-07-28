using LagrangeFourSquares
using StaticArrays
using Test

# Helper: verify a SumOfSquares result is correct
function verify(s::SumOfSquares{K, T}, expected_n::T, max_squares::Int) where {K, T}
    @test s.n == expected_n
    @test K <= max_squares
    @test sum(x -> x * x, s.summands) == expected_n
    @test all(x -> x >= 0, s.summands)
    # summands are sorted (non-decreasing)
    @test issorted(s.summands)
end

@testset "LagrangeFourSquares.jl" begin

    @testset "1-square cases" begin
        for n in [0, 1, 4, 9, 16, 25, 100, 10000]
            s = four_squares(n)
            verify(s, n, 1)
        end
    end

    @testset "2-square cases" begin
        # n = a² + b², not a perfect square
        for (n, max_k) in [(2,2), (5,2), (10,2), (13,2), (50,2)]
            s = four_squares(n)
            verify(s, n, 2)
        end
    end

    @testset "3-square cases" begin
        # These are sums of 3 squares (not 1 or 2): 3=1+1+1, 6, 11, 14, 17
        for (n, max_k) in [(3,3), (6,3), (11,3), (14,3), (17,3), (41,3)]
            s = four_squares(n)
            verify(s, n, max_k)
        end
    end

    @testset "4-square cases (n ≡ 7 mod 8)" begin
        # Legendre: n requires 4 squares iff n = 4^a(8b+7)
        for n in [7, 15, 23, 28, 55, 60, 92, 7 * 4, 7 * 16]
            s = four_squares(n)
            verify(s, n, 4)
        end
    end

    @testset "Large values" begin
        for n in [1_000_000, 1_000_000_007, 999_999_937, 2^30]
            s = four_squares(n)
            verify(s, n, 4)
        end
    end

    @testset "Powers of 4 scaling" begin
        # n = 4^a * m should give correct result
        for m in [7, 15, 3, 5, 11]
            for a in [1, 2, 3]
                n = 4^a * m
                s = four_squares(n)
                verify(s, n, 4)
            end
        end
    end

    @testset "Reproducibility" begin
        for n in [7, 23, 1_000_000_007]
            # Reset RNG state by re-running — since we use a global RNG the
            # results should be deterministic across identical run sequences.
            # We just verify correctness here (idempotency via sum check).
            s = four_squares(n)
            @test sum(x -> x * x, s.summands) == n
        end
    end

    @testset "Type parametricity" begin
        @test sum(x -> x * x, four_squares(Int32(7)).summands)  == Int32(7)
        @test sum(x -> x * x, four_squares(Int64(23)).summands) == Int64(23)
        @test sum(x -> x * x, four_squares(big(10)^18).summands) == big(10)^18
    end

    @testset "SumOfSquares constructor validation" begin
        @test_throws ArgumentError SumOfSquares(10, SVector{2, Int}(1, 2))  # 1+4 ≠ 10
    end



    #TODO: Add tests for show method
    @testset "show" begin
    end
    
    @testset "Deterministic output" begin
        # See issue #5
        for _=1:5
            s=four_squares(10^15+3)
            summands=collect(s)
            @test summands == [5515925, 8606428, 14341063, 26264765]
        end
    end


end
