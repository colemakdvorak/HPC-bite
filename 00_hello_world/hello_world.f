c	Hello world program for fortran 77.	
      PROGRAM HELLO_WORLD
            IMPLICIT none
            CHARACTER * 10 name
            CHARACTER (len = 10) :: first, last
            INTEGER int1
            int1 = 10
            PRINT *, "Who are you and what's your favorite number"
            int1 = int1 + 1
            READ *, first, last, int1
            PRINT *, "Hello ", TRIM(first), " ", TRIM(last), int1
      END PROGRAM HELLO_WORLD