match_expr -> "match" "(" _ expr _ ")" matchBody 									{% data => ({ type: "match_stmt", matched: t.mid(data), body: t.last(data) }) %}

matchBody -> "{" _ matchBranch:+ _ matchDefaultBranch _ "}" 						{% data => ({ type: "match_body", branches: t.beforeMid(data), defaultBranch: t.afterMid(data) }) %}

matchDefaultBranch -> "_" matchBranchBody 											{% data => ({ type: "match_default_branch", body: t.last(data) }) %}

matchBranchBody -> _ "->" _ expr 													{% t.last %}

matchBranch -> matchStructure matchBranchBody 										{% data => ({ type: "match_branch", body: t.last(data), structure: matchStructure }) %}

matchStructure -> array_destructuring 												{% data => ({ type: "destructuring_match", structure: t.first(data) }) %}
	| literal																		{% data => ({ type: "literal_match", structure: t.first(data) }) %}
	| matchOrIntroduceVariable																	{% id %}
	| matchStructure (_ "," _ matchStructure):+ (_ "," _):?			{% data => ({ type: "choice_match", choices: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| matchStructure (_ "&" _ matchStructure):+ (_ "&" _):?			{% data => ({ type: "multiple_match", criterias: [t.first(data), ...t.second(data).map(t.last)] }) %}
	| "[" _ matchOrIntroduceVariable _ "|" _ matchOrIntroduceVariable _ "]"			{% data => ({ type: "array_match", head: data[2], tail: data[6] }) %}

matchVariable -> "<" _ fully_qualified_name _ ">"									{% data => ({ type: "variable_match", structure: t.mid(data) }) %}
matchIntroduceVariable -> ident 													{% data => ({ type: "introduce_variable_match", structure: t.first(data) }) %}
matchOrIntroduceVariable -> matchVariable 											{% id %}
	| matchIntroduceVariable 														{% id %}


# TODO: Mix and match destructuring and literals
