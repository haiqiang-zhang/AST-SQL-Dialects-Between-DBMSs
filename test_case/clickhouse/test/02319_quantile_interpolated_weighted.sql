SELECT 'quantileInterpolatedWeighted';
SELECT medianInterpolatedWeighted(a, 1), medianInterpolatedWeighted(b, 2), medianInterpolatedWeighted(c, 3) as x, toTypeName(x) FROM decimal;
SELECT quantileInterpolatedWeighted(a, 1), quantileInterpolatedWeighted(b, 2), quantileInterpolatedWeighted(c, 3) as x, toTypeName(x) FROM decimal WHERE a < 0;
SELECT quantileInterpolatedWeighted(0.0)(a, 1), quantileInterpolatedWeighted(0.0)(b, 2), quantileInterpolatedWeighted(0.0)(c, 3) FROM decimal WHERE a >= 0;
SELECT quantilesInterpolatedWeighted(0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)(a, 1) FROM decimal;
DROP TABLE IF EXISTS decimal;
