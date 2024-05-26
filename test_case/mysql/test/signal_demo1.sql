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
