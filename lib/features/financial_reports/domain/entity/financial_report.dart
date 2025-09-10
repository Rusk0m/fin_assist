import 'package:equatable/equatable.dart';

class FinancialReportEntity extends Equatable{
  final String period;        // Период (2025-01, 2025-Q1, 2025)
  final String type;          // Тип отчета (monthly | quarterly | yearly)
  final String status;        // submitted | draft | approved
  final String submittedBy;   // UID пользователя, кто загрузил
  final DateTime submittedAt; // Дата загрузки

  final Balance balance;      // Баланс
  final CashFlow cashFlow;    // Денежные потоки
  final IncomeStatement incomeStatement; // Отчет о прибылях и убытках

  const FinancialReportEntity({
    required this.period,
    required this.type,
    required this.status,
    required this.submittedBy,
    required this.submittedAt,
    required this.balance,
    required this.cashFlow,
    required this.incomeStatement,
  });

  @override
  List<Object?> get props => [period,type,status,submittedBy,submittedBy,balance,cashFlow,incomeStatement];
}

class Balance {
  final double cash;
  final double currentAssets;
  final double nonCurrentAssets;
  final double inventory;
  final double receivables;
  final double totalAssets;
  final double equity;
  final double shortTermLiabilities;
  final double longTermLiabilities;

  Balance({
    required this.cash,
    required this.currentAssets,
    required this.nonCurrentAssets,
    required this.inventory,
    required this.receivables,
    required this.totalAssets,
    required this.equity,
    required this.shortTermLiabilities,
    required this.longTermLiabilities,
  });
}

class CashFlow {
  final double operating;
  final double investing;
  final double financing;

  CashFlow({
    required this.operating,
    required this.investing,
    required this.financing,
  });
}

class IncomeStatement {
  final double revenue;
  final double cogs;
  final double netProfit;

  IncomeStatement({
    required this.revenue,
    required this.cogs,
    required this.netProfit,
  });
}
