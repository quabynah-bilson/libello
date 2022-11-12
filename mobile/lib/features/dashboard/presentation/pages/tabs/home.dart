part of '../dashboard.dart';

class _DashboardHomeTab extends StatefulWidget {
  const _DashboardHomeTab({Key? key}) : super(key: key);

  @override
  State<_DashboardHomeTab> createState() => _DashboardHomeTabState();
}

class _DashboardHomeTabState extends State<_DashboardHomeTab> {
  var _loading = true,
      touchedIndex = -1,
      _greeting = 'Welcome to\n$kAppName',
      _notes = List<Note>.empty(),
      _statsTodos = List<NoteTodo>.empty();
  final animDuration = const Duration(milliseconds: 250),
      _authCubit = AuthCubit();
  late final Timer _timer;
  late final _noteCubit = context.read<NoteCubit>();

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (!mounted || !timer.isActive) return;
        _greeting = await generateGreeting(context);
        setState(() {});
      });
      _noteCubit.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context,
        statusBarBrightness: context.invertedThemeBrightness);

    return BlocListener(
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
          _statsTodos = List<NoteTodo>.empty(growable: true);
          for (var note in state.data) {
            _statsTodos.addAll(note.todos);
          }
        }
      },
      child: LoadingOverlay(
        isLoading: _loading,
        child: AnimationLimiter(
          child: CustomScrollView(
            shrinkWrap: true,
            clipBehavior: Clip.hardEdge,
            slivers: [
              /// top section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(kRadiusMedium),
                      bottomRight: Radius.circular(kRadiusMedium),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// user profile
                            IconButton(
                              onPressed: () =>
                                  // todo => show profile
                                  context.showSnackBar(kFeatureUnderDev),
                              icon: const Icon(TablerIcons.user),
                              color: context.colorScheme.onPrimary,
                            ),

                            /// notifications
                            IconButton(
                              onPressed: () =>
                                  // todo => show notifications
                                  context.showSnackBar(kFeatureUnderDev),
                              icon: const Icon(TablerIcons.bell),
                              color: context.colorScheme.onPrimary,
                            ),
                          ],
                        ),

                        /// greeting
                        const SizedBox(height: 28),
                        StreamBuilder<bool>(
                          stream: _authCubit.loginStatus,
                          initialData: false,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData &&
                                snapshot.data!) {
                              return Text(
                                '${_greeting.replaceAll('!', ',')}${_authCubit.displayName}',
                                style:
                                    context.theme.textTheme.headline2?.copyWith(
                                  color: context.colorScheme.onPrimary,
                                ),
                              );
                            }
                            return Text(
                              _greeting,
                              style:
                                  context.theme.textTheme.headline2?.copyWith(
                                color: context.colorScheme.onPrimary,
                              ),
                            );
                          },
                        ),

                        /// notes counter
                        const SizedBox(height: 24),
                        if (_notes.isNotEmpty) ...{
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${_statsTodos.where((note) => note.completed).toList().length}',
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                                const TextSpan(text: ' out of '),
                                TextSpan(
                                  text: '${_statsTodos.length}',
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                                const TextSpan(text: ' tasks completed'),
                              ],
                            ),
                            style: context.theme.textTheme.subtitle1?.copyWith(
                              color: context.colorScheme.onPrimary
                                  .withOpacity(kEmphasisLow),
                            ),
                          ),
                        } else ...{
                          Text(
                            'You have no notes at the moment',
                            style: context.theme.textTheme.subtitle1?.copyWith(
                              color: context.colorScheme.onPrimary
                                  .withOpacity(kEmphasisLow),
                            ),
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ),

              /// quick tips
              SliverPadding(
                padding: const EdgeInsets.only(top: 28, left: 20, bottom: 20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Quick Tips',
                    style: context.theme.textTheme.subtitle1
                        ?.copyWith(color: context.colorScheme.onBackground),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: context.width,
                  height: context.height * 0.15,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      /// scan note
                      QuickTipCard(
                        topLeftIcon: TablerIcons.camera,
                        topRightIcon: Icons.check_circle,
                        title: kScanNoteTitle,
                        subtitle: kScanNoteDescription,
                        // todo => scan note
                        onTap: () => context.showSnackBar(kFeatureUnderDev),
                      ),

                      /// scan note
                      const SizedBox(width: 16),
                      QuickTipCard(
                        topLeftIcon: TablerIcons.pencil,
                        topRightIcon: Icons.check_circle,
                        title: kDrawNoteTitle,
                        subtitle: kDrawNoteDescription,

                        /// todo => draw note
                        onTap: () => context.showSnackBar(kFeatureUnderDev),
                        backgroundColor: context.colorScheme.surface,
                        foregroundColor: context.colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ),

              /// recent notes
              SliverPadding(
                padding: const EdgeInsets.only(top: 28, left: 20, bottom: 20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Your recent notes',
                    style: context.theme.textTheme.subtitle1
                        ?.copyWith(color: context.colorScheme.onBackground),
                  ),
                ),
              ),
              if (!_loading) ...{
                if (_notes.isEmpty) ...{
                  SliverToBoxAdapter(
                    child: AnimatedColumn(
                      children: [
                        LottieBuilder.asset(
                          kAppLoadingAnimation,
                          repeat: false,
                          height: context.width * 0.4,
                          width: context.width * 0.4,
                        ),
                        Text(
                          'You have no recent notes',
                          style: context.theme.textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                } else ...{
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                    sliver: SliverMasonryGrid(
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: index.isEven ? 1 : 2,
                          duration: kListAnimationDuration,
                          child: SlideAnimation(
                            verticalOffset: kListSlideOffset,
                            child: FadeInAnimation(
                              child: NoteTile(note: _notes[index]),
                            ),
                          ),
                        ),
                        childCount: _notes.length,
                      ),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                    ),
                  ),
                },
              },
              SliverToBoxAdapter(
                child: SizedBox(height: context.height * 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// generate greeting
  Future<String> generateGreeting(BuildContext context) async {
    var now = TimeOfDay.now(), timestamp = DateTime.now(), greeting = '';
    if (now.period == DayPeriod.am) {
      greeting = 'Good\nmorning';
    } else if (timestamp.hour >= 12 && timestamp.hour < 16) {
      greeting = 'Good\nafternoon';
    } else if (timestamp.hour >= 16 && timestamp.hour < 21) {
      greeting = 'Good\nevening';
    } else {
      greeting = 'Goodnight';
    }

    return 'Hello, ${(await _authCubit.displayName) ?? greeting}!';
  }
}
