import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';

class ScanNotePage extends StatefulWidget {
  const ScanNotePage({Key? key}) : super(key: key);

  @override
  State<ScanNotePage> createState() => _ScanNotePageState();
}

class _ScanNotePageState extends State<ScanNotePage> {
  var _loading = false;
  final _noteCubit = NoteCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan note')),
      body: BlocListener(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is NoteLoading);

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }
        },
        child: LoadingOverlay(
          isLoading: _loading,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
