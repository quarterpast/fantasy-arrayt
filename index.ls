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

	ArrayT::fold = (f,g)->
		@run.chain (o)-> M.of o.fold f,g

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
		ArrayT @run.chain (o)-> M.of o ++ a

	ArrayT