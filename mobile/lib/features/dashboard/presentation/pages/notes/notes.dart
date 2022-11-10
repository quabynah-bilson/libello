import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';

class NotesPage extends StatefulWidget {
  final NoteType? type;
  final NoteStatus? status;
  final bool showAll;

  const NotesPage({Key? key, this.type, this.status, this.showAll = false})
      : assert(status != null || type != null || showAll),
        super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  var _loading = false, _notes = List<Note>.empty();
  late final _noteCubit = context.read<NoteCubit>();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is NoteLoading);

          if (state is NoteError) {
            context.showSnackBar(state.message);
          }

          if (state is NoteSuccess<List<Note>>) {
            if (widget.showAll) _notes = state.data;
            if (widget.type != null) {
              _notes = state.data
                  .where((element) => element.type == widget.type)
                  .toList();
            }
            if (widget.status != null) {
              _notes = state.data
                  .where((element) => element.status == widget.status)
                  .toList();
            }
            setState(() {});
          }
        },
        child: LoadingOverlay(
          isLoading: _loading,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                title: Text('My notes'),
              ),
              SliverToBoxAdapter(
                child: Center(child: Text('You have ${_notes.length} notes')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
