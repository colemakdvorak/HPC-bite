      INTEGER FUNCTION ISAMAX(N, SX, STEPX)
      IMPLICIT none
      REAL SX(*)
      INTEGER N, STEPX
      REAL maxv
      INTEGER i, xi
      ISAMAX = 0
      xi = 1 + STEPX
      IF (N.LT.1) RETURN
      ISAMAX = 1
      IF (N.EQ.1) RETURN
      IF (STEPX.EQ.1) THEN
         maxv = ABS(SX(1))
         DO i = 2,N
            IF (ABS(SX(i)).GT.maxv) THEN
               ISAMAX = i
               maxv = ABS(SX(i))
            END IF
         END DO
      ELSE
         maxv = ABS(SX(1))
         DO i = 2,N
            IF (ABS(SX(xi)).GT.maxv) THEN
               ISAMAX = i
               maxv = ABS(SX(xi))
            END IF
            xi = xi + STEPX
         END DO
      END IF
      RETURN
      END

      PROGRAM TEST_ISAMAX
      IMPLICIT none
      REAL SX(1000000)
      INTEGER i, ans, testans, ISAMAX
      testans = 123456
      DO i = 1, i - 1
            SX(i) = 1.
      END DO
      SX(testans) = 1.1 
      DO i = testans + 1, 1000000
            SX(i) = 1.
      END DO
      ans = ISAMAX(1000000, SX, 1)
      WRITE (*,*) "Should be the two same numbers ", ans, testans
      END