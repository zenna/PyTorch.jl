"Thin wrapper over PyTorch"
module PyTorch
using PyCall
@pyimport torch
@pyimport torch.nn as nn
@pyimport torch.autograd as autograd
@pyimport torch.optim as optim

export nn,
       optim,
       autograd

"PyTorch Variable from `x`"
variable(x::Array) = PyTorch.autograd.Variable(PyTorch.torch.Tensor(x))
       
end