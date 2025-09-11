/// Финансово-экономические показатели предприятия
class EconomicIndicators {
  // ----------------- Ликвидность -----------------
  final double liquidityRatio;       // Коэффициент текущей ликвидности: currentAssets / shortTermLiabilities
  final double quickRatio;           // Быстрая ликвидность (без запасов): (currentAssets - inventory) / shortTermLiabilities

  // ----------------- Финансовая устойчивость -----------------
  final double debtToEquity;         // Соотношение долгов и капитала: (shortTermLiabilities + longTermLiabilities) / equity

  // ----------------- Рентабельность -----------------
  final double returnOnAssets;       // ROA: netProfit / totalAssets
  final double returnOnEquity;       // ROE: netProfit / equity
  final double grossProfitMargin;    // Валовая маржа: (revenue - COGS) / revenue
  final double netProfitMargin;      // Чистая маржа: netProfit / revenue

  // ----------------- Движение денежных средств -----------------
  final double operatingCashFlow;    // Операционный денежный поток (cash from operations)
  final double investingCashFlow;    // Инвестиционный денежный поток (cash from investing)
  final double financingCashFlow;    // Финансовый денежный поток (cash from financing)

  EconomicIndicators({
    required this.liquidityRatio,
    required this.quickRatio,
    required this.debtToEquity,
    required this.returnOnAssets,
    required this.returnOnEquity,
    required this.grossProfitMargin,
    required this.netProfitMargin,
    required this.operatingCashFlow,
    required this.investingCashFlow,
    required this.financingCashFlow,
  });
}
