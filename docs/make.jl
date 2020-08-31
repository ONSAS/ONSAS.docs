using Documenter, ONSAS_docs

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
include("bibliography.jl")

makedocs(
    sitename = "ONSAS_docs",
    modules = [ONSAS_docs],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "About" => "about.md",
        "Tutorials" => Any["Static Von-Mises Truss" =>  "tutorials/StaticVonMisesTruss/staticVonMisesTruss.md",
                           "Linear elastic solid" => "tutorials/LinearElastic/linear_elastic.md",
                           "Simple pendulum" => "tutorials/SimplePendulum/simple_pendulum.md",
                           "Heat diffusion" => "tutorials/HeatDiffusion/heat.md"],
        "Theory" => Any["Equations" => "theory/equations.md", 
                        "Elements" => "theory/elements.md"],
        "How to use it" => Any["Creating Models" => "howtouse/creatingModels.md"],
        "References" => "references.md",
    ],
    strict = false
)

deploydocs(
    repo = "github.com/ONSAS/ONSAS_docs.git",
    push_preview=true
)
