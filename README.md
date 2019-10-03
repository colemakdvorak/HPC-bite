# HPC bite

Although wise elders advise me not to stare at languages on the lower side of the power spectrum for too long, I just find every level of programming abstraction fascinating - and strongly feel programs designed for numerically intensive tasks don't get exposed to people of my generation as much despite its deep origins and widespread use. Since I have free time at hand, I decided to take time to implement some numerical tricks I learned during education in Fortran.

Hence this repo has no practical value, it's mostly for learning, reviewing, and entertainment. I just want to appreciate things like BLAS/LAPACK hidden behind numpy, or any libraries/languages that serves as an interface between these programs and users.


## Thoughts on Fortran 77 so far

After a week of using my free time on Fortran 77, here are some features I miss from powerful modern languages:

1) Generics: I am primarily dealing with REAL type for now but lot of level 1 subroutines in BLAS are identical except for the type of input. Trying to rewrite the same thing for different type is prone to human errors and difficult if done manually.

2) Modules: I haven't figured out a way to properly organize separate subroutines and making them available in modular manner.

3) Asserts: Testing code feels hacky and weird without them.



Some things I noticed are missing, but aren't killing me.

1) Recursion: I've learned that there's a way to hack recursion by adding an argument that represents a subroutine to a subroutine, and then make the subroutine invoke itself by passing itself as an argument. However, scope of most primitive numerical operations are well-defined and iterative, so there weren't a lot of "only if I had recursion" moments.


## BLAS
Mostly done with level 1.

#### Level 1
[?ASUM](BLAS/l1/asum): 2019/09/26 Implemented for single precision float vector and wrote a short journal.

[?AXPY](BLAS/l1/axpy): 2019/10/02 Implented for single precision.

[?COPY](BLAS/l1/copy): 2019/10/02 Implented for single precision.

[?DCABS1](BLAS/l1/dcabs1): 2019/10/02 Implented for single precision.

[?DOT](BLAS/l1/dot): 2019/10/02 Implented for single precision.

[?IMAX](BLAS/l1/imax): 2019/10/02 Implented for single precision.

[?IMIN](BLAS/l1/imin): 2019/10/02 Implented for single precision.

[?NRM2](BLAS/l1/nrm2): 2019/10/02 Implented for single precision.

[?ROT](BLAS/l1/rot): 2019/10/02 Implented for single precision.

[?ROTG](BLAS/l1/rotg): 2019/10/02 Added note on `HYPOT` and leaky abstractions.

[?SCAL](BLAS/l1/scal): 2019/10/02 Implented for single precision.

[?SWAP](BLAS/l1/swap): 2019/10/02 Implented for single precision.

## References

[Fortran 77 Stanford Tutorial](https://web.stanford.edu/class/me200c/tutorial_77/)

[Intel Math Kernel documentation on BLAS](https://software.intel.com/en-us/mkl-developer-reference-fortran-overview)