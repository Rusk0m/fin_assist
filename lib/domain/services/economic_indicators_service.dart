import 'package:fin_assist/domain/entity/financial_report.dart';

import '../entity/economic_indicators.dart';

/// Сервис для расчета финансово-экономических показателей
class EconomicIndicatorsService {
  /// Рассчитывает показатели по одному финансовому отчету
  EconomicIndicators calculateIndicators(FinancialReportEntity report) {
    final balance = report.balance;
    final cashFlow = report.cashFlow;
    final income = report.incomeStatement;

    // ----------------- Ликвидность -----------------
    // Показатель способности предприятия покрыть краткосрочные обязательства
    final liquidityRatio = balance.currentAssets / balance.shortTermLiabilities;

    // Быстрая ликвидность: из текущих активов исключаем запасы
    final quickRatio = (balance.currentAssets - balance.inventory) / balance.shortTermLiabilities;

    // ----------------- Финансовая устойчивость -----------------
    // Отношение заемного капитала к собственному
    final debtToEquity = (balance.shortTermLiabilities + balance.longTermLiabilities) / balance.equity;

    // ----------------- Рентабельность -----------------
    // Рентабельность активов (эффективность использования всех активов)
    final returnOnAssets = income.netProfit / balance.totalAssets;

    // Рентабельность собственного капитала
    final returnOnEquity = income.netProfit / balance.equity;

    // Валовая прибыль / Выручка
    final grossProfitMargin = (income.revenue - income.cogs) / income.revenue;

    // Чистая прибыль / Выручка
    final netProfitMargin = income.netProfit / income.revenue;

    // ----------------- Движение денежных средств -----------------
    final operatingCashFlow = cashFlow.operating;   // Денежные потоки от основной деятельности
    final investingCashFlow = cashFlow.investing;   // Денежные потоки от инвестиций
    final financingCashFlow = cashFlow.financing;   // Денежные потоки от финансовой деятельности

    return EconomicIndicators(
      liquidityRatio: liquidityRatio,
      quickRatio: quickRatio,
      debtToEquity: debtToEquity,
      returnOnAssets: returnOnAssets,
      returnOnEquity: returnOnEquity,
      grossProfitMargin: grossProfitMargin,
      netProfitMargin: netProfitMargin,
      operatingCashFlow: operatingCashFlow,
      investingCashFlow: investingCashFlow,
      financingCashFlow: financingCashFlow,
    );
  }

  /// Рассчитывает показатели для списка финансовых отчетов и возвращает агрегированные значения
  EconomicIndicators calculateAggregatedIndicators(List<FinancialReportEntity> reports) {
    // Суммируем все значения по каждому отчету
    double totalCash = 0, totalCurrentAssets = 0, totalEquity = 0, totalInventory = 0;
    double totalShortTermLiabilities = 0, totalLongTermLiabilities = 0, totalAssets = 0;
    double totalRevenue = 0, totalNetProfit = 0, totalCOGS = 0;
    double totalOperating = 0, totalInvesting = 0, totalFinancing = 0;

    for (var report in reports) {
      final balance = report.balance;
      final cashFlow = report.cashFlow;
      final income = report.incomeStatement;

      totalCash += balance.cash;
      totalCurrentAssets += balance.currentAssets;
      totalEquity += balance.equity;
      totalInventory += balance.inventory;
      totalShortTermLiabilities += balance.shortTermLiabilities;
      totalLongTermLiabilities += balance.longTermLiabilities;
      totalAssets += balance.totalAssets;

      totalRevenue += income.revenue;
      totalNetProfit += income.netProfit;
      totalCOGS += income.cogs;

      totalOperating += cashFlow.operating;
      totalInvesting += cashFlow.investing;
      totalFinancing += cashFlow.financing;
    }

    // ----------------- Ликвидность -----------------
    final liquidityRatio = totalCurrentAssets / totalShortTermLiabilities;
    final quickRatio = (totalCurrentAssets - totalInventory) / totalShortTermLiabilities;

    // ----------------- Финансовая устойчивость -----------------
    final debtToEquity = (totalShortTermLiabilities + totalLongTermLiabilities) / totalEquity;

    // ----------------- Рентабельность -----------------
    final returnOnAssets = totalNetProfit / totalAssets;
    final returnOnEquity = totalNetProfit / totalEquity;
    final grossProfitMargin = (totalRevenue - totalCOGS) / totalRevenue;
    final netProfitMargin = totalNetProfit / totalRevenue;

    // ----------------- Денежные потоки -----------------
    final operatingCashFlow = totalOperating;
    final investingCashFlow = totalInvesting;
    final financingCashFlow = totalFinancing;

    return EconomicIndicators(
      liquidityRatio: liquidityRatio,
      quickRatio: quickRatio,
      debtToEquity: debtToEquity,
      returnOnAssets: returnOnAssets,
      returnOnEquity: returnOnEquity,
      grossProfitMargin: grossProfitMargin,
      netProfitMargin: netProfitMargin,
      operatingCashFlow: operatingCashFlow,
      investingCashFlow: investingCashFlow,
      financingCashFlow: financingCashFlow,
    );
  }
}
