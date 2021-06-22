using Documenter, ONSAS_docs

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

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
    #format = Documenter.LaTeX(),

    # ---------------------------

    pages = [
        "Home" => "index.md",
        "Tutorials" => Any["Static Von-Mises Truss" =>  "tutorials/StaticVonMisesTruss/staticVonMisesTruss.md",
                           "Cantilever Beam" => "tutorials/CantileverBeam/cantileverBeam.md",
                           "Uniaxial extension" => "tutorials/uniaxialExtension/uniaxialExtension.md"],
        "Guide" => Any["Installation"     => "howtouse/install.md",
                       "Creating Models"  => "howtouse/creatingModels.md"],
        "Theory" => Any["Virtual mechanical work " => "theory/prinMechWork.md",
                        "References"               => "theory/references.md"  ],
        "About" => "about.md",
    ],
    strict = false
)

deploydocs(
    repo = "github.com/ONSAS/ONSAS_docs.git",
    push_preview=true
)
