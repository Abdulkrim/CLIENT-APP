import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/base_bloc.dart';
import 'package:merchant_dashboard/feature/tables/data/repository/table_repository.dart';

import '../../../../../injection.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../data/models/entity/table.dart';

part 'table_state.dart';

@injectable
class TableCubit extends BaseCubit<TableState> {
  final ITableRepository _tableRepository;

  TableCubit(this._tableRepository) : super(TableInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        getAllTables();
      }
    });
  }

  List<Table> tables = [];

  void getAllTables() => invoke(() async {
        emit(const GetTableStates(isLoading: true));
        final result = await _tableRepository.getTables();

        result.fold((left) => emit(GetTableStates(errorMessage: left.errorMessage)), (right) {
          tables = right;
          emit(const GetTableStates(isSuccess: true));
        });
      });

  void addTable({required String tableName, required String tableNumber, required String tableCapacity}) async {
    emit(const EditTableStates(isLoading: true));
    final result = await _tableRepository.addTable(tableName: tableName, tableNumber: tableNumber, tableCapacity: tableCapacity);

    result.fold((left) => emit(EditTableStates(errorMessage: left.errorMessage)), (right) {
      emit(const EditTableStates(successMessage: 'Table Added Successfully!'));
      getAllTables();
    });
  }

  void editTable(
      {required int tableId, required String tableName, required String tableNumber, required String tableCapacity}) async {
    emit(const EditTableStates(isLoading: true));
    final result = await _tableRepository.editTable(
        tableId: tableId, tableName: tableName, tableNumber: tableNumber, tableCapacity: tableCapacity);

    result.fold((left) => emit(EditTableStates(errorMessage: left.errorMessage)), (right) {
      emit(const EditTableStates(successMessage: 'Table Edited Successfully!'));
      getAllTables();
    });
  }

  void deleteTable(int tableId) async {
    emit(const EditTableStates(isLoading: true));
    final result = await _tableRepository.deleteTable(tableId);

    result.fold((left) => emit(EditTableStates(errorMessage: left.errorMessage)), (right) {
      emit(const EditTableStates(successMessage: 'Table Deleted Successfully!'));
      getAllTables();
    });
  }
}
