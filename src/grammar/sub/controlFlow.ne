throw_stmt -> %kWthrow __ value_expr											{% data => ({ type: "throw_stmt", exception: t.last(data) }) %}

ifBranch -> %kWif _ %lparen _nl value_expr _nl %rparen _nl expr 							{% data => ({ type: "if_branch", condition:t.mid(data), body: t.last(data) }) %}
elseIfBranch -> %kWelse __ ifBranch 											{% data => ({ ...t.last(data), type: "else_if_branch" }) %}
elseBranch -> %kWelse _nl expr 												{% data => ({ ...t.last(data), type: "else_branch" }) %}

whileBlock -> %kWwhile _ %lparen _nl value_expr _nl %rparen							{% t.afterMid %}

if_stmt -> ifBranch (elseIfBranch):* (elseBranch):? 						{% data => ({ type: "if_stmt", ifBranch: t.first(data), elseIfBranches: t.mid(data).map(id), elseBranch: t.last(data) }) %}
while_stmt -> whileBlock _nl expr 											{% data => ({ type: "while_stmt", condition: t.first(data), body: t.last(data) }) %}
do_while_stmt -> %kWdo _nl expr _nl whileBlock 								{% data => ({ type: "do_while_stmt", condition: t.last(data), body: t.mid(data) }) %}
