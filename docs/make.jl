using Documenter, ONSAS_docs, DocumenterLaTeX

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
include("bibliography.jl")

makedocs(
    sitename = "ONSAS Documentation",
    modules = [ONSAS_docs],
    # ---------------------------
    # case HTML output
    #    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    # ---------------------------
    # case PDF output
    authors = "Authors",
    format = LaTeX(platform = "none"),
    # ---------------------------
    pages = [
        "Home" => "index.md",
        "About" => "about.md",
        "Tutorials" => Any["Static Von-Mises Truss" =>  "tutorials/StaticVonMisesTruss/staticVonMisesTruss.md",
                           "Uniaxial Extension Solid" => "tutorials/uniaxialExtension/uniaxialExtension.md",
                           "Simple pendulum" => "tutorials/SimplePendulum/simple_pendulum.md",
                           "Heat diffusion" => "tutorials/HeatDiffusion/heat.md"],
        "Theory" => Any["Equations" => "theory/equations.md", 
                        "Elements" => "theory/elements.md"],
        "How to use it" => Any["Installation" => "howtouse/install.md",
                               "Creating Models" => "howtouse/creatingModels.md"],
        "References" => "references.md",
    ],
    strict = false,
)

deploydocs(
    repo = "github.com/ONSAS/ONSAS_docs.git",
    push_preview=true
)
