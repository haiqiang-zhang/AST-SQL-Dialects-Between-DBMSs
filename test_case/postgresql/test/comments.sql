
SELECT 'trailing' AS first; 
SELECT /* embedded single line */ 'embedded' AS second;
SELECT /* both embedded and trailing single line */ 'both' AS third; 

SELECT 'before multi-line' AS fourth;
/* This is an example of SQL which should not execute:
 * select 'multi-line';
 */
SELECT 'after multi-line' AS fifth;


/*
SELECT 'trailing' as x1; 
*/

/* This block comment surrounds a query which itself has a block comment...
SELECT /* embedded single line */ 'embedded' AS x2;
*/

SELECT 
/* Deeply nested comment.
   This includes a single apostrophe to make sure we aren't decoding this part as a string.
SELECT 'deep nest' AS n1;
/* Second level of nesting...
SELECT 'deeper nest' as n2;
/* Third level of nesting...
SELECT 'deepest nest' as n3;
*/
Hoo boy. Still two deep...
*/
Now just one deep...
*/
'deeply nested example' AS sixth;

/* and this is the end of the file */
