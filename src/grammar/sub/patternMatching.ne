match_expr -> "match" "(" _nl expr _nl ")" matchBody 									{% data => ({ type: "match_stmt", matched: t.mid(data), body: t.last(data) }) %}

matchBody -> "{" __nl matchBranch:+ __nl matchDefaultBranch __nl "}" 					{% data => ({ type: "match_body", branches: t.beforeMid(data), defaultBranch: t.afterMid(data) }) %}

matchDefaultBranch -> "_" matchBranchBody 												{% data => ({ type: "match_default_branch", body: t.last(data) }) %}

matchBranchBody -> __ "->" __ expr 														{% t.last %}

matchBranch -> matchStructure matchBranchBody 											{% data => ({ type: "match_branch", body: t.last(data), structure: matchStructure }) %}

matchStructure -> array_destructuring 													{% data => ({ type: "destructuring_match", structure: t.first(data) }) %}
	| literal																			{% data => ({ type: "literal_match", structure: t.first(data) }) %}
	| matchOrIntroduceVariable															{% id %}
	| matchStructure (_ "," __ matchStructure):+ (_ "," __):?							{% data => ({ type: "choice_match", choices: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| matchStructure (_ "&" __ matchStructure):+ (_ "&" __):?							{% data => ({ type: "multiple_match", criterias: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| "[" _ matchOrIntroduceVariable __ "|" __ matchOrIntroduceVariable _ "]"			{% data => ({ type: "array_match", head: data[2], tail: data[6] }) %}

matchVariable -> "<" _ fully_qualified_name _ ">"										{% data => ({ type: "variable_match", structure: t.mid(data) }) %}
matchOrIntroduceVariable -> matchVariable 												{% id %}
	| ident 																			{% data => ({ type: "introduce_variable_match", structure: t.first(data) }) %}


# TODO: Mix and match destructuring and literals
