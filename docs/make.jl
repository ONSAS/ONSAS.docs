using Documenter, ONSAS_docs

DocMeta.setdocmeta!(ONSAS_docs, :DocTestSetup,
                    :(using ONSAS_docs); recursive=true)

# sets default format or read provided argument
if length(ARGS)==0
  outputFormat = "html"
else
  outputFormat = ARGS[1]
end

# sets different format and pages settings for each output format
if outputFormat == "pdf"
  makedocs(
    sitename = "ONSAS.m",
    modules = [ONSAS_docs],
    format = Documenter.LaTeX(),
    pages = [
      "index.md",
      "uniaxialExtension.md"
    ]
  )

elseif outputFormat == "html"

  makedocs(
    sitename = "ONSAS.m",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
      "Home" => "index.md",
      "Learning by examples" => Any["Static Von-Mises Truss" =>  "staticVonMisesTruss.md",
                                    "Cantilever Beam" => "cantileverBeam.md",
                                    "Uniaxial extension" => "uniaxialExtension.md"],
      "User guide" => Any["Installation" =>  "howtouse/install.md",
                          "Creating Models"  => "howtouse/creatingModels.md",
                          "References"  => "theory/references.md"]
    ],
    strict = false
  )

  deploydocs(
      repo = "github.com/ONSAS/ONSAS_docs.git",
      push_preview=true
  )

end
#

#         "Guide" => Any["Installation"     => "howtouse/install.md",
#         "Theory" => Any["Virtual mechanical work " => "theory/prinMechWork.md",
#                         "References"               => "theory/references.md"  ],
#         "About" => "about.md",
#     ],
#     strict = false
# )
#
