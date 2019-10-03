      REAL FUNCTION SDOT(N, SX, STEPX, SY, STEPY)
      IMPLICIT none
c     Arguments
      INTEGER STEPX, STEPY, N
      REAL SX(*),SY(*)
c     Local
      REAL buffer
      INTEGER i, x_i, y_i, m1, m2
c     Initialization
      buffer = 0.
      SDOT = 0.
      x_i = 1
      y_i = 1
c     Loop unrolling check
      IF (N.LE.0) RETURN
      IF (STEPX.EQ.1 .AND. STEPY.EQ.1) THEN
            m1 = MOD(N,4)
            IF (m1.NE.0) THEN
                  DO i = 1,m1
                        buffer = buffer + SX(i)*SY(i)
                  END DO
                  IF (N.LT.4) THEN
                        SDOT=buffer
                        RETURN
                  END IF
            END IF
      m2 = m1 + 1
      DO i = m2,N,4
            buffer = buffer + SX(i)*SY(i) + SX(i+1)*SY(i+1) 
     $                  + SX(i+2)*SY(i+2) + SX(i+3)*SY(i+3)
      END DO
      ELSE
            IF (STEPX.LT.0) x_i = (-N+1)*STEPX + 1
            IF (STEPY.LT.0) y_i = (-N+1)*STEPY + 1
            DO i = 1,N
                  buffer = buffer + SX(x_i)*SY(y_i)
                  x_i = x_i + STEPX
                  y_i = y_i + STEPY
            END DO
      END IF
      SDOT = buffer
      RETURN
      END
c
      PROGRAM TEST_SDOT
      IMPLICIT none
      REAL X(10000), SDOT
      INTEGER i
      DO i = 1, 10000
            X(i) = 1.
      END DO
      WRITE (*,*) "Should be 0.0", SDOT(10000, X, 1, X, 1) - 10000.
      END