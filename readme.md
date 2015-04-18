fantasy-arrayt
============

Monad transformer for Javascript arrays

```
npm install fantasy-arrayt
```

[![fantasy land compatible](https://github.com/fantasyland/fantasy-land/raw/master/logo.png)](https://github.com/fantasyland/fantasy-land)

Usage
-----

```livescript
Promise = require \fantasy-promises
ArrayT = require \fantasy-arrayt

ArrayPromise = ArrayT Promise
a = new ArrayPromise new Promise (resolve)->
	set-timeout resolve, 3000, [1 to 10]

a.map (* 5) .chain -> ArrayPromise Promise.of [it, -it]
.run.fork console.log # here be side-effects
# 3 seconds later...
#=> 5, -5, 10, -10, 15, -15,...
```

API
---
### ArrayT
```haskell
type ArrayT m a = { run :: m [a] }
```

``Monad m => ArrayT m`` creates a monad encapsulating a list wrapped with the monad ``m``.

- ``map :: ArrayT m a → (a → b) → ArrayT m b``
- ``chain :: ArrayT m a → (a → ArrayT m b) → ArrayT m b``
- ``of :: a → ArrayT m a``
- ``ap :: ArrayT m (a → b) → ArrayT m a → ArrayT m b``
- ``concat :: ArrayT m a → ArrayT m a → ArrayT m a``
- ``empty :: → ArrayT m a``
- ``reduce :: ArrayT m b → (a → b → a) → a → m b``
- ``reduceRight :: ArrayT m b → (a → b → a) → a → m b``
- ``take :: ArrayT m a → Integer → ArrayT m a``
- ``take :: ArrayT m a → Integer → ArrayT m a``
- ``drop :: ArrayT m a → Integer → ArrayT m a``
- ``tail :: ArrayT m a → ArrayT m a``
- ``head :: ArrayT m a → m a``
- ``initial :: ArrayT m a → ArrayT m a``
- ``last :: ArrayT m a → m a``
- ``reverse :: ArrayT m a → ArrayT m a``
- ``len :: ArrayT m a → m Integer``
- ``filter :: ArrayT m a → (a → Boolean) → ArrayT m a``
- ``reject :: ArrayT m a → (a → Boolean) → ArrayT m a``
- ``find :: ArrayT m a → (a → Boolean) → m a``
- ``mkString :: ArrayT m Stringable → m String`` (yay duck typing)
- ``every :: ArrayT m a → (a → Boolean) → m Boolean``
- ``some :: ArrayT m a → (a → Boolean) → m Boolean``
 
Licence
-------
[MIT](/licence.md). &copy; 2013 Matt Brennan.
