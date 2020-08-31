using Documenter, ONSAS_docs

DocMeta.setdocmeta!(ONSAS_Tutorials, :DocTestSetup,
                    :(using ONSAS_Tutorials); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
include("bibliography.jl")

makedocs(
    sitename = "ONSAS_Tutorials",
    modules = [ONSAS_Tutorials],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "Tutorials" => Any["Linear elastic solid" => "tutorials/LinearElastic/linear_elastic.md",
                           "Simple pendulum" => "tutorials/SimplePendulum/simple_pendulum.md",
                           "Heat diffusion" => "tutorials/HeatDiffusion/heat.md"],
        "References" => "references.md",
        "Elements" => Any["1DHeat" => "elements/1DHeat.md"],
        "About" => "about.md"
    ],
    strict = false
)

deploydocs(
    repo = "github.com/ONSAS/ONSAS_Tutorials.git",
    push_preview=true
)
