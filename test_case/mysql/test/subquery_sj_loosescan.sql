
--
-- Run subquery_sj.inc with semijoin and turn off all strategies, but LooseScan
--

set optimizer_switch='semijoin=on,loosescan=on';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='firstmatch=off';
{
  set optimizer_switch='duplicateweedout=off';
{
  set optimizer_switch='index_condition_pushdown=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;
