      REAL * 8 FUNCTION DCABS1(Z)
      IMPLICIT none
      COMPLEX * 16 Z
      DCABS1 = ABS(DBLE(Z)) + ABS(DIMAG(Z))
      RETURN
      END

      PROGRAM TEST_DCABS1
      IMPLICIT none
      COMPLEX * 16 ZX(10000)
      REAL * 8 DY(10000), DCABS1
      INTEGER sanity, i
      sanity = 0
      DO i = 1, 10000
            ZX(i) = CMPLX(i*1.0d0,i*1.0d0)
            DY(i) = DCABS1(ZX(i))
            IF(DY(i) .EQ. 2*1.0d0*i) sanity = sanity + 1
      END DO
      WRITE(*, *) "Should be 10000", sanity
      END