part of '../dashboard.dart';

class _DashboardFolderTab extends StatefulWidget {
  const _DashboardFolderTab({Key? key}) : super(key: key);

  @override
  State<_DashboardFolderTab> createState() => _DashboardFolderTabState();
}

class _DashboardFolderTabState extends State<_DashboardFolderTab> {
  var _loading = true, _folders = List<NoteFolder>.empty();
  final _noteCubit = NoteCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(_noteCubit.getNoteFolders);
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

          if (state is NoteSuccess<List<NoteFolder>>) {
            setState(() => _folders = state.data);
          }
        },
        child: LoadingOverlay(
          isLoading: _loading,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              /// header bar
              const SliverAppBar(title: Text('Folders')),

              /// action to create new folder
              SliverToBoxAdapter(
                child: FilledButtonWithIcon(
                  label: 'Create new folder',
                  onTap: () async {
                    var noteFolder = await createFolder(context);
                    if (noteFolder == null) return;
                    _noteCubit.createFolder(noteFolder);
                  },
                ),
              ),

              /// filters
              SliverToBoxAdapter(
                child: SizedBox(
                  width: context.width,
                  height: kToolbarHeight * 2,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Center(
                        child: CustomChip(
                          onTap: () =>
                              context.router.push(NotesRoute(showAll: true)),
                          leadingIcon: TablerIcons.filter,
                          label: 'filter',
                        ),
                      ),
                      Center(
                        child: CustomChip(
                          onTap: () => context.router
                              .push(NotesRoute(type: NoteType.important)),
                          leadingIcon: TablerIcons.star,
                          label: 'important',
                        ),
                      ),
                      Center(
                        child: CustomChip(
                          onTap: () => context.router
                              .push(NotesRoute(type: NoteType.todoList)),
                          leadingIcon: TablerIcons.list_check,
                          label: 'to-do list',
                        ),
                      ),
                      Center(
                        child: CustomChip(
                          onTap: () => context.router
                              .push(NotesRoute(type: NoteType.business)),
                          leadingIcon: TablerIcons.briefcase,
                          label: 'business',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// folders
              SliverToBoxAdapter(
                child: _folders.isEmpty
                    ? Center(
                        child: SizedBox(
                          height: context.height * 0.4,
                          child: GestureDetector(
                            onTap: () async {
                              var noteFolder = await createFolder(context);
                              if (noteFolder == null) return;
                              _noteCubit.createFolder(noteFolder);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  TablerIcons.folder_minus,
                                  size: context.width * 0.2,
                                  color: context.colorScheme.secondary,
                                ),
                                const SizedBox(height: 24),
                                Text('Create a new folder',
                                    style: context.theme.textTheme.headline6),
                                const SizedBox(height: 8),
                                Text(
                                  'You have no new folders available',
                                  style: context.theme.textTheme.subtitle1
                                      ?.copyWith(
                                    color: context.colorScheme.onBackground
                                        .withOpacity(kEmphasisMedium),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : AnimationLimiter(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: kListAnimationDuration,
                            child: SlideAnimation(
                              horizontalOffset: kListSlideOffset,
                              child: FadeInAnimation(
                                child: FolderTile(folder: _folders[index]),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: _folders.length,
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
}
