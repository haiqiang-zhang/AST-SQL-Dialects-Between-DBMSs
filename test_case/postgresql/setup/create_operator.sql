CREATE OPERATOR ## (
   leftarg = path,
   rightarg = path,
   function = path_inter,
   commutator = ##
);
CREATE OPERATOR @#@ (
   rightarg = int8,		
   procedure = factorial
);
