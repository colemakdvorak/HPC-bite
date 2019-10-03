      REAL FUNCTION SNRM2(N,SX,STEPX)
      IMPLICIT none
c     Arg var
      INTEGER STEPX,N
      REAL SX(*)
c     Local var
      REAL absx,norm,scale,sum
      INTEGER i
c     Edge case handling
      IF (N.LT.1 .OR. STEPX.LT.1) THEN
          SNRM2 = 0.
          RETURN
      END IF
      IF (N.EQ.1) THEN
          SNRM2 = ABS(SX(1))
          RETURN
      END IF
c     Scale sum for stability
      scale = 0.
      sum = 1.
      DO i = 1, 1 + (N-1)*STEPX, STEPX
            IF (SX(i).NE.0.) THEN
                  absx = ABS(SX(i))
                  IF (scale.LT.absx) THEN
                        sum = 1. + sum* (scale/absx)**2
                        scale = absx
                  ELSE
                        sum = sum + (absx/scale)**2
                  END IF
            END IF
      END DO
      SNRM2 = scale*SQRT(sum)
      RETURN
      END

      PROGRAM TEST_SNRM2
      IMPLICIT none
      REAL SX(100), SNRM2
      INTEGER i
      DO i = 1, 100
            SX(i) = 1.
      END DO
      WRITE (*,*) "About 10.0", SNRM2(100, SX, 1)
      END