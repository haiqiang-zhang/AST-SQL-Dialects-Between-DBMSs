SELECT h3GetDestinationIndexFromUnidirectionalEdge(1248204388774707197);
SELECT h3GetIndexesFromUnidirectionalEdge(1248204388774707199);
SELECT h3GetOriginIndexFromUnidirectionalEdge(1248204388774707199);
SELECT h3GetUnidirectionalEdgeBoundary(1248204388774707199);
SELECT h3GetUnidirectionalEdgesFromHexagon(1248204388774707199);
select h3GetUnidirectionalEdge(stringToH3('85283473fffffff'), stringToH3('85283477fffffff'));
SELECT h3UnidirectionalEdgeIsValid(1248204388774707199) as edge;
SELECT h3UnidirectionalEdgeIsValid(1248204388774707197) as edge;
SELECT h3UnidirectionalEdgeIsValid(stringToH3('85283473ffffff')) as edge;
