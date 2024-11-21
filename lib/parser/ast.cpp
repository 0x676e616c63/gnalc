#include "../../include/praser/ast.hpp"

void showAst(past node, int nest, bool use_blank) {
	if(node == NULL)
		return;
	if(use_blank) {
		for (int i = 0; i < nest; i++)
			printf("    ");
	}else{
		printf("%d", nest);
	}
	switch (node->nodeType){
		case INTEGER_LITERAL:
			printf("%s %d\n", "INTEGER_LITERAL", node->ivalue);
			break;
		case BINARY_OPERATOR:
			printf("%s ", "BINARY_OPERATOR");
			showToken(node->ivalue);
			printf("\n");
			break;
		case UNARY_OPERATOR:
			printf("%s ", "UNARY_OPERATOR");
			showToken(node->ivalue);
			printf("\n");
			break;
		case FUNCTION_DECL:
			printf("%s '%s'\n", "FUNCTION_DECL", node->svalue);
			break;
		case CALL_EXPR:
			printf("%s\n", "CALL_EXPR");
			break;
		case COMPOUND_STMT:
			printf("%s\n", "COMPOUND_STMT");
			break;
		case DECL_STMT:
			printf("%s\n", "DECL_STMT");
			break;
		case VARIABLE_REF:
			printf("%s\n", "VARIABLE_REF");
			break;
		case PARM_DECL:
			printf("%s '%s'\n", "PARM_DECL", node->svalue);
			break;
		case VAR_DECL:
			printf("%s: '%s'\n", "VAR_DECL", node->svalue);
			break;
		case DECL_REF_EXPR:
			printf("%s: '%s'\n", "DECL_REF_EXPR", node->svalue);
			break;
		case RETURN_STMT:
			printf("%s\n", "RETURN_STMT");
			break;
		case WHILE_STMT:
			printf("%s\n", "WHILE_STMT");
			break;
		case BREAK_STMT:
			printf("%s\n", "BREAK_STMT");
			break;
		case CONTINUE_STMT:
			printf("%s\n", "CONTINUE_STMT");
			break;
		case IF_STMT:
			printf("%s\n", "IF_STMT");
			showAst(node->if_cond, nest+1, use_blank);
			break;
		case INIT_LIST_EXPR:
			printf("%s\n", "INIT_LIST_EXPR");
			break;
		case ARRAY_SUBSCRIPT_EXPR:
			printf("%s\n", "ARRAY_SUBSCRIPT_EXPR");
			break;
		case PAREN_EXPR:
			printf("%s\n", "PAREN_EXPR");
			break;
		default:
			printf("%s\n", "NOT IMPlemented");
			break;
	}
	showAst(node->left, nest+1, use_blank);
	showAst(node->right, nest+1, use_blank);
	showAst(node->next, nest, use_blank);
}

void showToken(int Token) {
	switch (Token)	{
	case Y_INT:
		printf("%s", "INTEGER");
		break;
	case Y_FLOAT:
		printf("%s", "FLOAT");
		break;
	case Y_CONST:
		printf("%s", "CONST");
		break;
	case Y_ADD:
	case '+':
		printf("'%c'", '+');
		break;
	case Y_SUB:
	case '-':
		printf("'%c'", '-');
		break;
	case Y_MUL:
	case '*':
		printf("'%c'", '*');
		break;
	case Y_DIV:
		printf("'%c'", '/');
		break;
	case Y_MODULO:
	case '%':
		printf("'%c'", '%');
		break;
	case Y_LESS:
	case '<':
		printf("'%c'", '<');
		break;
	case Y_LESSEQ:
		printf("'%s'", "<=");
		break;
	case Y_GREAT:
	case '>':
		printf("'%c'", '>');
		break;
	case Y_GREATEQ:
		printf("'%s'", ">=");
		break;
	case Y_NOTEQ:
		printf("'%s'", "!=");
		break;
	case Y_EQ:
		printf("'%s'", "==");
		break;
	case Y_NOT:
	case '!':
		printf("'%c'", '!');
		break;
	case Y_AND:
		printf("'%s'", "&&");
		break;
	case Y_OR:
		printf("'%s'", "||");
		break;
	case Y_ASSIGN:
	case '=':
		printf("'%c'", '=');
		break;
	default:
		printf("unknown token: %d", Token);
		break;
	}
}

past newAstNode(node_type type) {
	past node = malloc(sizeof(ast));
	if(node == NULL)
	{
		printf("run out of memory.\n");
		exit(0);
	}
	memset(node, 0, sizeof(ast));

	node->nodeType = type;
	return node;
}

past lastNode(past node) {
	if(node == NULL) return NULL;
	while (node->next) node = node->next;
	return node;
}

past addNode(past target, past node) {
	past last = lastNode(target);
	if(last) last->next = node;
	else target = node;
	return target;
}

past newVarDecl(token_type type, char* id, past init_val, past arrry_subscript) {
	past node = newAstNode(VAR_DECL);
	node->ivalue = type;
	node->svalue = id;
	node->right = init_val;
	node->left = arrry_subscript;
	return node;
}

void SetDeclsType(past node, token_type type) {
	while (node) {
		node->ivalue = type;
		node = node->next;
	}
}

past newDeclStmt(past decl) {
	// if (decl->next == NULL) return decl;
	past node = newAstNode(DECL_STMT);
	node->left = decl;
	return node;
}

past newArraySubscripts(past delref, past subscripts) {
	past node = newAstNode(ARRAY_SUBSCRIPT_EXPR);
	past last_subscript = lastNode(subscripts);

	if (last_subscript != subscripts) {
		past cur = subscripts;
		while (cur->next != last_subscript) cur = cur->next;
		cur->next = NULL;
		delref = newArraySubscripts(delref, subscripts);
	}
	node->left = delref;
	node->right = last_subscript;
	return node;
}

past newInitList(past exp, past next) {
	past node = newAstNode(INIT_LIST_EXPR);
	if (exp == NULL) return node;
	node->left = exp;
	exp->next = next;
	return node;
}

past newFuncDef(token_type type, char* id, past params, past body) {
	past node = newAstNode(FUNCTION_DECL);
	node->ivalue = type;
	node->svalue = id;
	node->left = params;
	node->right = body;
	return node;
}

past newFuncParam(token_type type, char* id, past init_val, past arrry_subscript) {
	past node = newVarDecl(type, id, init_val, arrry_subscript);
	node->nodeType = PARM_DECL;
	return node;
}

past newBlock(past items) {
	past node = newAstNode(COMPOUND_STMT);
	node->left = items;
	return node;
}

past newBinaryOp(token_type op, past left, past right) {
	past node = newAstNode(BINARY_OPERATOR);
	node->ivalue = op;
	node->left = left;
	node->right = right;
	return node;
}

past newWhileStmt(past cond, past body) {
	past node = newAstNode(WHILE_STMT);
	node->left = cond;
	node->right = body;
	return node;
}

past newIfStmt(past cond, past body, past else_body) {
	past node = newAstNode(IF_STMT);
	node->if_cond = cond;
	node->left = body;
	node->right = else_body;
	return node;
}

past newReturnStmt(past expr) {
	past node = newAstNode(RETURN_STMT);
	node->left = expr;
	return node;
}

past newDeclRef(char* id, past para) {
	past node = newAstNode(DECL_REF_EXPR);
	node->svalue = id;
	node->left = para;
	return node;
}

past newParenExp(past expr) {
	past node = newAstNode(PAREN_EXPR);
	node->left = expr;
	return node;
}

past newInt(int val) {
	past node = newAstNode(INTEGER_LITERAL);
	node->ivalue = val;
	return node;
}

past newCallExp(past funcref, past paras) {
	past node = newAstNode(CALL_EXPR);
	if (funcref == NULL) return node;
	node->left = funcref;
	node->right = paras;
	return node;
}

past newUnaryOp(token_type op, past expr) {
	past node = newAstNode(UNARY_OPERATOR);
	node->ivalue = op;
	node->left = expr;
	return node;
}

past newVarRef(char* id, past para) {
	past node = newAstNode(VARIABLE_REF);
	node->svalue = id;
	node->left = para;
	return node;
}

