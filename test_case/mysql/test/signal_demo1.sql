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
select * from ab_physical_person order by person_id;
select * from ab_moral_person order by company_id;
select * from in_inventory order by item_id;
select * from po_order;
select * from po_order_line;
select po_id as "PO#",
  ( case cust_type
  when "P" then concat (pp.first_name,
                   " ",
                   pp.middle_initial,
                   " ",
                   pp.last_name)
  when "M" then mp.name
  end ) as "Sold to"
  from po_order po
  left join ab_physical_person pp on po.cust_id = pp.person_id
  left join ab_moral_person mp on po.cust_id = company_id;
select po_id as "PO#",
  ol.line_no as "Line",
  ol.item_id as "Item",
  inv.descr as "Description",
  ol.qty as "Quantity"
  from po_order_line ol, in_inventory inv
  where inv.item_id = ol.item_id
  order by ol.item_id, ol.line_no;
drop database demo;
