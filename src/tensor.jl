PyClass = PyObject
global D = Dict{PyClass, Type}()

function register!(Type, PyClass)
  global D
  D[PyClass] = Type
end

function dynconvert(x::PyObject)
  global D
  xpytype = PyTorch.pytypeof(x)
  @show T = get(D, xpytype, PyObject)
  convert(T, x)
end

dynconvert(x::PyObject...) = map(dynconvert, x)

macro inherit(f, fname)
  quote
  function $(esc(fname))(args...; kwargs...)
    res = ($f)(args...; kwargs...)
    dynconvert(res)
  end
  end
end

## Example
## =======

"`T` dimensional Tensor"
struct Tensor{T, N}
  data::PyObject
end

Base.convert(::Type{PyObject}, t::Tensor) = t.data
PyCall.PyObject(t::Tensor) = PyObject(t.data)

function Base.convert(::Type{Tensor}, t::PyObject)
  N = t[:dim]()
  Tensor{Float64, N}(t)
end

register!(Tensor, torch.FloatTensor)
register!(Tensor, torch.Tensor)
@inherit torch.rand trand