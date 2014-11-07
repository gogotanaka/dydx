# This gem is obsolete. See [Hilbert](https://github.com/gogotanaka/Hilbert)

### Since you report a bug, I will fix it within 24 hours.

[![Build Status](https://travis-ci.org/gogotanaka/dydx.svg?branch=master)](https://travis-ci.org/gogotanaka/dydx)

Q makes it possible to enjoy mathematics on PC without losing the feeling that you can get from using Pen and Paper.

ex. limit, trigonometric functions and logarithmic.

## We can enjoy mathematics even using PC.
(to say nothing of using pen.)

After `inlcude Dydx` , ruby become like other language.

## Outline
```ruby:
require 'dydx'
include Dydx

# Define the function. syntax is not good enough...
f(x, y) <= x + x*y + y

# simplify
f(x, y) == x * (1 + y) + y
=> true

#part substitution
f(a, 2) == 3*a + 2
=> true

f(1, a + b) == 1 + 2 * ( a + b )
=> true


# Differentiate
d/dx(f(x, y)) == 1 + y
=> true

g(x) <= sin(x)

d/dx(g(x)) == cos(x)

# Integrate
S(g(x), dx)[0, pi/2]
=> 1.0
```


#### limit, trigonometric functions and logarithmic.
```ruby:

f(z) <= log(z)
S(f(z), dz)[0,1]
=> -Infinity

d/dx(log(x)) == 1 / x
=> true

d/dx(cos(x)) == -cos(x)
=> true

d/dx(e ** x) == e ** x
=> true

# standard normal distribution;
f(x) <= (1.0 / ( 2.0 * pi ) ** 0.5) * e ** (- x ** 2 / 2)
S(f(x), dx)[-oo, oo]
=> 1.0
```

## Documents
I'm going to write now...cominng soon....

### Module, class configuration

```
Dydx
  |- Algebra
  |      |- Operator
  |      |   |- Interface
  |      |   |- ....
  |      |
  |      |- Set
  |      |- Formula
  |      |- inverse
  |
  |- Function
  |- Delta
  |- Integrand
```


## Test

run `bundle exec rake spec`

```
Finished in 3.76 seconds
325 examples, 0 failures
```
