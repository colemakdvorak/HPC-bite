      INTEGER FUNCTION ISAMIN(N, SX, STEPX)
      IMPLICIT none
      REAL SX(*)
      INTEGER N, STEPX
      REAL minv
      INTEGER i, xi
      ISAMIN = 0
      xi = 1 + STEPX
      IF (N.LT.1) RETURN
      ISAMIN = 1
      IF (N.EQ.1) RETURN
      IF (STEPX.EQ.1) THEN
         minv = ABS(SX(1))
         DO i = 2,N
            IF (ABS(SX(i)).LT.minv) THEN
               ISAMIN = i
               minv = ABS(SX(i))
            END IF
         END DO
      ELSE
         minv = ABS(SX(1))
         DO i = 2,N
            IF (ABS(SX(xi)).LT.minv) THEN
               ISAMIN = i
               minv = ABS(SX(xi))
            END IF
            xi = xi + STEPX
         END DO
      END IF
      RETURN
      END

      PROGRAM TEST_ISAMIN
      IMPLICIT none
      REAL SX(1000000)
      INTEGER i, ans, testans, ISAMIN
      testans = 123456
      DO i = 1, testans - 1
            SX(i) = 1.
      END DO
      SX(testans) = 0.
      DO i = testans + 1, 1000000
            SX(i) = 1.
      END DO
      WRITE (*,*) SX(1)
      ans = ISAMIN(1000000, SX, 1)
      WRITE (*,*) "Should be the two same numbers ", ans, testans
      END