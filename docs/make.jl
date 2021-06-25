using Documenter, ONSAS_docs

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

# sets default format or read provided argument
if length(ARGS)==0
  outputFormat = "html"
else
  outputFormat = ARGS[1]
end

# Generate bibliography
#include("bibliography.jl")


# sets different format and pages settings for each output format
if outputFormat == "pdf"
  makedocs(
    sitename = "ONSAS.m",
    modules = [ONSAS_docs],
    format = Documenter.LaTeX(),
    pages = [
      "index.md"
      ]
  )

elseif outputFormat == "html"

  makedocs(
    sitename = "ONSAS.m",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
      "Introduction" => "index.md"
    ],
    strict = false
  )

  deploydocs(
      repo = "github.com/ONSAS/ONSAS_docs.git",
      push_preview=true
  )

end
#
#     pages = [
#         "Home" => "index.md",
#         "Tutorials" => Any["Static Von-Mises Truss" =>  "tutorials/StaticVonMisesTruss/staticVonMisesTruss.md",
#                            "Cantilever Beam" => "tutorials/CantileverBeam/cantileverBeam.md",
#                            "Uniaxial extension" => "tutorials/uniaxialExtension/uniaxialExtension.md"],
#         "Guide" => Any["Installation"     => "howtouse/install.md",
#                        "Creating Models"  => "howtouse/creatingModels.md"],
#         "Theory" => Any["Virtual mechanical work " => "theory/prinMechWork.md",
#                         "References"               => "theory/references.md"  ],
#         "About" => "about.md",
#     ],
#     strict = false
# )
#
