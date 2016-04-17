import numpy as np
# Import the Fortran subroutine:
import read_and_integrate as it
# Import the MPI library:
from mpi4py import MPI

f_name = "outputflux875" # Name of file
n_elem = 1048992 # Number of lines in file
# the data in this file has a shape of (n_elem,11)
# where column 0: x, column 1-10: y1, y2, y3...
# the code will integrate y<<rank>> as function of x

# Usual communicator, rank and size initialization
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

# the master (rank = 0) process reads the data
if rank == 0:
    data  = it.readfile(f_name,n_elem) # Fortran call to read the file
    # data in this case has a shape of (n_elem, 11)
    x = data[:,0] # Select the x-axis data for the integration
    y = data[:,1] # Select the y-axis data for rank=0
    for i in range(1,size): comm.Send([data[:,i+1], MPI.DOUBLE], dest=i, tag=i*11)
else:
    # initialize x and y for every other rank
    x = np.empty(n_elem,dtype=np.float64)
    y = np.empty(n_elem,dtype=np.float64)
    # recieve the y data specific to the each rank
    comm.Recv([y, MPI.DOUBLE], source=0, tag=rank*11) 

# we also ask the rank=0 process to broadcast the x variable
# to everyone
comm.Bcast([x, MPI.DOUBLE], root=0)

# now each processor has x and its own y to calculate the area:
area = it.calcarea(x,y,n_elem)

# print the results
print "rank",rank,"area:", area

