require! daggy

module.exports = exports.ArrayT = (M)->
	ArrayT = daggy.tagged \run

	sequence = (m, ms)-->
		ms.reduce do
			(m1, m2)->
				x  <- m1.chain
				xs <- m2.chain
				m.of x ++ xs
			m.of []

	ArrayT.of = (x)->
		ArrayT M.of [x]

	# chain ::  M [a] -> (a -> M [b]) -> M [b]
	ArrayT::chain = (f)->
		ArrayT @run.chain (o)->
			sequence M, o.reduce do
				(a, x)-> a ++ f x .run
				[]

	ArrayT::map = (f)->
		@chain (a)-> ArrayT.of f a

	ArrayT::ap = (a)->
		@chain (f)-> a.map f

	ArrayT::concat = (a)->
		ArrayT sequence M, [@run, a.run]

	ArrayT.empty = -> ArrayT M.of []

	ArrayT::reduce = (f, i)->
		@run.map (.reduce f, i)

	ArrayT::reduce-right = (f, i)->
		@run.map (.reduce-right f, i)

	ArrayT::take = (n)->
		ArrayT @run.map (.slice 0 n)

	ArrayT::drop = (n)->
		ArrayT @run.map (.slice n)

	ArrayT::tail = ->
		@drop 1

	ArrayT::head = ->
		@run.map (.0)

	ArrayT::initial = ->
		@take -1

	ArrayT::last = ->
		@run.map (a)-> a[a.length - 1]

	ArrayT::reverse = ->
		ArrayT @reduce-right do
			(a, x)-> a ++ [x]
			[]

	ArrayT::len = ->
		@run.map (.length)

	ArrayT::filter = (f)->
		ArrayT @run.map (.filter f)

	ArrayT::reject = (f)->
		ArrayT @run.map (.filter (not) . f)

	ArrayT::find = (f)->
		@filter f .head!

	ArrayT::mkString = (j = '')->
		@run.map (.join j)

	ArrayT::every = (f)->
		@reduce do
			(a, x)-> a and f x
			true

	ArrayT::some = (f)->
		@reduce do
			(a, x)-> a or f x
			false

	ArrayT