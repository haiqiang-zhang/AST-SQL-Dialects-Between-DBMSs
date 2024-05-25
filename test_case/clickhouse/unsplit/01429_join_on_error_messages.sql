SET join_algorithm = 'partial_merge';
-- works for a = b OR a = b because of equivalent disjunct optimization

SET join_algorithm = 'grace_hash';
-- works for a = b OR a = b because of equivalent disjunct optimization

SET join_algorithm = 'hash';
