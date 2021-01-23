throw_stmt -> "throw" _ expr												{% data => ({ type: "throw_stmt", exception: t.last(data) }) %}

ifBranch -> "if" _ "(" _  expr _ ")" _ expr 								{% data => ({ type: "if_branch", condition:t.mid(data), body: t.last(data) }) %}
elseIfBranch -> "else" _ ifBranch 											{% data => ({ ...t.last(data), type: "else_if_branch" }) %}
elseBranch -> "else" _ expr 												{% data => ({ ...t.last(data), type: "else_branch" }) %}

whileBlock -> "while" _ "(" _ expr _ ")"									{% t.afterMid %}

if_stmt -> ifBranch (elseIfBranch):* (elseBranch):? 						{% data => ({ type: "if_stmt", ifBranch: t.first(data), elseIfBranches: t.mid(data), elseBranch: t.last(data) }) %}
while_stmt -> whileBlock _ expr 											{% data => ({ type: "while_stmt", condition: t.first(data), body: t.last(data) }) %}
do_while_stmt -> "do" _ expr _ whileBlock 									{% data => ({ type: "do_while_stmt", condition: t.last(data), body: t.mid(data) }) %}
