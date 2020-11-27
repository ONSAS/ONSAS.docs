# ONSAS: an Open Nonlinear Structural Analysis Solver

[![Join the chat at https://gitter.im/onsas_/community](https://badges.gitter.im/onsas_/community.svg)](https://gitter.im/onsas_/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## What is ONSAS?

[ONSAS](https://github.com/ONSAS/ONSAS) is a [GNU-Octave](https://www.gnu.org/software/octave/) code for static/dynamic and linear/non-linear analysis of structures. The first version was developed for educational purposes and was published in a [handbook](https://www.colibri.udelar.edu.uy/jspui/bitstream/20.500.12008/22106/1/Bazzano_P%c3%a9rezZerpa_Introducci%c3%b3n_al_An%c3%a1lisis_No_Lineal_de_Estructuras_2017.pdf) of the course _Análisis no lineal de Estructuras_ taught at [Facultad de Ingeniería](https://www.fing.edu.uy/), Universidad de la República, Uruguay.

## What can ONSAS be used for?

The current version allows to perform dynamic/static nonlinear analyses of beam/truss/solid 3D structures. A reduced list of features is listed at next:

* **Elements** 2-node truss, 2-node Bernoulli frame, 4-node tetrahedron.
* **Static analysis methods** Newton-Raphson Method and Cylindrical Arc-Length Method.
* **Dynamic analysis methods** Newmark Method.
* **Loads** nodal loads, time-history user-defined loading program.

## Some examples	

# A wind turbine model	
![wind](https://github.com/ONSAS/ONSAS/blob/master/examples/wind.gif?raw=true)	

# A tower model	
![tower](https://github.com/ONSAS/ONSAS/blob/master/examples/tower.gif?raw=true)	

# A chain model	
![chain](https://user-images.githubusercontent.com/42485529/90902313-a6bf8d80-e3a2-11ea-8369-a9be639552f9.gif?raw=true)

## How to use ONSAS

The user should follow these steps to install and run ONSAS:

1. Download and install [GNU-Octave](https://www.gnu.org/software/octave/)
1. Download the ONSAS source files https://github.com/onsas/onsas/archive/v0.1.9.zip
1. Open GNU-Octave and run the _ONSAS.m_ script
1. Select one of the available input files (or create one).

## Contributors and License

The code is distributed under a GNU-GPL 3.0 license.

See the full list of contributors and their affiliations in the [Authors](@ref) section.
