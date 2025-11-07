:- consult(node).
:- consult(frontier).
:- consult(exp_states).
:- consult(solution).

expand(Node, Successors):-
    findall(NextNode, successor(Node, NextNode), Successors). % Finds all successors of the node

successor(Node, NextNode):-
    node_state(CurrNode, CurrState),
    transition(CurrState, NextState, Operator, ActionCost), 
    node(NextNode, NextState, CurrNode, Operator, ActionCost). % Creates the successor node

