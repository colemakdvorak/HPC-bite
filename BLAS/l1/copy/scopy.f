      SUBROUTINE SCOPY(N, SX, STEPX, SY, STEPY)
      IMPLICIT none
      INTEGER STEPX, STEPY, N
      REAL SX(*), SY(*)
      INTEGER i, x_i, y_i, m1, mp2
      x_i = 1
      y_i = 1
      IF (N.LE.0) RETURN
      IF (STEPX.EQ.1 .AND. STEPY.EQ.1) THEN
            m1 = MOD(N,7)
            IF (m1.NE.0) THEN
                  DO i = 1,m1
                        SY(i) = SX(i)
                  END DO
                  IF (N.LT.7) RETURN
            END IF
            mp2 = m1 + 1
            DO i = mp2,N,7
                  SY(i) = SX(i)
                  SY(i+1) = SX(i+1)
                  SY(i+2) = SX(i+2)
                  SY(i+3) = SX(i+3)
                  SY(i+4) = SX(i+4)
                  SY(i+5) = SX(i+5)
                  SY(i+6) = SX(i+6)
            END DO
      ELSE
            IF (STEPX.LT.0) x_i = (-N+1)*STEPX + 1
            IF (STEPY.LT.0) y_i = (-N+1)*STEPY + 1
            DO i = 1,N
                  SY(y_i) = SX(x_i)
                  x_i = x_i + STEPX
                  y_i = y_i + STEPY
            END DO
      END IF
      RETURN
      END
c
      PROGRAM TEST_SCOPY
      IMPLICIT none
      REAL SX(1000), SY(1000)
      INTEGER sanity, i
      sanity = 0
      DO i = 1, 1000
            SX(i) = 1.
      END DO
      call SCOPY(1000, SX, 1, SY, 1)
      DO i = 1, 1000
            IF(SX(i).EQ.SY(i)) THEN
                  sanity = sanity + 1
            END IF
      END DO
      WRITE (*,*) "Should be 1000, ", sanity
      END