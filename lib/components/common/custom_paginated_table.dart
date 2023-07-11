import 'package:flutter/material.dart';

var sortIndex = 0;
var sortAsc = true;

class CustomPaginatedTable extends StatelessWidget {
  const CustomPaginatedTable({
    super.key,
    this.titleList,
    required this.source,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    this.onRowsPerPageChanged,
    this.horizontal,
    this.horizontalMargin = 31,
    this.dataRowMaxHeight,
  });

  final List<String>? titleList;
  final DataTableSource source;
  final int rowsPerPage;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final ScrollController? horizontal;
  final double horizontalMargin;
  final double? dataRowMaxHeight;
  List<DataColumn> get columns => List.generate(
        titleList?.length ?? 0,
        (index) => DataColumn(
          label: Text(titleList?[index] ?? ""),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: PaginatedDataTable(
            dataRowMaxHeight: dataRowMaxHeight,
            source: source,
            showFirstLastButtons: true,
            columns: columns,
            onRowsPerPageChanged: onRowsPerPageChanged,
            columnSpacing: 74,
            horizontalMargin: horizontalMargin,
            rowsPerPage: rowsPerPage == 0 ? 1 : rowsPerPage,
            sortAscending: sortAsc,
            sortColumnIndex: sortIndex,
          ),
        ),
      ),
    );
  }
}
