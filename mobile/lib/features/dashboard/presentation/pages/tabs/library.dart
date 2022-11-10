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
            context.showSnackBar(state.message);
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
              SliverToBoxAdapter(
                child: AppBar(
                  title: const Text('Library'),
                  actions: [
                    IconButton(
                      onPressed: () => context.showSnackBar(kFeatureUnderDev),
                      icon: const Icon(TablerIcons.search),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),

              /// weekly plan
              SliverToBoxAdapter(
                child: GestureDetector(
                  // todo => create new note or reminder for the week
                  onTap: () => context.showSnackBar(kFeatureUnderDev),
                  child: Container(
                    width: context.width,
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// top
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// left
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kRadiusMedium),
                                      border: Border.all(
                                          width: 1.5,
                                          color:
                                              context.colorScheme.onSecondary),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(TablerIcons.star,
                                            color: context
                                                .colorScheme.onSecondary),
                                        const SizedBox(width: 8),
                                        Text(
                                          'importans',
                                          style: context
                                              .theme.textTheme.subtitle1
                                              ?.copyWith(
                                            color:
                                                context.colorScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kRadiusMedium),
                                      border: Border.all(
                                          width: 1.5,
                                          color:
                                              context.colorScheme.onSecondary),
                                    ),
                                    child: Icon(TablerIcons.arrow_move_up,
                                        color: context.colorScheme.onSecondary),
                                  ),
                                ],
                              ),
                            ),

                            /// right
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  /// progress
                                  Positioned.fill(
                                    child: RotatedBox(
                                      quarterTurns: 2,
                                      child: CircularProgressIndicator(
                                        value: _notes.isEmpty
                                            ? 0
                                            : ((_notes
                                                    .where((element) =>
                                                        element.completed)
                                                    .toList()
                                                    .length) /
                                                _notes.length),
                                        strokeWidth: 5,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            context.colorScheme.onSecondary),
                                      ),
                                    ),
                                  ),

                                  /// value
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${_notes.isEmpty ? 0 : ((_notes.where((element) => element.completed).toList().length) / _notes.length) * 100}%',
                                        style: context.theme.textTheme.subtitle1
                                            ?.copyWith(
                                          color:
                                              context.colorScheme.onSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// bottom
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Plan for the week',
                                style: context.theme.textTheme.headline5
                                    ?.copyWith(
                                        color: context.colorScheme.onSecondary),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: Icon(Icons.keyboard_backspace,
                                  color: context.colorScheme.onSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// fixed
              SliverToBoxAdapter(
                child: FilledButtonWithIcon(
                  label: 'Fixed',
                  onTap: () => context.router.push(const CreateNoteRoute()),
                ),
              ),
              // all files
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
              // archived files
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
              // deleted files
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: FilledButtonWithIcon(
                    label: 'Labels',
                    // todo => add action
                    onTap: () => context.showSnackBar(kFeatureUnderDev),
                  ),
                ),
              ),
              //
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () =>
                      context.router.push(NotesRoute(type: NoteType.important)),
                  leading: const Icon(TablerIcons.star),
                  title: const Text('Important'),
                ),
              ),
              // to-do list
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () =>
                      context.router.push(NotesRoute(type: NoteType.todoList)),
                  leading: const Icon(TablerIcons.list_check),
                  title: const Text('To-do List'),
                ),
              ),
              // business
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () =>
                      context.router.push(NotesRoute(type: NoteType.business)),
                  leading: const Icon(TablerIcons.businessplan),
                  title: const Text('Business'),
                ),
              ),
            ],
          ),
        ),
      );
}
