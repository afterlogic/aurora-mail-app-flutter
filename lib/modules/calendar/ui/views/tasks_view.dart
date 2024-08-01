import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/tasks/tasks_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/activity_filter_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late final TasksBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TasksBloc>(context);
    _bloc.add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          const Text(
                            'Tasks',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          BlocBuilder<TasksBloc, TasksState>(
                            bloc: _bloc,
                            builder: (context, state) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.filter_alt_outlined),
                                onPressed: () {
                                  ActivityFilterDialog.show(context,
                                          selectedFilter: state.filter)
                                      .then((value) {
                                    if (value == null) return;
                                    _bloc.add(UpdateFilter(value));
                                  });
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<TasksBloc, TasksState>(
                        bloc: _bloc,
                        builder: (context, state) {
                          if (state.tasks == null) {
                            return const SizedBox.shrink();
                          }
                          return _TaskList(
                            tasks: state.tasks!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class _TaskList extends StatelessWidget {
  final List<ViewTask> tasks;

  const _TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: TaskWidget(task: tasks[index]),
        );
      },
    );
  }
}
