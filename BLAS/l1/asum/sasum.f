c
c     Absolute sum of a float array.
c     
c
      REAL FUNCTION SASUM(N, SX, STEP)
c     input variables
      INTEGER N, STEP
      REAL SX(*)
c     local variables
      INTEGER i, mod1, mod2, nstep
      REAL partial
c     initialization
      SASUM = 0.
      partial = 0.
c
      IF(N.LE.0 .OR. STEP.LE.0) RETURN
c      
      IF(STEP.EQ.1) THEN
            mod1 = MOD(N, 6)
            IF (mod1.NE.0) THEN
                  DO i = 1, mod1
                        partial = partial + ABS(SX(i))
                  END DO
                  IF(N.LT.6) THEN
                        SASUM = partial
                        RETURN
                  END IF
            END IF
c
            mod2 = mod1 + 1
            DO i = mod2, N, 6
                  partial = partial
     $                  + ABS(SX(i)) + ABS(SX(i+1)) + ABS(SX(i+2))
     $                  + ABS(SX(i+3)) + ABS(SX(i+4)) + ABS(SX(i+5))
            END DO
      ELSE
            nstep = N*step
            DO i = 1, nstep, step
                  partial = partial + ABS(SX(i))
            END DO
      END IF
      SASUM = partial
      RETURN
      END
c
c     Same function but with no loop unrolling implemented
c
      REAL FUNCTION SASUM_NU(N, SX, STEP)
c     input variables
      INTEGER N, STEP
      REAL SX(*)
c     local variables
      INTEGER i
      REAL partial
c
      partial = 0.
      DO i = 1, N, STEP
            partial = partial + ABS(SX(i))
      END DO
c
      SASUM_NU = partial
      RETURN
      END
c
c     Test program
c     Approximates PI by taking N partial sum from BBP.
c     Approximation occurs twice, on
c
      PROGRAM TEST_SASUM
c
      IMPLICIT none
      REAL a(10**7), ans, PI, SASUM, SASUM_NU, BOUND, T1, T2
      INTEGER i, N
      LOGICAL test
      PARAMETER (PI = 3.14159, BOUND=10.**(-5), N = 10**7)
c     Fill array with BBP terms
      DO i = 0, N-1
            a(i+1) = ((1.0/16)**i) *
     $      (4./(8*i + 1) - 2./(8*i + 4) - 1./(8*i + 5) - 1./(8*i + 6))
      END DO
c
      call cpu_time(T1)
      ans = SASUM(N, a, 1)
      call cpu_time(T2)
c
      test = (ans - pi) .LT. BOUND
      WRITE (*,*) "Did we pass the test? ", test
      WRITE (*,*) "How long did it take? ", T2 - T1
c
      call cpu_time(T1)
      ans = SASUM_NU(N, a, 1)
      call cpu_time(T2)
c
      test = (ans - pi) .LT. BOUND
      WRITE (*,*) "No unrolling: Did we pass the test? ", test
      WRITE (*,*) "No unrolling: How long did it take? ", T2 - T1
      END