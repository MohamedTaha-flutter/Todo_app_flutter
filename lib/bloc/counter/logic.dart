import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/counter/state.dart';

class CounterCubit extends Cubit<CounterState>
{

  CounterCubit(): super(InitState());

  static CounterCubit getObject (context) => BlocProvider.of(context) ;
  int c = 0 ;
  void plusC()
  {
    c++ ;
    emit(Plus());
  }
  void munsC()
  {
    c-- ;
    emit(Muns()) ;
  }
  void ResetC()
  {
    c = 0  ;
    emit(Reset()) ;
  }

}