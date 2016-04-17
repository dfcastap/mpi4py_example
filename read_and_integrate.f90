!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1!!!!!!!!

subroutine readfile(flux,fname,nwav)

        implicit none
        !Pythonic array indices ahead, from 0 to n-1.
        integer (kind=4), intent(in) :: nwav
        integer (kind=4) :: j,k
        real (kind=8), dimension(0:nwav-1,0:10), intent(out) :: flux
        !f2py depend(nwav) flux
        character (len=40), intent(in) :: fname

        open(unit=7,file=fname,status="OLD")
        do j = 0, nwav-1
            read(7,*) (flux(j,k),k=0,10)
        enddo
        close(7)
        
        return

end subroutine  ! readfile

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1!!!!1!!1!!!!!1!!!!!!!!!!!!!!!!!

subroutine calcarea(area,x,y,nwav)

        implicit none
        !Pythonic array indices ahead, from 0 to n-1.
        integer (kind=4), intent(in) :: nwav
        integer (kind=4) :: i
        real (kind=8), dimension(0:nwav-1), intent(in):: x,y
        !f2py depend(nwav) x,y
        
        real (kind=8),intent(out) :: area
        real (kind=8) :: tmp

        
        area = 0
        tmp = 0
        do i = 0, nwav-2
            tmp = (x(i+1)-x(i))*((y(i+1)+y(i))/2)
            area = area + tmp
        enddo

        return

end subroutine  ! calcarea
