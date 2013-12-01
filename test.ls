Identity = require \fantasy-identities
{should, describe} = require \aver
ArrayT = require \./
ArrayIdentity = ArrayT Identity
require! assert


describe "ArrayT" ->
	should "be a monad" ->
		"of" `should` ->
			ArrayIdentity.of 5 .run.x `assert.equal` 5
		"chain" `should` ->
			ArrayIdentity.of 5 .chain (n)->
				ArrayIdentity.of 5 + n
			.run.x `assert.equal` 10
	should "be a functor" ->
		ArrayIdentity.of 5 .map (+ 5)
		.run.x `assert.equal` 10
	should "be an applicative functor" ->
		ArrayIdentity.of (+ 5) .ap ArrayIdentity.of 5
		.run.x `assert.equal` 10
	should "be a monoid" ->
		"concat" `should` ->
			(ArrayIdentity.of 5) ++ (ArrayIdentity.of 5)
			.run.x `assert.equal` [5 5]
		"empty" `should` ->
			ArrayIdentity.empty!.run.x `assert.equal` void

	should "have some array methods" ->
		"reduce" `should` ->
			ArrayIdentity Identity.of [1 to 10] .reduce (+),0
			.x `assert.equal` 55
		"reduce-right" `should` ->
			ArrayIdentity Identity.of ['a' to 'e'] .reduce-right (+)
			.x `assert.equal` 'edcba'
		"take" `should` ->
			ArrayIdentity Identity.of [1 to 10] .take 5
			.run.x `assert.equal` [1 to 5]
		"drop" `should` ->
			ArrayIdentity Identity.of [1 to 10] .drop 5
			.run.x `assert.equal` [6 to 10]
		"tail" `should` ->
			ArrayIdentity Identity.of [1 to 10] .tail!
			.run.x `assert.equal` [2 to 10]
		"head" `should` ->
			ArrayIdentity Identity.of [1 to 10] .head!
			.x `assert.equal` 1
		"initial" `should` ->
			ArrayIdentity Identity.of [1 to 10] .initial!
			.run.x `assert.equal` [1 to 9]
		"last" `should` ->
			ArrayIdentity Identity.of [1 to 10] .last!
			.x `assert.equal` 10

		even = (% 2 is 0)
		"filter" `should` ->
			ArrayIdentity Identity.of [1 to 10] .filter even
			.run.x `assert.equal` [2 4 6 8 10]
		"reject" `should` ->
			ArrayIdentity Identity.of [1 to 10] .reject even
			.run.x `assert.equal` [1 3 5 7 9]
		"find" `should` ->
			console.log <| ArrayIdentity Identity.of [1 to 10] .filter even .run.x
			#.x `assert.equal` 2
		"mkString" `should` ->
			ArrayIdentity Identity.of ['a' to 'e'] .mk-string!
			.x `assert.equal` 'abcde'
			ArrayIdentity Identity.of ['a' to 'e'] .mk-string ' '
			.x `assert.equal` 'a b c d e'
		"every" `should` ->
			ArrayIdentity Identity.of [1 to 10] .every even
			.x `assert.equal` false
			ArrayIdentity Identity.of [2 4 6 8] .every even
			.x `assert.equal` true
		"some" `should` ->
			ArrayIdentity Identity.of [1 to 10] .some even
			.x `assert.equal` true
			ArrayIdentity Identity.of [1 3 5 7 9] .some even
			.x `assert.equal` false
		"len" `should` ->
			ArrayIdentity Identity.of [1 to 10] .len!.x `assert.equal` 10
		"reverse" `should` ->
			ArrayIdentity Identity.of [1 to 10] .reverse!
			.run.x `assert.equal` [10 to 1]

