CREATE TEMPORARY TABLE tlList (
       row INTEGER PRIMARY KEY,
       name STRING,
       version STRING,
       flavor STRING
    );
INSERT INTO tlList 
      values(NULL, 'libhello:script', '/localhost@rpl:linux/0-1-1', '1#x86');
INSERT INTO tlList 
      values(NULL, 'libhello:user', '/localhost@rpl:linux/0-1-1', '1#x86');
INSERT INTO tlList 
      values(NULL, 'libhello:runtime', '/localhost@rpl:linux/0-1-1', '1#x86');
select row, pinned from tlList, Instances, Versions, Flavors
        where
            Instances.troveName = tlList.name
        and Versions.version = tlList.version
        and Instances.versionId = Versions.versionId
        and (    Flavors.flavor = tlList.flavor or Flavors.flavor is NULL
             and tlList.flavor = '')
        and Instances.flavorId = Flavors.flavorId
    order by row asc;
CREATE INDEX InstancesNameIdx ON Instances(troveName);
CREATE UNIQUE INDEX InstancesIdx 
      ON Instances(troveName, versionId, flavorId);
ANALYZE;
select row, pinned from tlList, Instances, Versions, Flavors
        where
            Instances.troveName = tlList.name
        and Versions.version = tlList.version
        and Instances.versionId = Versions.versionId
        and (    Flavors.flavor = tlList.flavor or Flavors.flavor is NULL
             and tlList.flavor = '')
        and Instances.flavorId = Flavors.flavorId
    order by row asc;
