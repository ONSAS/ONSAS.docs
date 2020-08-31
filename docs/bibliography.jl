using BibTeX, BibTeXFormat, Markdown
using BibTeXFormat: change_case

bibpath = joinpath(@__DIR__, "src/biblio.bib")
_bibpath = joinpath(@__DIR__, "src/_biblio.bib")

# pre-processing step to transform @book into @booklet entries
# (current limitation of BibTeXFormat)
open(_bibpath, "w") do f
    for line in readlines(bibpath)
        if startswith(line, "@book{")
            println(f, replace(line, "@book{" => "@booklet{", count=1))
        else
            println(f, line)
        end
    end
end

# extract contents and convert to markdown
bibliography = Bibliography(read(open(_bibpath), String))
formatted_entries = format_entries(AlphaStyle, bibliography)

cites = Vector{String}()
contents = Vector{Markdown.MD}()
for ei in formatted_entries
    # format keys as eg. [BAB93]
    k = change_case(ei[end], 'u')
    kred = k[1:end-3] * k[end-1:end]
    push!(cites, kred)

    # content string formatting
    x = write_to_string(MarkdownBackend(), ei)
    x = replace(x, match(r"\[(.*?)\]", x).match => "") |> strip |> Markdown.parse

    push!(contents, x)
end

const BIBLIOGRAPHY = Dict(cites .=> contents)

# write references markdown file
refpath = joinpath(@__DIR__, "src/references.md")

open(refpath, "w") do f
    println(f, "# References\n")

    for (i, ci) in enumerate(cites)
        println(f, "---\n")
        println(f, "### [$ci]\n")
        println(f, "- ", contents[i])
    end
end
