import 'package:fin_assist/di.dart';
import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/branch_bloc/branch_bloc.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:fin_assist/presentation/blocs/selection_bloc/selection_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:fin_assist/presentation/pages/report_selection_page/widgets/selection_card.dart';
import 'package:fin_assist/presentation/pages/report_selection_page/widgets/selection_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportSelectionPage extends StatefulWidget {
  const ReportSelectionPage({super.key});

  @override
  State<ReportSelectionPage> createState() => _ReportSelectionPageState();
}

class _ReportSelectionPageState extends State<ReportSelectionPage> {
  late final OrganizationBloc organizationBloc = getIt<OrganizationBloc>();
  late final BranchBloc branchBloc = getIt<BranchBloc>();
  late final FinancialReportBloc reportBloc = getIt<FinancialReportBloc>();
  late final SelectionBloc selectionBloc = getIt<SelectionBloc>();

  void _onTapOrganization(Organization organization) {
    selectionBloc.add(SelectOrganization(organization));
  }

  void _onTapBranch(Branch branch) {
    selectionBloc.add(SelectBranch(branch));
    reportBloc.add(GetReportsByBranchEvent(branch.branchId));
  }

  // void _onTapReport(FinancialReportEntity report) {
  //   selectionBloc.add(SelectReport(report));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Выбор отчёта"),
        actions: [
          IconButton(
            onPressed: () {
              print('SettingsPage: Logout button pressed');
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OrganizationBloc, OrganizationState>(
            listener: (context, organizationState) {
              if (organizationState is OrganizationErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(organizationState.message)),
                );
              }
            },
          ),
          BlocListener<BranchBloc, BranchState>(
            listener: (context, branchState) {
              if (branchState is BranchErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(branchState.message)));
              }
            },
          ),
          BlocListener<FinancialReportBloc, FinancialReportState>(
            listener: (context, reportState) {
              if (reportState is FinancialReportErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(reportState.message)));
              }
            },
          ),
        ],
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            BlocBuilder<SelectionBloc, SelectionState>(
              builder: (context, selectionState) {
                if (selectionState.selectedOrganization == null) {
                  return BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        if (userState.user.organizations.length > 1) {
                          return BlocBuilder<
                            OrganizationBloc,
                            OrganizationState
                          >(
                            builder: (context, organizationState) {
                              if (organizationState
                                  is OrganizationsLoadedState) {
                                if (organizationState
                                    .organizations
                                    .isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        organizationState.organizations.length,
                                    itemBuilder: (context, index) =>
                                        SelectionCard(
                                          onTap: () => _onTapOrganization(
                                            organizationState
                                                .organizations[index],
                                          ),
                                          title: organizationState
                                              .organizations[index]
                                              .name,
                                        ),
                                  );
                                }
                                return Center(
                                  child: Text(
                                    "У вас нет ни одной организации!!!",
                                  ),
                                );
                              } else if (organizationState
                                  is OrganizationInitial) {
                                organizationBloc.add(
                                  GetOrganizationsByListIdEvent(
                                    userState.user.organizations,
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          );
                        } else if (userState.user.organizations.isNotEmpty) {
                          return BlocBuilder<
                            OrganizationBloc,
                            OrganizationState
                          >(
                            builder: (context, organizationState) {
                              if (organizationState
                                  is OrganizationLoadedState) {
                                selectionBloc.add(
                                  SelectOrganization(
                                    organizationState.organization,
                                  ),
                                );
                              } else if (organizationState
                                  is OrganizationInitial) {
                                organizationBloc.add(
                                  GetOrganizationByIdEvent(
                                    userState.user.organizations.first,
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          );
                        } else {
                          return Center(
                            child: Text("У вас нет ни одной организации!!!"),
                          );
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                }
                return SelectionTitle(
                  title: "Организация",
                  selection: selectionState.selectedOrganization!.name,
                  onTap: () {
                    selectionBloc.add(ClearOrganization());
                  },
                );
              },
            ),
            BlocBuilder<SelectionBloc, SelectionState>(
              builder: (context, selectionState) {
                if (selectionState.selectedOrganization != null &&
                    selectionState.selectedBranch == null) {
                  return BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        return BlocBuilder<BranchBloc, BranchState>(
                          builder: (context, branchState) {
                            if (branchState is BranchesLoadedState) {
                              final List<Branch> branches = branchState.branches
                                  .where(
                                    (element) =>
                                        element.organizationId ==
                                        selectionState
                                            .selectedOrganization!
                                            .organizationId,
                                  )
                                  .toList();
                              if (branches.length > 1) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: branches.length,
                                  itemBuilder: (context, index) =>
                                      SelectionCard(
                                        title: branches[index].name,
                                        onTap: () =>
                                            _onTapBranch(branches[index]),
                                      ),
                                );
                              } else if (branches.isNotEmpty) {
                                selectionBloc.add(SelectBranch(branches.first));
                              }
                              return Center(
                                child: Text("У вас нет ни одного филиала!!!"),
                              );
                            } else if (branchState is BranchInitial) {
                              branchBloc.add(
                                GetBranchesByListIdEvent(
                                  userState.user.branches,
                                ),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (selectionState.selectedBranch != null) {
                  return SelectionTitle(
                    title: "Филиал",
                    selection: selectionState.selectedBranch!.name,
                    onTap: () {
                      selectionBloc.add(ClearBranch());
                    },
                  );
                }
                return SizedBox(height: 0);
              },
            ),
            BlocBuilder<SelectionBloc, SelectionState>(
              builder: (context, selectionState) {
                if (selectionState.selectedBranch != null) {
                  return FloatingActionButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/dashboard_page',
                      );
                    },
                    child: Text("Выбрать"),
                  );
                }
                return const SizedBox(height: 0);
              },
            ),
            // BlocBuilder<SelectionBloc, SelectionState>(
            //   builder: (context, selectionState) {
            //     if (selectionState.selectedBranch != null &&
            //         selectionState.selectedReport == null) {
            //       return BlocBuilder<FinancialReportBloc, FinancialReportState>(
            //         builder: (context, reportState) {
            //           if (reportState is FinancialReportsLoadedState) {
            //             if (reportState.reports.length > 1) {
            //               return ListView.builder(
            //                 shrinkWrap: true,
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 itemCount: reportState.reports.length,
            //                 itemBuilder: (context, index) => SelectionCard(
            //                   title: reportState.reports[index].reportId,
            //                   onTap: () =>
            //                       _onTapReport(reportState.reports[index]),
            //                 ),
            //               );
            //             } else if (reportState.reports.isNotEmpty) {
            //               selectionBloc.add(
            //                 SelectReport(reportState.reports.first),
            //               );
            //             }
            //             return Center(
            //               child: Text("У вас нет ни одного отчёта!!!"),
            //             );
            //           } else if (reportState is FinancialReportInitial) {
            //             reportBloc.add(
            //               GetReportsByBranchEvent(
            //                 selectionState.selectedBranch!.branchId,
            //               ),
            //             );
            //             Navigator.pushReplacementNamed(
            //               context,
            //               '/dashboard_page',
            //             );
            //           }
            //           return Center(child: CircularProgressIndicator());
            //         },
            //       );
            //     } else if (selectionState.selectedReport != null) {
            //       return SelectionTitle(
            //         title: "Отчёт",
            //         selection: selectionState.selectedReport!.reportId,
            //         onTap: () {
            //           selectionBloc.add(ClearReport());
            //         },
            //       );
            //     }
            //     return SizedBox(height: 0);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
