# Heat diffusion

## Introduction

```math
\nabla \cdot (k \nabla T) + Q_h = ρ c \dot{T}
```

## Variational formulation


## Finite-element formulation

## One-dimensional example

Consider the one-dimensional example with $Q_h = 0$ with Dirichlet boundary conditions, $T(0) = T(1)=0$ and initial temperature distribution

```math
T(x, t=0) = \phi(x) := \sin \pi x + \frac{1}{2}\sin 3\pi x
```

The analytic solution in this case is

```math
T(x, t) = e^{-(\pi \alpha)^2 t}\sin \pi x + \frac{1}{2}e^{-(3\pi \alpha)^2 t}\sin 3\pi x,\qquad 0 \leq x \leq 1, t \geq 0.
```
where $\alpha := k / \rho c$. 
