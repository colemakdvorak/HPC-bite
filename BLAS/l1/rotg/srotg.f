c     Slower, but numerically stable
      REAL FUNCTION HYP(SX,SY)
      IMPLICIT none
      REAL SX, SY
      REAL absx, absy, scale, grt, les
      absx = ABS(SX)
      absy = ABS(SY)
      les = MIN(absx, absy)
      grt = MAX(absx, absy)
      IF(grt.EQ.0.) THEN
            HYP = ABS(les)
      END IF
      scale = les / grt
      HYP = grt * SQRT(1 + scale * scale) 
      RETURN
      END

      SUBROUTINE SROTG(SX,SY,C,S)
      IMPLICIT none
c     input
      REAL C, S, SX, SY, HYP
c     local
      REAL r, roe, z
c     init
      z = 0.0      
      roe = SY
      IF (ABS(SX).GT.ABS(SY)) roe = SX
      IF (ABS(SX) + ABS(SY).EQ.0.0) THEN
            C = 1.0
            S = 0.0
            r = 0.0
      ELSE
            r = SIGN(1.0,roe) * HYP(SX,SY)
            C = SX/r
            S = SY/r
            z = 1.0
            IF (ABS(SX).GT.ABS(SY)) z = S
            IF (ABS(SY).GE.ABS(SX) .AND. C.NE.0.0) z = 1.0/C
      END IF
      SX = r
      SY = z
      RETURN
      END

      PROGRAM TEST_SROTG
      IMPLICIT none
      REAL X, Y, C, S, PI
      PI = 3.14159265359
      X = 1.
      Y = 1.
      C = 0.
      S = 0.
      call SROTG(X,Y,C,S)
      WRITE (*,*) X, "=", SQRT(2.), Y, "=", SQRT(2.), 
     &            C, "=", COS(PI/4), S, "=", COS(PI/4)
      END