"Thin wrapper over PyTorch"
module PyTorch
using PyCall
@pyimport torch
@pyimport torch.nn as nn
@pyimport torch.autograd as autograd
@pyimport torch.optim as optim
@pyimport torch.nn.functional as functional

export nn,
       optim,
       autograd,
       functional

"PyTorch Variable from `x`"
variable(x::Array) = PyTorch.autograd.Variable(PyTorch.torch.Tensor(x))

# struct Tensor
# end
# Tensor = PyObject
include("tensor.jl")

export Tensor

end