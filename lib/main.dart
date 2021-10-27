import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'presentation/widgets/app_widget.dart';

///
/// - [BlocProvider] it is a widget that provides a bloc/cubit for all the widgets
///   that are underneath it in the widgets tree
/// 
/// - [BlocProvider] it provides only one instance of that bloc/cubit
/// 
/// - [BlocProvider] the bloc/cubit that it provides us with is lazy which means
///   that block doesn't work till the ui requests it
/// 
/// - [BlocBuilder] is the one that asks the [BlocProvider] to send the bloc to it
/// 
/// - [BlocBuilder] the place for this one is in the ui, the widget tree
/// 
/// - [BlocBuilder] this is responsible for rebuild the ui every time 
///   the state changes
/// 
/// - [BlocBuilder] this is better be around only the widget that i wanna it 
///   to rebuild, instead of rebuilding the entire tree
/// 
/// - [BlocListener] this doesn't rebuild the ui, it listen to the state change
///   and it listen to that change only once
/// 
/// - [BlocConsumer] this is a mix between the [BlocListener] and the [BlocBuilder]
/// 
/// - [BlocConsumer] i need this if i wanna rebuild the ui or wanna do something
///   after the state change
/// 

void main() => runApp(
    AppWidget(appRouter: AppRouter(),)
);