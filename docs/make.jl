using Documenter, ONSAS_Tutorials

DocMeta.setdocmeta!(ONSAS_Tutorials, :DocTestSetup,
                    :(using ONSAS_Tutorials); recursive=true)

# Generate tutorials
include("generate.jl")

makedocs(
    sitename = "ONSAS_Tutorials.jl",
    modules = [ONSAS_Tutorials],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "Tutorials" => Any["Linear elastic solid" => "tutorials/linear_elastic.md"
                         ],
        "About" => "about.md"
    ],
    strict = false
)

deploydocs(
    repo = "github.com/mforets/ONSAS_Tutorials.jl.git",
    push_preview=true
)
