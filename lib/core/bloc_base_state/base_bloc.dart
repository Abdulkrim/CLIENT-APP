import 'package:bloc/bloc.dart';

class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  @override
  void add(E event) => /* getIt<MainScreenBloc>().selectedMerchantBranch.hasData ? */
      super.add(event); /*  : null; */
}

class BaseCubit<S> extends Cubit<S> {
  BaseCubit(super.initialState);

  void invoke(Function operation) => /*  (!getIt<MainScreenBloc>().selectedMerchantBranch.hasData) ? null : */
      operation();
}
