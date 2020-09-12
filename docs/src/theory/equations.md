## equations

ONSAS is developed to solve the set of nonlynear equations given by the Principle of Virtual Displacements (PVD) and the Principle of Virtual Temperatures (PVT). The PVD is given by the following set of nonlinear equations:

```math
\left(
     \mathbf{f}_{mas}(\mathbf{u}_t, \dot{\mathbf{u}}_t, \ddot{\mathbf{u}}_t) 
  +  \mathbf{f}_{vis}(\dot{\mathbf{u}}_t) 
  +  \mathbf{f}_{int}(\mathbf{u}_t)
  -  \mathbf{f}_{ext}(t)
\right) \cdot \delta \mathbf{u} 
=
0 \qquad \forall \delta \mathbf{u} \in \tilde{\mathcal{U}}
``` 

The PVT is given by:

```math
\left(
\nabla \cdot ( k \nabla T ) + Q_h  - \rho c \frac{\partial T}{\partial t}
\right) \delta T =
0 \qquad \forall \delta T \in \tilde{\mathcal{T}}
```

## Variational formulation of the heat flow equation


```math
    \int_{\Omega} k \nabla T \cdot \nabla \delta T dV
  + \int_{\Omega} \rho c \frac{\partial T}{\partial t} \delta T dV
  =
    \int_{\Omega} Q_h \delta T d V
  + \int_{\partial \Omega} k \nabla T \cdot \hat{\mathbf{n}} \delta T d S 
 \qquad \forall \delta T \in \tilde{\mathcal{T}}
```

Considering the boundary conditions

```math
\left\{
\begin{array}{lr}
T(\mathbf{x},t) = f_D(t) & \text{on} \,\Gamma_D \\
-k \frac{\partial T}{\partial n} (\mathbf{x},t) = f_N(\mathbf{x},t) & \text{on} \, \Gamma_N \\
-k \frac{\partial T}{\partial n} (\mathbf{x},t) = h \left( T(\mathbf{x},t)-T_\infty(t) \right)  & \text{on} \, \Gamma_R
\end{array}
\right.
```

where $h$ is the convection coefficient and $T_\infty(t)$ is the ambient temperature at time $t$.


```math
    \int_{\Omega} k \nabla T \cdot \nabla \delta T dV
  + \int_{\Omega} \rho c \frac{\partial T}{\partial t} \delta T dV
  + \int_{\Gamma_R} h T(\mathbf{x},t) \delta T d S 
  =
    \int_{\Omega} Q_h \delta T d V
  + \int_{\Gamma_N} q_{inp}(\mathbf{x},t)  \delta T d S 
  + \int_{\Gamma_R} h T_\infty(t) \delta T d S 

 \qquad \forall \delta T \in \tilde{\mathcal{T}}
```

where $q_{inp}$ is the input heat flow $q_{inp} = -f_N$.
