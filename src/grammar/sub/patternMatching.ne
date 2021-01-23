match_stmt -> "match" "(" _ expr _ ")" matchBody 						{% data => ({ type: "match_stmt", matched: t.mid(data), body: t.last(data) }) %}

matchBody -> "{" _ matchBranch:+ _ matchDefaultBranch _ "}" 			{% data => ({ type: "match_body", branches: t.beforeMid(data), defaultBranch: t.afterMid(data) }) %}

matchDefaultBranch -> "_" matchBranchBody 								{% data => ({ type: "match_default_branch", body: t.last(data) }) %}

matchBranchBody -> _ "->" _ expr 										{% t.last %}

matchBranch -> matchStructure matchBranchBody 							{% data => ({ type: "match_branch", body: t.last(data), structure: matchStructure }) %}

matchStructure -> destructuring 										{% data => ({ type: "destructuring_match", structure: t.first(data) }) %}
	| arrayLiteral														{% data => ({ type: "array_match", structure: t.first(data) }) %}
	| objectLiteral														{% data => ({ type: "object_match", structure: t.first(data) }) %}
	| "<" _ fully_qualified_name _ ">"									{% data => ({ type: "variable_match", structure: t.mid(data) }) %}
# TODO: Mix and match destructuring and literals