# Static Von-Mises Truss

In this tutorial, the static Von Mises Truss is considered. The aim of this example is to validate the Arc Length numerical method implementation by comparing the results provided by ONSAS with the analytical solution. 

The structural model can be seen in the following figure.

FIGURA

The bars are composed of an isotropic elastic and homogeneous material, with elastiity modulus $E$, Poisson coefficient $\nu$=0 and length $L$. The node $2$ is subjected to a variable nodal load $P$ as shown in the figure. The self weight of the bars is neglected, so $\rho$=0.



## MELCS parameters

The modelling of the structure begins with the definition of the MELCS parameters. 

### materialParams

Since both bars are composed of the same material, the cell of `materialParams` only has one vector, being:

```math
materialParams = \{[\;\rho,\;1,\;E,\;\nu\;]\}
```

### elementParams

Two different types of elements are considered, the nodes and the bars. The nodes will be assigned with the index $1$ and the bars with the index $2$. The `elementsParams` cell is therefore:

```math
elementParams = \{ 1,\;2 \}
```

### loadsParams

Only the nodal load $P$ is applied to the structure and its direction corresponde to the global axis $z$. Consequently, the `loadsParams` cell only contains one vector, being:

```math
loadsParams = \{[\;1,\;1,\;0,\;0,\;0,\;0,\;-1,\;0\;]\}
```

### crossSecsParams

Both bars are composed of a square cross section with area $A$. Therefore, the `crossSecsParams` cell results in:

```math
crossSecsParams = \{[\;2,\;\sqrt{A},\;\sqrt{A}\;]\}
```

### springsParams

Two tifferent types of springs are considered. The nodes $1$ and $3$ are pinned and corresponds to one type of spring, the node $3$ has the displacement about the global axis $y$ restrained. The degrees of freedom are considered fully restrained so, the stiffness of the springs are considered as $+\infty$ in the direction that the restrain occurs. The `springsParams` cell is:

```math
crossSecsParams = \Bigg\{
\begin{array}{l}
[&\;\infty,\;0,\;\infty,\;0,\;\infty,\;0\;&] \\
[&\;0,\;0,\;\infty,\;0,\;0,\;0\;&]
\end{array}
\Bigg\}
```

## Nodes and Conec matrices

The bars form an angle $\theta$=65$^o$ with the global axis $x$ direction. Then, the node coordinates can be obtained by simple algebra. The `Nodes` matrix results:

### Nodes matrix

```math
Nodes = \Bigg[
\begin{array}{ccc}
0 & 0 & 0 \\
auxx & 0 & auxz \\
2*auxx & 0 & 0 
\end{array}
\Bigg]
\begin{array}{ccc}
Node\;1 \\
Node\;2 \\
Node\;3 
\end{array}
```

Where the variables `auxx` and `auxz` are defined as:

```math
\begin{array}{l}
auxx\;=\;\cos\left(\dfrac{\theta*\pi}{180}\right)*L \\
auxz\;=\;\sin\left(\dfrac{\theta*\pi}{180}\right)*L
\end{array}
```

### Conec matrix

The Conec cell contains the information defined by the MELCS parameters and also the joint connectivity of the elements. Then, the first five indexes of each vector in the Conec matrix corresponds to the MELCS parameters and the last ones to the joint connectivity of the corresponding element. The Conec cell is defined as:

```math
\left\{
\begin{array}{ccccccc}
[\; &0,\; &1,\; &0,\; &0,\; &1,\; &1\;& ] \\
[\; &0,\; &1,\; &1,\; &0,\; &2,\; &2\;& ] \\
[\; &0,\; &1,\; &0,\; &0,\; &1,\; &3\;& ] \\
[\; &1,\; &2,\; &0,\; &1,\; &0,\; &1,\;&2 ] \\
[\; &1,\; &2,\; &0,\; &1,\; &0,\; &2,\;&3 ] \\
\end{array}
\right\}
\begin{array}{ccccccc}
Fixed\;node \\
Loaded\;node \\
Fixed\;node \\
Truss\;element \\
Truss\;element
\end{array}
```



