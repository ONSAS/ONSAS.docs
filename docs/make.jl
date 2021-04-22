using Documenter, ONSAS_docs, DocumenterLaTeX

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
include("bibliography.jl")

makedocs(
    sitename = "ONSAS.m",
    modules = [ONSAS_docs],

    # ---------------------------
    # case HTML output
        format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),

    # ---------------------------

    # case PDF output
    #authors = "Authors",
    #format = LaTeX(platform = "none"),
    #makedocs(format = DocumenterLaTeX.LaTeX()),

    # ---------------------------

    pages = [
        "Home" => "index.md",
        "Tutorials" => Any["Static Von-Mises Truss" =>  "tutorials/StaticVonMisesTruss/staticVonMisesTruss.md",
                           "Cantilever Beam" => "tutorials/CantileverBeam/cantileverBeam.md"],
        "Guide" => Any["Installation"     => "howtouse/install.md",
                       "Creating Models"  => "howtouse/creatingModels.md"],
        "Theory" => Any["Virtual mechanical work " => "theory/prinMechWork.md",
                        "Virtual thermal work"     => "theory/prinTherWork.md",
			            "References"               => "theory/references.md"  ],
        "About" => "about.md",
    ],
    strict = false
)

deploydocs(
    repo = "github.com/ONSAS/ONSAS_docs.git",
    push_preview=true
)
