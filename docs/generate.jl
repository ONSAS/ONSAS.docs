# generate examples
import Literate

MODELS = [
    joinpath(@__DIR__, "..", "tutorials", "LinearElastic")
]
GENERATEDDIR = joinpath(@__DIR__, "src", "tutorials")
mkpath(GENERATEDDIR)
for model in MODELS
    for file in readdir(model)
        if endswith(file, ".jl")
            input = abspath(joinpath(model, file))
            script = Literate.script(input, GENERATEDDIR, credit=false)
            code = strip(read(script, String))
            mdpost(str) = replace(str, "@__CODE__" => code)
            Literate.markdown(input, GENERATEDDIR, postprocess=mdpost, credit=false)
            Literate.notebook(input, GENERATEDDIR, execute = true, credit = false)
        elseif any(endswith.(file, [".png", ".jpg", ".gif"]))
            cp(joinpath(model, file), joinpath(GENERATEDDIR, file); force=true)
        else
            @warn "ignoring $file in $model"
        end
    end
end
