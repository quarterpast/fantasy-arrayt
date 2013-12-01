Identity = require \fantasy-identities
{should, describe} = require \aver
ArrayT = require \./
ArrayIdentity = ArrayT Identity
require! assert


describe "ArrayT" ->
	should "be a monad" ->
		"of" `should` ->
			ArrayIdentity.of 5 .run.x `assert` 5
		"chain" `should` ->
			ArrayIdentity.of 5 .chain (n)->
				ArrayIdentity.of 5 + n
			.run.x `assert` 10
	should "be a functor" ->
		ArrayIdentity.of 5 .map (+ 5)
		.run.x `assert` 10
	should "be an applicative functor" ->
		ArrayIdentity.of (+ 5) .ap ArrayIdentity.of 5
		.run.x `assert` 10
	should "be a monoid" ->
		"concat" `should` ->
			(ArrayIdentity.of 5) ++ (ArrayIdentity.of 5)
			.run.x `assert` [5 5]
		"empty" `should` ->
			ArrayIdentity.empty!.run.x `assert` void