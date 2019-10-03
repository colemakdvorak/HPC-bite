      SUBROUTINE SROT(N, SX, STEPX, SY, STEPY, C, S)
      IMPLICIT none
c     arg
      REAL C, S, SX(*), SY(*)
      INTEGER STEPX, STEPY, N
c     local
      REAL buffer
      INTEGER i, x_i, y_i
c
      IF(N.LE.0) RETURN
      IF(STEPX.EQ.1 .AND. STEPY.EQ.1) THEN
            DO i = 1, N
                  buffer = C*SX(i) + S*SY(i)
                  SY(i) = C*SY(i) - S*SX(i)
                  SX(i) = buffer
            END DO
      ELSE
            x_i = 1
            y_i = 1
            IF (STEPX.LT.0) x_i = (-N+1)*STEPX + 1
            IF (STEPY.LT.0) y_i = (-N+1)*STEPY + 1
            DO i = 1, N
                  buffer = C*SX(x_i) + S*SY(y_i)
                  SY(x_i) = C*SY(y_i) - S*SX(x_i)
                  SX(y_i) = buffer
                  x_i = x_i + STEPX
                  y_i = y_i + STEPY
            END DO

      END IF
      END
c
      PROGRAM TEST_SROT
      IMPLICIT none
      REAL SX(10000), SY(10000)
      INTEGER i, sanity
      sanity = 0
      DO i = 1, 10000
            IF (MOD(i,2) .EQ. 1) THEN
                  SX(i) = 1. * i
            ELSE
                  SY(i) = 1. * i
            END IF
      END DO
      call SROT(10000, SX, 1, SY, 1, 0., 1.)
      DO i = 1, 10000
            IF (MOD(i,2) .EQ. 1) THEN
                  IF(SY(i) + 1.*i .EQ. 0.) THEN
                        sanity = sanity + 1
                  END IF
            ELSE
                  IF(SX(i) - 1.*i .EQ. 0.) THEN
                        sanity = sanity + 1
                  END IF
            END IF
      END DO
      WRITE (*,*) "Should be 10000" , sanity
      END