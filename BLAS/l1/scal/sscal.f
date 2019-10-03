      SUBROUTINE SSCAL(N, SA, SX, STEPX)
      IMPLICIT none
      REAL SA, SX(*)
      INTEGER N, STEPX
      INTEGER i, m1, m2, nstepx
      IF(N.LE.0) RETURN
      IF(STEPX.EQ.1) THEN
            m1 = MOD(N, 4)
            IF(m1.NE.0) THEN
                  DO i = 1, m1
                        SX(i) = SA * SX(i)
                  END DO
            END IF
            IF(N.LT.4) RETURN
            m2 = m1 + 1
            DO i = m2, N, 4
                  SX(i) = SA * SX(i)
                  SX(i+1) = SA * SX(i+1)
                  SX(i+2) = SA * SX(i+2)
                  SX(i+3) = SA * SX(i+3)
            END DO
      ELSE
            nstepx = N*STEPX
            DO i = 1, N, nstepx
                  SX(i) = SA * SX(i)
            END DO
      END IF
      RETURN
      END

      PROGRAM TEST_SSCAL
      IMPLICIT none
      REAL SA, SX(10 ** 5)
      INTEGER i, sanity
      SA = 0.5
      sanity = 0
      DO i = 1, 10 ** 5
            SX(i) = 2.
      END DO
      call SSCAL(10 ** 5, SA, SX, 1)
      DO i = 1, 10 ** 5
            IF(SX(i).EQ.1.) sanity = sanity + 1
      END DO
      WRITE (*,*) "This should be 100000", sanity
      END