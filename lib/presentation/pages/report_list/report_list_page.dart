import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/blocs/selection_bloc/selection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectionBloc, SelectionState>(
      listener: (context, selectionState) {
        final branchId = selectionState.selectedBranch?.branchId;
        if (branchId != null) {
          context.read<FinancialReportBloc>().add(
            GetReportsByBranchEvent(branchId),
          );
        }
      },
      child: BlocBuilder<FinancialReportBloc, FinancialReportState>(
        builder: (context, reportState) {
          if (reportState is FinancialReportLoading ||
              reportState is FinancialReportInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (reportState is FinancialReportsLoadedState) {
            return ReportListView(reports: reportState.reports);
          } else if (reportState is FinancialReportErrorState) {
            return Scaffold(body: Center(child: Text(reportState.message)));
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class ReportListView extends StatelessWidget {
  const ReportListView({super.key, required this.reports});

  final List<FinancialReportEntity> reports;

  List<FinancialReportEntity> get sortedReports {
    final sorted = List<FinancialReportEntity>.from(reports);
    sorted.sort((a, b) => b.period.compareTo(a.period)); // DESC
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings_page');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = sortedReports[index];
                return ListTile(
                  title: Text("Отчёт: ${report.period}"),
                  subtitle: Text(report.status),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/report_detail_page',
                      arguments: report,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
