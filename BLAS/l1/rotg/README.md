## ?ROTG

[Givens rotation](https://en.wikipedia.org/wiki/Givens_rotation) method. 

## Notes on HYPOT/HYP

Most standard math libraries for modern languages have [`HYPOT` method](https://en.wikipedia.org/wiki/Hypot) implemented to compute the length of line from the origin to (x,y). I have small confession to make, sometimes I don't dig through the standard math library for this type of simple operation and get things done quick and dirty, and I haven't thought about the possible over/underflow issues for this particular case.

Moral of the story is - use the standard library even for trivial operations if possible. In real life, I saw lot of people trying to manually compute cross entropy instead of provided implementations in TensorFlow and run into NaN and Inf outputs. People panic for a moment until they realize they haven't handled the discontinuity correctly. However, that doesn't mean we "shouldn't care" and only use things that are given, I believe there's a lot of value in knowing what "should" be going on under the surface. It allows one to catch leaky abstractions by validating the standard implementation. Good luck on your dive to sea of abstraction.