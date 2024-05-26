SELECT arraySort(topK(10)(val1)) FROM topk;
SELECT topKWeighted(10)(toString(number), number) from numbers(3000000);
DROP TABLE topk;
