drop database if exists demo;
create database demo;
create table ab_physical_person (
  person_id integer,
  first_name VARCHAR(50),
  middle_initial CHAR,
  last_name VARCHAR(50),
  primary key (person_id));
create table ab_moral_person (
  company_id integer,
  name VARCHAR(100),
  primary key (company_id));
create table in_inventory (
  item_id integer,
  descr VARCHAR(50),
  stock integer,
  primary key (item_id));
create table po_order (
  po_id integer auto_increment,
  cust_type char, /* arc relationship, see cust_id */
  cust_id integer, /* FK to ab_physical_person *OR* ab_moral_person */
  primary key (po_id));
create table po_order_line (
  po_id integer, /* FK to po_order.po_id */
  line_no integer,
  item_id integer, /* FK to in_inventory.item_id */
  qty integer);
insert into ab_physical_person values
  ( 1, "John", "A", "Doe"),
  ( 2, "Marry", "B", "Smith");
insert into ab_moral_person values
  ( 3, "ACME real estate, INC"),
  ( 4, "Local school");
insert into in_inventory values
  ( 100, "Table, dinner", 5),
  ( 101, "Chair", 20),
  ( 200, "Table, coffee", 3),
  ( 300, "School table", 25),
  ( 301, "School chairs", 50);
