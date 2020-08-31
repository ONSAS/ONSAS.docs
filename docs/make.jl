using Documenter, ONSAS-doc

DocMeta.setdocmeta!(ONSAS-doc, :DocTestSetup,
                    :(using ONSAS-doc); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
include("bibliography.jl")

makedocs(
    sitename = "ONSAS-doc",
    modules = [ONSAS-doc],
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
    repo = "github.com/ONSAS/ONSAS-doc.git",
    push_preview=true
)
