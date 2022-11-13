part of '../dashboard.dart';

class _DashboardLibraryTab extends StatefulWidget {
  const _DashboardLibraryTab({Key? key}) : super(key: key);

  @override
  State<_DashboardLibraryTab> createState() => _DashboardLibraryTabState();
}

class _DashboardLibraryTabState extends State<_DashboardLibraryTab> {
  var _loading = false, _notes = List<Note>.empty();
  late final _noteCubit = context.read<NoteCubit>();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _noteCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is NoteLoading);

          if (state is NoteError) {
            context.showSnackBar(state.message, context.colorScheme.error,
                context.colorScheme.onError);
          }

          if (state is NoteSuccess<List<Note>>) {
            setState(() => _notes = state.data);
          }
        },
        child: LoadingOverlay(
          isLoading: _loading,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              /// top app bar
              SliverAppBar(
                title: Text('Library',
                    style: TextStyle(color: context.colorScheme.onSecondary)),
                backgroundColor: context.colorScheme.secondary,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      RevealRoute(
                        page: const NoteSearchPage(),
                        maxRadius: context.height,
                        centerOffset:
                            Offset(context.width * 0.8, context.height * 0.1),
                      ),
                    ),
                    color: context.colorScheme.onSecondary,
                    icon: const Icon(TablerIcons.file_search),
                  ),
                  const SizedBox(width: 12),
                ],
              ),

              /// fixed
              SliverToBoxAdapter(
                child: FilledButtonWithIcon(
                  label: 'Fixed',
                  onTap: () => context.router.push(const CreateNoteRoute()),
                ),
              ),

              /// all
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () => context.router.push(NotesRoute(showAll: true)),
                  leading: const Icon(TablerIcons.script,
                      color: ThemeConfig.kOrange),
                  title: const Text('All files'),
                  trailing: Text(
                    '${_notes.length}',
                    style: context.theme.textTheme.subtitle2?.copyWith(
                      color: context.colorScheme.onBackground
                          .withOpacity(kEmphasisLow),
                    ),
                  ),
                ),
              ),

              /// archived notes
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () => context.router
                      .push(NotesRoute(status: NoteStatus.archived)),
                  leading: const Icon(TablerIcons.archive,
                      color: ThemeConfig.kGreen),
                  title: const Text('Archived'),
                  trailing: Text(
                    '${_notes.where((element) => element.status == NoteStatus.archived).length}',
                    style: context.theme.textTheme.subtitle2?.copyWith(
                      color: context.colorScheme.onBackground
                          .withOpacity(kEmphasisLow),
                    ),
                  ),
                ),
              ),

              /// deleted notes
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () => context.router
                      .push(NotesRoute(status: NoteStatus.deleted)),
                  leading:
                      const Icon(TablerIcons.trash, color: ThemeConfig.kRed),
                  title: const Text('Deleted'),
                  trailing: Text(
                    '${_notes.where((element) => element.status == NoteStatus.deleted).length}',
                    style: context.theme.textTheme.subtitle2?.copyWith(
                      color: context.colorScheme.onBackground
                          .withOpacity(kEmphasisLow),
                    ),
                  ),
                ),
              ),

              /// labels
              /// fixme: v2: show labels for notes
              if (!kIsReleased) ...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: FilledButtonWithIcon(
                      label: 'Labels',
                      // todo => add action
                      onTap: () => context.showSnackBar(kFeatureUnderDev),
                    ),
                  ),
                ),
                // important
                SliverToBoxAdapter(
                  child: ListTile(
                    onTap: () => context.router
                        .push(NotesRoute(type: NoteType.important)),
                    leading: const Icon(TablerIcons.star),
                    title: const Text('Important'),
                  ),
                ),
                // to-do list
                SliverToBoxAdapter(
                  child: ListTile(
                    onTap: () => context.router
                        .push(NotesRoute(type: NoteType.todoList)),
                    leading: const Icon(TablerIcons.list_check),
                    title: const Text('To-do List'),
                  ),
                ),
                // business
                SliverToBoxAdapter(
                  child: ListTile(
                    onTap: () => context.router
                        .push(NotesRoute(type: NoteType.business)),
                    leading: const Icon(TablerIcons.briefcase),
                    title: const Text('Business'),
                  ),
                ),
              },
            ],
          ),
        ),
      );
}
