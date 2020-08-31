# Heat diffusion

## Introduction

```math
\nabla \cdot (k \nabla T) + Q_h = ρ c \dot{T}
```

## Variational formulation


## Finite-element formulation

## One-dimensional example

Let us consider the one-dimensional heat equation, $\partial_t T(x, t) = \alpha \partial^2_{xx}T(x, t)$ where $\alpha := k / \rho c$ is assumed uniform in the domain $[0,1]$ and constant. $Q_h = 0$ is also assumed. The boundary conditions are given by Dirichlet conditions at both boundaries $T(0,t) = 0$ and $T(1,t)=0$ for all times. The initial condition is given by the following temperature distribution function: 

```math
T(x, t=0) = \phi(x) := \sin \pi x + \frac{1}{2}\sin 3\pi x
```

```@eval
using Plots, LaTeXStrings

ϕ(x) = sin(π*x) + sin(3π*x)/2

ne = 50 # number of elements
xdom = 0:1/ne:1
T0 = ϕ.(xdom)

plot(0:1e-3:1, ϕ, seriestype=:line, lab=L"\phi(x)",
     xlab=L"x", ylab=L"T", legend=:bottomright, title="Initial temperature profile")
plot!(xdom, T0, seriestype = :scatter, lab=L"T(x=x_e, 0)")
savefig("plot_initial_temperature.svg")

nothing
```

![](plot_initial_temperature.svg)

The analytic solution in this case is

```math
T(x, t) = e^{-(\pi \alpha)^2 t}\sin \pi x + \frac{1}{2}e^{-(3\pi \alpha)^2 t}\sin 3\pi x,\qquad 0 \leq x \leq 1, t \geq 0.
```
