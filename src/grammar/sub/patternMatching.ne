match_expr -> %kWmatch %lparen _nl value_expr _nl %rparen matchBody 								{% data => ({ type: "match_stmt", matched: t.mid(data), body: t.last(data) }) %}

matchBody -> %lcurly __nl matchBranch:+ matchDefaultBranch:? __nl %rcurly 						{% data => ({ type: "match_body", branches: t.beforeMid(data), defaultBranch: t.afterMid(data) }) %}

matchDefaultBranch -> %kW_ matchBranchBody 												{% data => ({ type: "match_default_branch", body: t.last(data) }) %}

matchBranchBody -> __ %arrow __ value_expr 												{% t.last %}

matchBranch -> matchStructure matchBranchBody __nl 										{% data => ({ type: "match_branch", body: t.mid(data), structure: matchStructure }) %}

matchStructure -> array_destructuring 													{% data => ({ type: "destructuring_match", structure: t.first(data) }) %}
	| literal																			{% data => ({ type: "literal_match", structure: t.first(data) }) %}
	| matchOrIntroduceVariable															{% id %}
	| matchStructure (_ %comma __ matchStructure):+ (_ %comma __):?							{% data => ({ type: "choice_match", choices: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| matchStructure (_ %bitwise_and __ matchStructure):+ (_ %bitwise_and __):?							{% data => ({ type: "multiple_match", criterias: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| %lbracket _ matchOrIntroduceVariable __ %bitwise_or __ matchOrIntroduceVariable _ %rbracket			{% data => ({ type: "array_match", head: data[2], tail: data[6] }) %}

matchVariable -> %lt _ fully_qualified_name _ %gt										{% data => ({ type: "variable_match", ref: t.mid(data) }) %}
matchOrIntroduceVariable -> matchVariable 												{% id %}
	| ident 																			{% data => ({ type: "introduce_variable_match", variable: t.first(data) }) %}


# TODO: Mix and match destructuring and literals
