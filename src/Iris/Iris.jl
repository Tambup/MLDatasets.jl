export Iris

"""
Fisher's classic iris dataset.

Measurements from 3 different species of iris: setosa, versicolor and
virginica.  There are 50 examples of each species.

There are 4 measurements for each example: sepal length, sepal width, petal
length and petal width.  The measurements are in centimeters.

The module retrieves the data from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/iris).

NOTE: no pre-defined train-test split for this dataset, `features` and `labels` return the whole dataset. 

## Interface

- [`Iris.features`](@ref)
- [`Iris.labels`](@ref)

## Utilities

- [`Iris.download`](@ref)
"""
module Iris

using DataDeps
using ..MLDatasets: bytes_to_type, datafile, download_dep, download_docstring
using DelimitedFiles

export data, names, download

const DEPNAME = "Iris"
const LINK = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/"
const DOCS = "https://archive.ics.uci.edu/ml/datasets/Iris"
const DATA = "iris.data"

"""
    download([dir]; [i_accept_the_terms_of_use])

Trigger the (interactive) download of the full dataset into
"`dir`". If no `dir` is provided the dataset will be
downloaded into "~/.julia/datadeps/$DEPNAME".

This function will display an interactive dialog unless
either the keyword parameter `i_accept_the_terms_of_use` or
the environment variable `DATADEPS_ALWAY_ACCEPT` is set to
`true`. Note that using the data responsibly and respecting
copyright/terms-of-use remains your responsibility.
"""
download(args...; kw...) = download_dep(DEPNAME, args...; kw...)

function __init__()
    register(DataDep(
        DEPNAME,
        """
        Dataset: The Iris dataset
        Website: $DOCS
        """,
        LINK .* [DATA],
        "1ec014c249120402fc228dbab231129b87a7359699675059035af0f4adc3b863"  # if checksum omitted, will be generated by DataDeps
    ))
end

"""
    labels(; dir = nothing)

Return a string vector of length 150 containing observations' labels.
"""

function trainlabels(; dir = nothing)
    path = datafile(DEPNAME, DATA, dir)
    iris = readdlm(path, ',')
    Vector{String}(iris[:, end])
end

"""
    features(; dir = nothing)

Return a 4x150 matrix containing the 4-dimensional features of each observation.
"""
function traintensor(; dir = nothing)
    path = datafile(DEPNAME, DATA, dir)
    iris = readdlm(path, ',')
    Matrix{Float64}(iris[:, 1:4])' |> collect
end

end # module

