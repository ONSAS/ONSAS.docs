## Example uniaxialSolid

In this example an elastic solid is submitted to a uniaxial extension test. The problem is inspired by Exercise 4 from section 6.5 in (Holzapfel,2000). The geometry and tension applied are shown in the figure, where the $Lx$, $Ly$ and $Lz$ are the dimensions and the tension $p$ is applied on the face $x=Lx$, as nominal traction (see (Holzapfel,2000)).

```@raw html
<img src="https://raw.githubusercontent.com/ONSAS/ONSAS_docs/master/docs/src/diagramSolidUniaxialHTML.svg" alt="structure diagram" width="500"/>
```

```@raw latex
\begin{center}
\def\svgwidth{0.7\textwidth}
\input{diagramSolidUniaxialPDF.pdf_tex}
\end{center}
```

### Analytic solution

Let us consider a uniform deformation with parametric deformation gradient and corresponding Green-Lagrange strain tensor given by
```math
\textbf{F} = \left[ \begin{matrix} \alpha & 0 & 0 \\ 0 & \beta & 0 \\ 0 & 0 & \beta \end{matrix} \right]
\qquad
\textbf{E} = \left[  \begin{matrix} \frac{1}{2} \left(\alpha^2 -1\right) & 0 & 0 \\ 0 &  \frac{1}{2} \left(\beta^2 -1\right) & 0 \\ 0 & 0 &  \frac{1}{2} \left(\beta^2 -1\right) \end{matrix} \right]
```
The second Piola-Kirchhoff tensor $\textbf{S}$ is given by
```math
\textbf{S}( \textbf{E} ) = p_1 tr(\textbf{E}) \textbf{I} + 2 p_2 \textbf{E}
```
 then, using the relation $\textbf{P}=\textbf{F}\textbf{S}$, the $P_{yy}$ component is computed and set zero (by the boundary conditions)
```math
P_{yy}( \textbf{E} ) =
p_1 \beta \left(
             \frac{1}{2} \left(\alpha^2 -1 \right) + \left( \beta^2 -1\right)
 \right) + 2 p_2 \beta (\frac{1}{2} \left(\beta^2 -1 \right)) = 0
```
then, using that $\beta\neq0$ (since $\text{det}( \textbf{F} ) \neq0$), we obtain
```math
 p_1 \frac{1}{2} \left(\alpha^2 -1 \right)
 = - (p_1+p_2) \left(\beta^2 -1 \right)
```
 then using $p_2$ and $p_1$ expressions we obtain

```math
 \left(\beta^2 -1 \right) = -\nu \left(\alpha^2 -1 \right).
```

 The axial component of the nominal stress is
```math
P_{xx}( \textbf{E} ) =
p_1 \alpha \left(
             \frac{1}{2} \left(\alpha^2 -1 \right) + \left( \beta^2 -1\right)
 \right) + 2 p_2 \alpha (\frac{1}{2} \left(\alpha^2 -1 \right)) = 0
```
 and substituting we obtain

```math
P_{xx}( \alpha ) =
p_1 \alpha \frac{1-2\nu}{2} \left(\alpha^2 -1 \right) + p_2 \alpha \left(\alpha^2 -1 \right) =
 \left( \frac{E \nu}{(1+\nu)2}  + \frac{E}{(1+\nu)2} \right)  \alpha \left(\alpha^2 -1 \right)
```
 thus, considering the axial displacement $u$ and using the stretch definition $\alpha = (1+u/Lx)$, we obtain
```math
P_{xx}( u ) =
 \frac{E}{2}  \left( \left( 1+\frac{u}{Lx} \right)^3 - \left( 1+ \frac{u}{Lx} \right) \right)
```

### Numerical solution
Before defining the structs, the workspace is cleaned, the ONSAS directory is added to the path and scalar geometry and material parameters are defined.
```
clear all, close all
% add path
addpath( genpath( [ pwd '/../../src'] ) ) ;
% scalar parameters
E = 1 ; nu = 0.3 ; p = 3 ; Lx = 2 ; Ly = 1 ; Lz = 1 ;
```


### MEBI parameters

#### materials
 The material of the solid considered is the Saint-Venant-Kirchhoff with Lamé parameters computed as
```
lambda = E*nu/((1+nu)*(1-2*nu)) ; mu = E/(2*(1+nu)) ;
```
 since only one material is considered, the structs defined for the materials contain only one entr
```
materials.hyperElasModel = {'SVK'} ;
materials.hyperElasParams = { [ lambda mu ] } ;
```

#### elements
 In this model two kinds of elements are used: tetrahedrons for the solid and triangles for introducing the external loads. Since two kinds of elements are used, the structs have length 2:
```
elements.elemType = { 'triangle', 'tetrahedron' } ;
```
 since triangle and tetrahedron elements dont have specific parameters the struct entries contain empty vectors
```
elements.elemTypeParams = { [];[] } ;
elements.elemTypeGeometry = { [];[] } ;
```

#### boundaryConds
 in this case four BCs are considered, one corresponding to a load and three to displacements.
```
boundaryConds.loadsCoordSys = {'global'; [] ; [] ; [] } ;
boundaryConds.loadsTimeFact = { @(t) t ; [] ; [] ; []} ;
boundaryConds.loadsBaseVals = { [p 0 0 0 0 0 ] ; [] ; [] ; [] } ;
boundaryConds.imposDispDofs = { [] ; [1] ; [3] ; [5] } ;
boundaryConds.imposDispVals = { [] ; [0] ; [0] ; [0] } ;
```

#### initialConds
 since no initial non-homogeneous initial conditions are used, an empty struct is used .
```
initialConds = struct();
```

### Mesh
 An 8-node mesh is considered with its connectivity matrix

```@raw html
<img src="https://raw.githubusercontent.com/ONSAS/ONSAS_docs/master/docs/src/solidCubeMeshHTML.svg" alt="structure diagram" width="500"/>
```
```@raw latex
\begin{center}
\def\svgwidth{0.6\textwidth}
\input{solidCubeMeshPDF.pdf_tex}
\end{center}
```
 The connectivity matrix is given by the following matrix
```
mesh.nodesCoords = [ 0    0    0 ; ...
                     0    0   Lz ; ...
                     0   Ly   Lz ; ...
                     0   Ly    0 ; ...
                     Lx   0    0 ; ...
                     Lx   0   Lz ; ...
                     Lx  Ly   Lz ; ...
                     Lx  Ly    0 ] ;
```
 and the connectivity cell is defined as follows with the MEBI integer parameters for each element. All the eight triangle elements are considered with no material (since they are used only to include load) and the following six elements are solid SVK material tetrahedrons.

```
mesh.conecCell = {[ 0 1 1 0    5 8 6   ]; ... % loaded face
                  [ 0 1 1 0    6 8 7   ]; ... % loaded face
                  [ 0 1 2 0    4 1 2   ]; ... % x=0 supp face
                  [ 0 1 2 0    4 2 3   ]; ... % x=0 supp face
                  [ 0 1 3 0    6 2 1   ]; ... % y=0 supp face
                  [ 0 1 3 0    6 1 5   ]; ... % y=0 supp face
                  [ 0 1 4 0    1 4 5   ]; ... % z=0 supp face
                  [ 0 1 4 0    4 8 5   ]; ... % z=0 supp face
                  [ 1 2 0 0    1 4 2 6 ]; ... % tetrahedron
                  [ 1 2 0 0    6 2 3 4 ]; ... % tetrahedron
                  [ 1 2 0 0    4 3 6 7 ]; ... % tetrahedron
                  [ 1 2 0 0    4 1 5 6 ]; ... % tetrahedron
                  [ 1 2 0 0    4 6 5 8 ]; ... % tetrahedron
                  [ 1 2 0 0    4 7 6 8 ]  ... % tetrahedron
                } ;
```

### Analysis parameters

```
analysisSettings.methodName    = 'newtonRaphson' ;
analysisSettings.stopTolIts    = 30      ;
analysisSettings.stopTolDeltau = 1.0e-12 ;
analysisSettings.stopTolForces = 1.0e-12 ;
analysisSettings.finalTime      = 1       ;
analysisSettings.deltaT        = .1      ;
```


### Output parameters
```
otherParams.plotsFormat = 'vtk' ;
otherParams.problemName = 'uniaxialExtension_Manual' ;
%~ printflag = 2 ;
```

```
[matUs, loadFactorsMat] = ONSAS( materials, elements, boundaryConds, initialConds, mesh, analysisSettings, otherParams ) ;
```


### Results

```math
\lambda(t) = \frac{1}{p} \frac{E}{2}  \left( \left( 1+\frac{u}{Lx} \right)^3 - \left( 1+ \frac{u}{Lx} \right) \right)
```
```

analyticCheckTolerance = 1e-6 ;
analyticFunc           = @(w) 1/p * E * 0.5 * ( (1 + w/Lx).^3 - (1+w/Lx) ) ;
disps = matUs(6*6+1,:) ;
analyticVals = analyticFunc(disps) ;
%
verifBoolean = ( norm( analyticVals - loadFactorsMat') / norm( analyticVals) ) < analyticCheckTolerance

```

### plot

```
lw = 2.0 ; ms = 11 ; plotfontsize = 22 ;
figure, hold on, grid on
plot( disps, loadFactorsMat, 'k-o' , 'linewidth', lw,'markersize',ms )
plot( disps, analyticVals, 'b-x' , 'linewidth', lw,'markersize',ms )
labx = xlabel('Displacement');   laby = ylabel('$\lambda$') ;
legend('Numeric','Analytic','location','North')
set(gca, 'linewidth', 1.2, 'fontsize', plotfontsize )
set(labx, 'FontSize', plotfontsize); set(laby, 'FontSize', plotfontsize) ;
print('output/verifUniaxial.png','-dpng')
```

```

return

% --------------------------------------------------------

clear iniMatUs


controlDispsValsCase1         = controlDisps  ;
loadFactorAnalyticalValsCase1 = analyticVals  ;
loadFactorNumericalValsCase1  = numericalVals ;

close all

% --------------------------------------------------------
% solid model using gmsh mesh, local tension load and complex step
% --------------------------------------------------------

problemName = 'uniaxialExtension_GMSH_ComplexStep' ;

[ Nodes, Conec ] = meshFileReader( 'geometry_uniaxialExtension.msh' ) ;

loadsParams{1,1}    = [ 0 1  0 0 0 0 p 0 ] ; % local coords appliend tension

elementsParams{2,1} = [ 4 1 ] ; % complex step constitutive tensor

plotParamsVector = [ 0 ] ;
analyticSolFlag        = 0 ;

% run ONSAS
ONSAS

controlDispsValsCase2         = controlDisps  ;
loadFactorNumericalValsCase2  = numericalVals ;


% --------------------------------------------------------
% truss element model
% --------------------------------------------------------

problemName = 'uniaxialExtension_truss' ;

Nodes = [ 0    0    0 ; ...
          Lx   0    0   ...
        ] ;

Conec = {[ 0 1 0 0 1   1   ] ; ... % fixed node
         [ 0 1 1 0 2   2   ] ; ... % loaded node
         [ 1 2 0 1 0   1 2 ]   ... % truss element
        } ;

% ======================================================================
% --- MELCS parameters ---

materialsParams = cell(1,1) ; % M
elementsParams  = cell(1,1) ; % E
loadsParams     = cell(1,1) ; % L
crossSecsParams = cell(1,1) ; % C
springsParams   = cell(1,1) ; % S

% --- Material parameters ---
E = 1 ; nu = 0.3 ;
materialsParams{1} = [ 0 2 E nu ] ;

% --- Element parameters ---
elementsParams = { 1  ; [ 2 0 ]} ;

% --- Load parameters ---
loadsParams{1,1} = [ 1 1  p 0 0 0 0 0 ] ;

% --- CrossSection parameters ---
crossSecsParams = { [ 2 Ly Lz] } ; %

% ----------------------------------------------------------------------
% --- springsAndSupports parameters ---
springsParams{1, 1} = [ inf 0  inf 0   inf 0 ] ;
springsParams{2, 1} = [ 0   0  inf 0   inf 0 ] ;

% ======================================================================

plotParamsVector       = [ 0 ] ;


controlDofs = [ 2 1 1 ] ;

%% run ONSAS
ONSAS

controlDispsValsCase3         = controlDisps  ;
%~ loadFactorNumericalValsCase3  = numericalVals .* (1+controlDisps) / Lx ;
loadFactorNumericalValsCase3  = numericalVals ;


% ----------------------------------------------------------------------
% --- plots ---
lw = 2.0 ; ms = 10 ; plotfontsize = 22 ;

figure, grid on, hold on

plot( controlDispsValsCase1, ...
      loadFactorAnalyticalValsCase1 ,'b-o' , 'linewidth', lw,'markersize',ms )

plot( controlDispsValsCase1, ...
      loadFactorNumericalValsCase1  ,'k-s' , 'linewidth', lw,'markersize',ms)

plot( controlDispsValsCase2, ...
      loadFactorNumericalValsCase2  ,'r-x' , 'linewidth', lw,'markersize',ms)

plot( controlDispsValsCase3, ...
      loadFactorNumericalValsCase3  ,'g--' , 'linewidth', lw,'markersize',ms)

labx = xlabel('Displacement');   laby = ylabel('$\lambda$') ;
legend('analytic Sol','numerical Sol 1','numerical Sol 2','numerical Sol 3','location','North')
set(gca, 'linewidth', 1.2, 'fontsize', plotfontsize )
set(labx, 'FontSize', plotfontsize); set(laby, 'FontSize', plotfontsize) ;
%~ print( [ 'plotsExtensionSVK' ] ,'-dpdflatex','-tight') ;
print( [ 'plotsExtensionSVK.png' ] ,'-dpng') ;

% ----------------------------------------------------------------------
