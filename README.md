# mpi4py_example
Brief example of a Python application that uses mpi4py.

The fortran file must be compiled using F2PY:
`f2py -c -m read_and_integrate read_and_integrate.f90`

The Python script also relies on a file made out of float numbers of shape = (n_elem, 11). Change the file name and the n_elem variable to fit your needs.
