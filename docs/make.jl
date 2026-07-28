using LagrangeFourSquares
using Documenter

DocMeta.setdocmeta!(LagrangeFourSquares, :DocTestSetup, :(using LagrangeFourSquares); recursive=true)

makedocs(;
    modules=[LagrangeFourSquares],
    authors="Haroun Meghaichi",
    sitename="LagrangeFourSquares.jl",
    format=Documenter.HTML(;
        canonical="https://HMegh.github.io/LagrangeFourSquares.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/HMegh/LagrangeFourSquares.jl",
    devbranch="main",
)
