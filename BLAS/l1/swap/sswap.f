      SUBROUTINE SSWAP(N, SX, STEPX, SY, STEPY)
      REAL SX(*), SY(*)
      INTEGER N, STEPX, STEPY
      REAL buffer
      INTEGER i, m1, m2, xi, yi
      xi = 1
      yi = 1
      IF(N.LT.1) RETURN
      IF(STEPX.EQ.1 .AND. STEPY.EQ.1) THEN
            m1 = MOD(N,4)
            IF(m1.NE.0) THEN
                  DO i = 1, m1
                        buffer = SX(i)
                        SX(i) = SY(i)
                        SY(i) = buffer
                  END DO
                  IF(N.LT.4) RETURN
            END IF

            m2 = m1 + 1
            DO i = m2, N, 4
                  buffer = SX(i)
                  SX(i) = SY(i)
                  SY(i) = buffer
                  buffer = SX(i+1)
                  SX(i+1) = SY(i+1)
                  SY(i+1) = buffer
                  buffer = SX(i+2)
                  SX(i+2) = SY(i+2)
                  SY(i+2) = buffer
                  buffer = SX(i+3)
                  SX(i+3) = SY(i+3)
                  SY(i+3) = buffer
            END DO
      ELSE
            IF(STEPX.LT.1) xi = (-N + 1)*STEPX + 1
            IF(STEPY.LT.1) yi = (-N + 1)*STEPY + 1
            DO i = 1, N
                  buffer = SX(xi)
                  SX(xi) = SY(yi)
                  SY(yi) = buffer
                  xi = xi + STEPX
                  yi = yi + STEPY
            END DO
      END IF
      RETURN
      END

      PROGRAM TEST_SSWAP
      REAL SX(100000), SY(100000)
      INTEGER i, sanity
      sanity = 0
      DO i = 1, 100000
            SX(i) = 1.
            SY(i) = 0.
      END DO
      call SSWAP(100000, SX, 1, SY, 1)
      DO i = 1, 100000
            IF(SX(i).EQ.0.) sanity = sanity + 1
      END DO
      WRITE (*,*) "Should be 100000", sanity
      END