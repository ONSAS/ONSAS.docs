# Creating structural models

The data and properties of each structural model are defined through a set of definitions in a .m script. These properties are stored in [struct](https://octave.org/doc/v5.2.0/Structures.html#Structures) data structures. The following structs must be defined and provided as input to the ONSAS function in this order:

 1. `mesh`
 2. `materials`
 3. `elements`
 4. `boundaryConds`
 5. `initialConds`
 6. `numericalMethod`
 7. `otherParams`

Each struct has its own _fields_ with specific names, used to store each corresponding property or information. Each field is obtained or assiged using _structName.fieldName_. A description of each struct and its fields follows at next.

## The `mesh` struct

The mesh struct contains the finite element mesh information. These are the *required* fields:
 has these fields
 * `nodesCoords`: matrix with the coordinates of all the nodes of the mesh. The $i$-th row contains the three coordinates of the node $i$: $[x_i , \, y_i ,\, z_i]$,
 * `conecCell`: [cell array](https://octave.org/doc/v5.2.0/Cell-Arrays.html) with the elements and node-connectivity information. The $\{i,1\}$ entry contains the vector with the MEBI (Material, Element, boundaryConds and initialConds) indexes and the nodes of the $i$-th element. The structure of the vector at each entry of the cell is:
```math
[ materialInd, \, elementInd, \, boundaryCondInd, \, initialCondInd, \, node_1 \dots node_{n} ]
```
where the five indexes are natural numbers and $n$ is the number of nodes required by the type of element. If noproperty is assigned the $0$ index can be used, for instance, nodes used to introduced loads should be defined with `materialIndex = 0`.

## The `materials` struct

The materials struct contains the information of the material behavior considered for each element. These are the *required* fields for virtual mechanical-work:

 * `hyperElasModel`: this is a cell array with the string-names of the material models used, the options for these names are:
     - `'linearElastic'`: for linear behaviour in small strains and displacements. The scalar parameters of this model are $p_1=E$ the Young modulus and $p_2=\nu$ the Poisson's ratio.
     - `'SVK'`: for a Saint-Venant-Kirchhoff material where the parameters $p_1$ and $p_2$ are the Lamé parameters and $\textbf{E}$ is the Green-Lagrange strain tensor, with the strain-energy density function given by ``\Psi( \textbf{E} ) = \frac{p_1}{2} tr(\textbf{E})^2 + p_2 tr(\textbf{E}^2)``
    - `'NHC'`: for a Neo-Hookean compressible material
 * `hyperElasParams`: a cell structure with vectors with the material properties of each material used in the model. The $i$-th entry of the cell, contains a vector like this:
```math
[ p_1 \dots p_{n_P} ]
```
where $n_P$ is the number of parameters of the constitutive model and $\mathbf{p}$ is the vector of constitutive parameters.

## The `elements` struct

The elements struct contains the information about the type of finite elements used and their corresponding parameters. These are the *required* fields:

* `elemType`: cell structure with the string-names of the elements used: `node`, `truss`, `frame` or `tetra`.

These are the *optional* fields:

* `elemTypeGeometry`: cell structure with the information of the geometry of the element. For `truss` or `frame` elements a vector with the cross-section properties is required:
```math
[ crossSectionType, \,\, crossSectionParam_{1}, \,\,\dots,\,\, crossSectionParam_{n}]
```
with $n$ being the number of parameters of the cross section type, and crossSectionType taking values: 1 (for general sections with given area and interias), 2 (for rectangular sections with given with thicknesses ``t_y`` and ``t_z``) and 3 (for circular sections with given diameter). See the `crossSectionProps.m` function for more details.

## The `boundaryConds` struct

 * `loadCoordSys`: cell containing the coordinates system for the loads applied in each BC, each entry should be a `'global'` string or a `'local'`, or an empty array if no load is applied in that BC setting `[]`.
 * `loadTimeFact`: cell with the inline function definitions of load factors of the loads applied of an empty array.
 * `loadBaseVals`: cell with the vector of the components of the load case
```math
[ f_x,  \, m_x, \, f_y, \, m_y, \, f_z, \, m_z ]
```
 * `userLoadsFileName`: cell with filenames of `.m` function file provided by the user that can be used to apply other forces.
 * `impoDispDofs`: cell with vectors of the local degrees of freedom imposed (integers from 1 to 6)
 * `impoDispVals`: cell with vectors of the values of displacements imposed.
 * `springsDofs`: cell with vectors of the local degrees of freedom with springs (integers from 1 to 6)
 * `springsVals`: cell with vectors of the values of the springs stiffnesses.

## The `initialConds` struct

It initial conditions are homogeneous, then an empty struct should be defined `initialConds = struct() ;`.

 * `nonHomogeneousInitialCondU0`: matrix to set  the value of displacements at the time step $t$=0. [default: []]
 * `nonHomogeneousInitialCondUdot0`: matrix to prescribe the value of velocities at the time step $t$=0. [default: []]

## The `numericalMethod` struct

 * `methodName`: string with the name of the method used: `'linearStep'`, `'newtonRaphson'`,`'arcLength'`,`'newmark'`,`'alphaHHT'`.
 * `stopTolDeltau`: float with tolerance for convergence in relative norm of displacements increment
 * `stopTolForces`: float with tolerance for convergence in relative norm of residual loads
 * `stopTolIts`: integer with maximum number of iterations per time step
 * `deltaT`: time step
 * `finalTime`: final time of simulation
 * `incremArcLen`: with of cylinder for arcLength method
 * `deltaNM`: delta parameter of newmark method
 * `alphaNM`: alpha paramter of newmark method
 * `alphaHHT`: alpha parameter of alpha-HHT method

## The `otherParams` struct

  * `problemName`: string with the name of the problem, to be used in outputs.
  * `plotParamsVector`: 3 for vtk output
  * `controlDofs`: matrix with information of the degrees of freedom to compute and control. Each row should contain this form: `[ node localdof ]`.
  * `storeBoolean`: boolean to store the results of the current iteration such as the displacements, tangent matrices, normal forces and stresses. [default: 1]
  * `nodalDisDamping`: scalar value of external viscous damping for displacements degrees of freedom [default: 0]
