## ?ASUM

Absolute sum operation. Basically adds the absolute value of all entries in a vector.

## Notes: Readability vs Performance

Studying the old implementations (looking through code written back in 70-80s), I came across the classic trick of loop unrolling. [This](http://www.netlib.org/utk/people/JackDongarra/PAPERS/001_1979_unrolling-loops-in-fortran.pdf) is a 1979 paper that goes over the technique and its empirical results back then.

In most workplaces nowadays, if anyone tries to push this kind of code to the code base... Enough said. This kind of technique makes sense if one considers the behavior of assembly/CPU. Technically, every iteration of a for loop does a check, which isn't free, so let's expand it a little bit to do less checks - is the underlying idea. It probably comes off as something trivial among those who recognize it, but it would confuse those who are unfamiliar. However, the performance gain seems pretty large so adding few lines of code seems like a sweet deal.

I thought that a modern compiler would probably figure these kind of things out adaptively. So I wrote a naive implementation without unrolling to see how much optimization the compiler can do.

Well, here are the results.

Default flag
```
[dvorak@qwerty asum]$ gfortran sasum.f
[dvorak@qwerty asum]$ ./a.out 
 Did we pass the test?  T
 How long did it take?    1.38139725E-02
 No unrolling: Did we pass the test?  T
 No unrolling: How long did it take?    2.52139568E-02
```


`O3` flag
```
[dvorak@qwerty asum]$ gfortran -O3 sasum.f
[dvorak@qwerty asum]$ ./a.out 
 Did we pass the test?  T
 How long did it take?    1.08239651E-02
 No unrolling: Did we pass the test?  T
 No unrolling: How long did it take?    1.09640360E-02

```

`Ofast` flag
```
[dvorak@qwerty asum]$ gfortran -Ofast sasum.f
[dvorak@qwerty asum]$ ./a.out 
 Did we pass the test?  T
 How long did it take?    3.86101007E-03
 No unrolling: Did we pass the test?  T
 No unrolling: How long did it take?    2.84999609E-03
```

This is not a rigorous check by any means, and these kind of things depend a lot on the context. Modern compilers seem to be pretty pro at intelligently unrolling loops. So it looks like we can code in peace in most environments. Even [Intel advises people to not manually unroll loops](https://software.intel.com/en-us/articles/avoid-manual-loop-unrolling). At the end of the day, even the optimal unrolling depth is hardware dependent.