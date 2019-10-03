      SUBROUTINE SAXPY(N, SA, SX, STEPX, SY, STEPY)
      IMPLICIT none
c
      REAL SX(*), SY(*), SA
      INTEGER N, STEPX, STEPY
c
      INTEGER i, x_i, y_i, m1, m2

      x_i = 1
      y_i = 1

      IF((N.LE.0) .OR. (SA.EQ.0)) RETURN

      IF((STEPX.EQ.1) .AND. (STEPY.EQ.1)) THEN
            m1 = MOD(N, 4)
            IF(m1.NE.0) THEN
                  DO i = 1, m1
                        SY(i) = SY(i) + SA*SX(i)
                  END DO
            END IF
            IF(N.LT.4) RETURN
            m2 = m1 + 1
            DO i = m2, N, 4
                  SY(i) = SY(i) + SA*SX(i)
                  SY(i+1) = SY(i+1) + SA*SX(i+1)
                  SY(i+2) = SY(i+2) + SA*SX(i+2)
                  SY(i+3) = SY(i+3) + SA*SX(i+3)
            END DO
      ELSE
            DO i = 1, N
                  SY(y_i) = SY(y_i) + SA*SX(x_i)
                  x_i = x_i + STEPX
                  y_i = y_i + STEPY
            END DO
      END IF
      RETURN
      END

      PROGRAM TEST_SAXPY
      IMPLICIT none
      REAL X(10000), BOUND, NEG_BOUND
      INTEGER i, sanity
      PARAMETER (BOUND=10.**(-7), NEG_BOUND=-1.*10.**(-7))

      sanity = 0

      DO i = 1,10000
            X(i) = 1.
      END DO
      call SAXPY(10000, -1., X, 1, X, 1)
      DO i = 1,10000
            IF(X(i) .LT. BOUND .AND. X(i) .GT. NEG_BOUND) THEN
                  sanity = sanity + 1
            END IF
      END DO
      WRITE (*,*) "This should be 10000, ", sanity
      END