create table Room (
    roomno	char(8),
    comment	text
);
create unique index Room_rno on Room using btree (roomno bpchar_ops);
create table WSlot (
    slotname	char(20),
    roomno	char(8),
    slotlink	char(20),
    backlink	char(20)
);
create unique index WSlot_name on WSlot using btree (slotname bpchar_ops);
create table PField (
    name	text,
    comment	text
);
create unique index PField_name on PField using btree (name text_ops);
create table PSlot (
    slotname	char(20),
    pfname	text,
    slotlink	char(20),
    backlink	char(20)
);
create unique index PSlot_name on PSlot using btree (slotname bpchar_ops);
create table PLine (
    slotname	char(20),
    phonenumber	char(20),
    comment	text,
    backlink	char(20)
);
create unique index PLine_name on PLine using btree (slotname bpchar_ops);
create table Hub (
    name	char(14),
    comment	text,
    nslots	integer
);
create unique index Hub_name on Hub using btree (name bpchar_ops);
create table HSlot (
    slotname	char(20),
    hubname	char(14),
    slotno	integer,
    slotlink	char(20)
);
create unique index HSlot_name on HSlot using btree (slotname bpchar_ops);
create index HSlot_hubname on HSlot using btree (hubname bpchar_ops);
create table System (
    name	text,
    comment	text
);
create unique index System_name on System using btree (name text_ops);
create table IFace (
    slotname	char(20),
    sysname	text,
    ifname	text,
    slotlink	char(20)
);
create unique index IFace_name on IFace using btree (slotname bpchar_ops);
create table PHone (
    slotname	char(20),
    comment	text,
    slotlink	char(20)
);
create unique index PHone_name on PHone using btree (slotname bpchar_ops);
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
insert into Room values ('001', 'Entrance');
insert into Room values ('002', 'Office');
insert into Room values ('003', 'Office');
insert into Room values ('004', 'Technical');
insert into Room values ('101', 'Office');
insert into Room values ('102', 'Conference');
insert into Room values ('103', 'Restroom');
insert into Room values ('104', 'Technical');
insert into Room values ('105', 'Office');
insert into Room values ('106', 'Office');
insert into WSlot values ('WS.001.1a', '001', '', '');
insert into WSlot values ('WS.001.1b', '001', '', '');
insert into WSlot values ('WS.001.2a', '001', '', '');
insert into WSlot values ('WS.001.2b', '001', '', '');
insert into WSlot values ('WS.001.3a', '001', '', '');
insert into WSlot values ('WS.001.3b', '001', '', '');
insert into WSlot values ('WS.002.1a', '002', '', '');
insert into WSlot values ('WS.002.1b', '002', '', '');
insert into WSlot values ('WS.002.2a', '002', '', '');
insert into WSlot values ('WS.002.2b', '002', '', '');
insert into WSlot values ('WS.002.3a', '002', '', '');
insert into WSlot values ('WS.002.3b', '002', '', '');
insert into WSlot values ('WS.003.1a', '003', '', '');
insert into WSlot values ('WS.003.1b', '003', '', '');
insert into WSlot values ('WS.003.2a', '003', '', '');
insert into WSlot values ('WS.003.2b', '003', '', '');
insert into WSlot values ('WS.003.3a', '003', '', '');
insert into WSlot values ('WS.003.3b', '003', '', '');
insert into WSlot values ('WS.101.1a', '101', '', '');
insert into WSlot values ('WS.101.1b', '101', '', '');
insert into WSlot values ('WS.101.2a', '101', '', '');
insert into WSlot values ('WS.101.2b', '101', '', '');
insert into WSlot values ('WS.101.3a', '101', '', '');
insert into WSlot values ('WS.101.3b', '101', '', '');
insert into WSlot values ('WS.102.1a', '102', '', '');
insert into WSlot values ('WS.102.1b', '102', '', '');
insert into WSlot values ('WS.102.2a', '102', '', '');
insert into WSlot values ('WS.102.2b', '102', '', '');
insert into WSlot values ('WS.102.3a', '102', '', '');
insert into WSlot values ('WS.102.3b', '102', '', '');
insert into WSlot values ('WS.105.1a', '105', '', '');
insert into WSlot values ('WS.105.1b', '105', '', '');
insert into WSlot values ('WS.105.2a', '105', '', '');
insert into WSlot values ('WS.105.2b', '105', '', '');
insert into WSlot values ('WS.105.3a', '105', '', '');
insert into WSlot values ('WS.105.3b', '105', '', '');
insert into WSlot values ('WS.106.1a', '106', '', '');
insert into WSlot values ('WS.106.1b', '106', '', '');
insert into WSlot values ('WS.106.2a', '106', '', '');
insert into WSlot values ('WS.106.2b', '106', '', '');
insert into WSlot values ('WS.106.3a', '106', '', '');
insert into WSlot values ('WS.106.3b', '106', '', '');
insert into PField values ('PF0_1', 'Wallslots basement');
insert into PSlot values ('PS.base.a1', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a2', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a3', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a4', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a5', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a6', 'PF0_1', '', '');
insert into PSlot values ('PS.base.b1', 'PF0_1', '', 'WS.002.1a');
insert into PSlot values ('PS.base.b2', 'PF0_1', '', 'WS.002.1b');
insert into PSlot values ('PS.base.b3', 'PF0_1', '', 'WS.002.2a');
insert into PSlot values ('PS.base.b4', 'PF0_1', '', 'WS.002.2b');
insert into PSlot values ('PS.base.b5', 'PF0_1', '', 'WS.002.3a');
insert into PSlot values ('PS.base.b6', 'PF0_1', '', 'WS.002.3b');
insert into PSlot values ('PS.base.c1', 'PF0_1', '', 'WS.003.1a');
insert into PSlot values ('PS.base.c2', 'PF0_1', '', 'WS.003.1b');
insert into PSlot values ('PS.base.c3', 'PF0_1', '', 'WS.003.2a');
insert into PSlot values ('PS.base.c4', 'PF0_1', '', 'WS.003.2b');
insert into PSlot values ('PS.base.c5', 'PF0_1', '', 'WS.003.3a');
insert into PSlot values ('PS.base.c6', 'PF0_1', '', 'WS.003.3b');
insert into PField values ('PF0_X', 'Phonelines basement');
insert into PSlot values ('PS.base.ta1', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta2', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta3', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta4', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta5', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta6', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb1', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb2', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb3', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb4', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb5', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb6', 'PF0_X', '', '');
insert into PField values ('PF1_1', 'Wallslots first floor');
insert into PSlot values ('PS.first.a1', 'PF1_1', '', 'WS.101.1a');
insert into PSlot values ('PS.first.a2', 'PF1_1', '', 'WS.101.1b');
insert into PSlot values ('PS.first.a3', 'PF1_1', '', 'WS.101.2a');
insert into PSlot values ('PS.first.a4', 'PF1_1', '', 'WS.101.2b');
insert into PSlot values ('PS.first.a5', 'PF1_1', '', 'WS.101.3a');
insert into PSlot values ('PS.first.a6', 'PF1_1', '', 'WS.101.3b');
insert into PSlot values ('PS.first.b1', 'PF1_1', '', 'WS.102.1a');
insert into PSlot values ('PS.first.b2', 'PF1_1', '', 'WS.102.1b');
insert into PSlot values ('PS.first.b3', 'PF1_1', '', 'WS.102.2a');
insert into PSlot values ('PS.first.b4', 'PF1_1', '', 'WS.102.2b');
insert into PSlot values ('PS.first.b5', 'PF1_1', '', 'WS.102.3a');
insert into PSlot values ('PS.first.b6', 'PF1_1', '', 'WS.102.3b');
insert into PSlot values ('PS.first.c1', 'PF1_1', '', 'WS.105.1a');
insert into PSlot values ('PS.first.c2', 'PF1_1', '', 'WS.105.1b');
insert into PSlot values ('PS.first.c3', 'PF1_1', '', 'WS.105.2a');
insert into PSlot values ('PS.first.c4', 'PF1_1', '', 'WS.105.2b');
insert into PSlot values ('PS.first.c5', 'PF1_1', '', 'WS.105.3a');
insert into PSlot values ('PS.first.c6', 'PF1_1', '', 'WS.105.3b');
insert into PSlot values ('PS.first.d1', 'PF1_1', '', 'WS.106.1a');
insert into PSlot values ('PS.first.d2', 'PF1_1', '', 'WS.106.1b');
insert into PSlot values ('PS.first.d3', 'PF1_1', '', 'WS.106.2a');
insert into PSlot values ('PS.first.d4', 'PF1_1', '', 'WS.106.2b');
insert into PSlot values ('PS.first.d5', 'PF1_1', '', 'WS.106.3a');
insert into PSlot values ('PS.first.d6', 'PF1_1', '', 'WS.106.3b');
update PSlot set backlink = 'WS.001.1a' where slotname = 'PS.base.a1';
update PSlot set backlink = 'WS.001.1b' where slotname = 'PS.base.a3';
