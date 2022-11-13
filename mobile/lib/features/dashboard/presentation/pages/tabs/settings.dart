part of '../dashboard.dart';

class _DashboardSettingsTab extends StatefulWidget {
  const _DashboardSettingsTab({Key? key}) : super(key: key);

  @override
  State<_DashboardSettingsTab> createState() => _DashboardSettingsTabState();
}

class _DashboardSettingsTabState extends State<_DashboardSettingsTab> {
  var _loading = false, _notes = List<Note>.empty(growable: true);
  late final _authCubit = context.read<AuthCubit>();
  final _noteCubit = NoteCubit(), _todos = List<NoteTodo>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => _noteCubit.getNotes());
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _authCubit,
            listener: (context, state) {
              if (!mounted) return;

              setState(() => _loading = state is AuthLoading);

              if (state is AuthError) {
                context.showSnackBar(state.message, context.colorScheme.error,
                    context.colorScheme.onError);
              }

              if (state is AuthSuccess<String>) {
                context
                  ..showSnackBar(state.data)
                  ..router.pushAndPopUntil(const DashboardRoute(),
                      predicate: (_) => false);
              }
            },
          ),
          BlocListener(
            bloc: _noteCubit,
            listener: (context, state) {
              if (!mounted) return;

              setState(() => _loading = state is NoteLoading);

              if (state is NoteError) {
                context.showSnackBar(state.message, context.colorScheme.error,
                    context.colorScheme.onError);
              }

              if (state is NoteSuccess<List<Note>>) {
                _notes = state.data;
                _todos.clear();
                for (var note in _notes) {
                  if (note.todos.isNotEmpty) {
                    _todos.addAll(note.todos);
                  }
                }
                setState(() {});
              }
            },
          ),
        ],
        child: LoadingOverlay(
          isLoading: _loading,
          child: CustomScrollView(
            slivers: [
              /// top section
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(kRadiusLarge),
                      bottomLeft: Radius.circular(kRadiusLarge),
                    ),
                    color: context.colorScheme.secondary,
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: AnimatedColumn(
                    animateType: AnimateType.slideRight,
                    children: [
                      LottieBuilder.asset(
                        kAppLoadingAnimation,
                        height: context.height * 0.25,
                      ),
                      FutureBuilder<String?>(
                        future: _authCubit.displayName,
                        builder: (context, snapshot) => Text(
                          snapshot.hasData
                              ? '@${snapshot.data?.toLowerCase().replaceAll(' ', '_')}'
                              : '...',
                          style: context.theme.textTheme.headline4?.copyWith(
                              color: context.colorScheme.onSecondary),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$kAppName, ${kAppDesc.toLowerCase()}',
                        style: context.theme.textTheme.subtitle2?.copyWith(
                            color: context.colorScheme.onSecondary
                                .withOpacity(kEmphasisMedium)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FloatingActionButton.extended(
                        onPressed: _authCubit.logout,
                        backgroundColor: context.colorScheme.onSecondary,
                        foregroundColor: context.colorScheme.secondary,
                        label: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text('Sign out'),
                        ),
                        icon: const Icon(TablerIcons.logout),
                      ),
                    ],
                  ),
                ),
              ),

              /// bottom section
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 16),
                sliver: SliverMasonryGrid(
                  delegate: SliverChildListDelegate(
                    AnimationConfiguration.toStaggeredList(
                      duration: kGridAnimationDuration,
                      childAnimationBuilder: (child) => SlideAnimation(
                        horizontalOffset: kListSlideOffset,
                        child: FadeInAnimation(child: child),
                      ),
                      children: [
                        _buildStats(
                            label: 'Tasks',
                            value: _todos.length,
                            onTap: () => context.router.push(NotesRoute(
                                showNotesWithTodos: true, title: 'Tasks'))),
                        _buildStats(
                            label: 'Notes',
                            value: _notes.length,
                            onTap: () =>
                                context.router.push(NotesRoute(showAll: true))),
                        _buildStats(
                            label: 'Archived',
                            value: _notes
                                .where((note) =>
                                    note.status == NoteStatus.archived)
                                .length,
                            onTap: () => context.router.push(NotesRoute(
                                status: NoteStatus.archived,
                                title: 'Archived'))),
                      ],
                    ),
                  ),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 8,
                ),
              ),

              /// bottom
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                sliver: SliverToBoxAdapter(
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) => AnimatedColumn(
                      animateType: AnimateType.slideUp,
                      duration: kContentAnimationDuration.inMilliseconds,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(),
                        Text(
                          snapshot.hasData
                              ? 'v${snapshot.data?.version}'
                              : '...',
                          textAlign: TextAlign.center,
                          style: context.theme.textTheme.headline6?.copyWith(
                            color: context.colorScheme.onBackground
                                .withOpacity(kEmphasisMedium),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.hasData
                              ? kAppDevTeam
                              : 'getting installed version...',
                          textAlign: TextAlign.center,
                          style: context.theme.textTheme.subtitle2?.copyWith(
                            color: context.colorScheme.onBackground
                                .withOpacity(kEmphasisLow),
                          ),
                        ),

                        /// versioning
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 24),
                          child: FutureBuilder<PackageInfo>(
                              future: PackageInfo.fromPlatform(),
                              builder: (context, snapshot) {
                                return FloatingActionButton.extended(
                                  heroTag: 'view-licenses',
                                  label: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    child: Text('View licenses'),
                                  ),
                                  icon: const Icon(TablerIcons.license),
                                  enableFeedback: true,
                                  elevation: 0,
                                  onPressed: () => _showLicenses(
                                      snapshot.hasData
                                          ? snapshot.data?.version
                                          : null),
                                  backgroundColor: context.colorScheme.secondary
                                      .withOpacity(kEmphasisLowest),
                                  foregroundColor:
                                      context.colorScheme.secondary,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: context.height * 0.17),
              ),
            ],
          ),
        ),
      );

  Widget _buildStats(
          {required String label, required int value, Function()? onTap}) =>
      ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color:
                    context.colorScheme.secondary.withOpacity(kEmphasisLowest),
                border: Border.all(
                  color: context.theme.disabledColor.withOpacity(kEmphasisLow),
                ),
                borderRadius: BorderRadius.circular(kRadiusSmall),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$value',
                    style: context.theme.textTheme.headline5
                        ?.copyWith(color: context.colorScheme.secondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: context.theme.textTheme.subtitle1?.copyWith(
                        color: context.colorScheme.onSurface
                            .withOpacity(kEmphasisMedium)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _showLicenses([String? version]) => Navigator.of(context).push(
        RevealRoute(
          page: LicensePage(
            applicationName: kAppName,
            applicationIcon: LottieBuilder.asset(
              kAppLoadingAnimation,
              repeat: false,
              height: context.height * 0.2,
            ),
            applicationLegalese: kAppDevTeam,
            applicationVersion: version ?? '0.0.0-alpha',
          ),
          maxRadius: context.height * 2,
          centerOffset: Offset(context.width * 0.5, context.height * 0.7),
        ),
      );
}
