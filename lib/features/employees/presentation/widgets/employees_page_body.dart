import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/utils/app_styles.dart';
import 'package:rest_flow/core/widgets/custom_search_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../core/widgets/filter_tabs_bar.dart';
import '../../domain/entities/employee_status.dart';
import '../cubit/employees_cubit.dart';
import '../cubit/employees_state.dart';
import '../pages/add_employee_page.dart';
import '../pages/edit_employee_page.dart';
import 'employee_item_card.dart';

class EmployeesPageBody extends StatefulWidget {
  const EmployeesPageBody({super.key});

  @override
  State<EmployeesPageBody> createState() => _EmployeesPageBodyState();
}

class _EmployeesPageBodyState extends State<EmployeesPageBody> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<EmployeesCubit>().fetchEmployees(
          search: query.isNotEmpty ? query : null,
          status: _getStatusFromTabIndex(_selectedTabIndex),
        );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    context.read<EmployeesCubit>().fetchEmployees(
          search:
              _searchController.text.isNotEmpty ? _searchController.text : null,
          status: _getStatusFromTabIndex(index),
        );
  }

  EmployeeStatus? _getStatusFromTabIndex(int index) {
    if (index == 1) return EmployeeStatus.active;
    if (index == 2) return EmployeeStatus.inactive;
    return null;
  }

  Future<void> _refresh() async {
    await context.read<EmployeesCubit>().fetchEmployees(
          search:
              _searchController.text.isNotEmpty ? _searchController.text : null,
          status: _getStatusFromTabIndex(_selectedTabIndex),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEmployeePage(),
            ),
          ).then((value) {
            if (value == true) {
              _refresh();
            }
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: 'Employees',
              showBackButton: true,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _EmployeesStickyHeaderDelegate(
                height: 148.0,
                child: Container(
                  color: AppColors.backgroundLight,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      CustomSearchBar(
                        hintText: 'Search employees...',
                        onChanged: _onSearch,
                      ),
                      const SizedBox(height: 16),
                      FilterTabsBar<EmployeeStatus?>(
                        items: const [
                          FilterTabItem(
                              label: 'Active', value: EmployeeStatus.active),
                          FilterTabItem(
                              label: 'Inactive', value: EmployeeStatus.inactive),
                        ],
                        selectedValue: _getStatusFromTabIndex(_selectedTabIndex),
                        onChanged: (status) {
                          int index = 0;
                          if (status == EmployeeStatus.active) index = 1;
                          if (status == EmployeeStatus.inactive) index = 2;
                          _onTabSelected(index);
                        },
                        allLabel: 'All',
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<EmployeesCubit, EmployeesState>(
              builder: (context, state) {
                if (state is EmployeesLoading &&
                    state.action == EmployeesAction.fetchList) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Skeletonizer(
                            enabled: true,
                            child: EmployeeItemCard(
                              id: '',
                              fullName: 'Employee Name Placeholder',
                              email: 'employee@placeholder.com',
                              role: 'Manager',
                              status: EmployeeStatus.active,
                              onTap: () {},
                              onEdit: () {},
                            ),
                          ),
                        ),
                        childCount: 5,
                      ),
                    ),
                  );
                }

                if (state is EmployeesFailure &&
                    state.action == EmployeesAction.fetchList) {
                  return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          state.failure.message,
                          style: AppStyles.body2Medium14(context).copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ));
                }

                if (state is EmployeesListSuccess) {
                  if (state.employees.isEmpty) {
                    return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No employees found.'),
                        ));
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final employee = state.employees[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EmployeeItemCard(
                              id: employee.id,
                              fullName: employee.fullName,
                              email: employee.email,
                              role: employee.role,
                              status: employee.status,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditEmployeePage(employeeId: employee.id),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    _refresh();
                                  }
                                });
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditEmployeePage(employeeId: employee.id),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    _refresh();
                                  }
                                });
                              },
                            ),
                          );
                        },
                        childCount: state.employees.length,
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployeesStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _EmployeesStickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _EmployeesStickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
