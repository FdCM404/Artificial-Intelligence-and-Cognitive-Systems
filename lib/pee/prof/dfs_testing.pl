:- consult(dfs_algorithm).

transition(0, 1, goes_to_1).
transition(0, 2, goes_to_2).
transition(1, 3, goes_to_3).
transition(1, 6, goes_to_6).
transition(2, 4, goes_to_4).
transition(3, 2, goes_to_2).
transition(3, 5, goes_to_5).
transition(4, 3, goes_to_3).
transition(5, 4, goes_to_4).
transition(5, 6, goes_to_6).
transition(6, 3, goes_to_3).

goal(4).
