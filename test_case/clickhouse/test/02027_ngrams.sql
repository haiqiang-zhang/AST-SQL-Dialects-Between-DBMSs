SELECT ngrams('Test', 1);
SELECT ngrams('Test', 2);
SELECT ngrams('Test', 3);
SELECT ngrams('Test', 4);
SELECT ngrams('Test', 5);
SELECT ngrams('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ', 1);
SELECT ngrams('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ', 2);
SELECT ngrams('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ', 3);
SELECT ngrams('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ', 4);
SELECT ngrams('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ', 5);
SELECT ngrams(materialize('Test'), 1);
SELECT ngrams(materialize('Test'), 2);
SELECT ngrams(materialize('Test'), 3);
SELECT ngrams(materialize('Test'), 4);
SELECT ngrams(materialize('Test'), 5);
SELECT ngrams(materialize('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), 1);
SELECT ngrams(materialize('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), 2);
SELECT ngrams(materialize('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), 3);
SELECT ngrams(materialize('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), 4);
SELECT ngrams(materialize('Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), 5);
SELECT ngrams(toFixedString('Test', 4), 1);
SELECT ngrams(toFixedString('Test', 4), 2);
SELECT ngrams(toFixedString('Test', 4), 3);
SELECT ngrams(toFixedString('Test', 4), 4);
SELECT ngrams(toFixedString('Test', 4), 5);
SELECT ngrams(materialize(toFixedString('Test', 4)), 1);
SELECT ngrams(materialize(toFixedString('Test', 4)), 2);
SELECT ngrams(materialize(toFixedString('Test', 4)), 3);
SELECT ngrams(materialize(toFixedString('Test', 4)), 4);
SELECT ngrams(materialize(toFixedString('Test', 4)), 5);
