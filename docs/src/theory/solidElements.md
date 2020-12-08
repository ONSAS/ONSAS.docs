# Solid Elements Implementation

## Tetrahedron Solid Element

The element has four nodes. And the coordinates of the reference configuration (material coordinates) are represented in the matrix:
```math
eleCoordMat =
\left[
\begin{matrix}
x_{11}   & x_{12} & x_{13} & x_{14} \\
x_{21}   & x_{22} & x_{23} & x_{24} \\
x_{31}   & x_{32} & x_{33} & x_{34} \\
\end{matrix}
\right]
```
where $x_{ij}$ represents the coordinate in the $i$-th dimension of the $j$-th node.


```math
  \textbf{ H } =
    \frac{ \partial \textbf{ u } }
	 { \partial \textbf{ X } }
  H_{ij} =  \frac{ \partial u_i } { \partial \textbf{X}_j }
```



```math
\nabla \textbf{u} = \frac{\partial \textbf{u}}{ \partial \textbf{X}} = eleDispsMat . \frac{\partial \textbf{N}}{ \partial \textbf{X}}
```

The material-isoparametric coordinates relation is given by:
```math
\textbf{X} = eleCoordMat .  \textbf{ N }(\xi)
```
and using the chain rule we obtain:
```math
\frac{\partial \textbf{N}}{ \partial \textbf{X}} = 
\frac{\partial \textbf{N}}{ \partial \xi } . \frac{\partial \xi }{ \partial \textbf{X} } 
```

Then using the inverse theorem we obtain:
```math
\frac{\partial \xi}{ \partial \textbf{X}} = \left( eleCoordMat .  \frac{\partial \textbf{N}}{ \partial \xi } \right)^{-1}
```

```math
\nabla \textbf{u} = eleDispsMat . \left( eleCoordMat .  \frac{\partial \textbf{N}}{ \partial \xi } \right)^{-1}
```

