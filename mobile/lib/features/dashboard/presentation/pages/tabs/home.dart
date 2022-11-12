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
      _notes = List<Note>.empty();
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
      _noteCubit.getNotes();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (!mounted || !timer.isActive) return;
        _greeting = await generateGreeting(context);
        setState(() {});
      });
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
                                      '${_notes.where((note) => note.status == NoteStatus.regular).toList().length}',
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                                const TextSpan(text: ' out of '),
                                TextSpan(
                                  text: '${_notes.length}',
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                                const TextSpan(text: ' notes today'),
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
                SliverToBoxAdapter(
                    child: SizedBox(height: context.height * 0.1)),
              } else ...{
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      duration: kListAnimationDuration,
                      child: SlideAnimation(
                        verticalOffset: kListSlideOffset,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            // todo => show note details
                            onTap: () => context.showSnackBar(kFeatureUnderDev),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                                child: Container(
                                  // height: 200,
                                  clipBehavior: Clip.hardEdge,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 20, 16, 24),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface
                                        .withOpacity(kEmphasisMedium),
                                    borderRadius:
                                        BorderRadius.circular(kRadiusMedium),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// title
                                      Text(
                                        'Remind me to travel to the next location',
                                        style: context.theme.textTheme.subtitle1
                                            ?.copyWith(
                                                color: context
                                                    .colorScheme.secondary),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '~${wordCount(kSampleDesc)} words',
                                        style: context.theme.textTheme.caption
                                            ?.copyWith(
                                          color: context.colorScheme.onSurface
                                              .withOpacity(kEmphasisMedium),
                                        ),
                                      ),

                                      /// description / body
                                      Divider(
                                        height: 24,
                                        color: context.theme.disabledColor
                                            .withOpacity(kEmphasisLowest),
                                      ),
                                      Text(
                                        kSampleDesc,
                                        style: context.theme.textTheme.subtitle2
                                            ?.copyWith(
                                          color: context.colorScheme.onSurface
                                              .withOpacity(kEmphasisMedium),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 24),

                                      /// tag
                                      Wrap(
                                        runSpacing: 12,
                                        spacing: 8,
                                        children: List.generate(
                                          3,
                                          (index) => Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: context
                                                    .theme.disabledColor
                                                    .withOpacity(kEmphasisLow),
                                              ),
                                              color: context.theme.disabledColor
                                                  .withOpacity(kEmphasisLowest),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadiusSmall),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  TablerIcons.tag,
                                                  size: 18,
                                                  color: context
                                                      .colorScheme.onSurface
                                                      .withOpacity(
                                                          kEmphasisMedium),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Art',
                                                  style: context
                                                      .theme.textTheme.caption
                                                      ?.copyWith(
                                                    color: context
                                                        .colorScheme.onSurface
                                                        .withOpacity(
                                                            kEmphasisMedium),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      /// timestamp
                                      const SizedBox(height: 16),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          DateTime.now()
                                              .format('d M, y (g:i a)'),
                                          style: context
                                              .theme.textTheme.overline
                                              ?.copyWith(
                                            color: context.colorScheme.onSurface
                                                .withOpacity(kEmphasisMedium),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 12,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  // todo => add line chart values from database
  List<BarChartGroupData> showingGroups() => List.generate(
        20,
        (i) => makeGroupData(i, ++i * Random().nextDouble(),
            isTouched: i == touchedIndex),
      );

  BarChartGroupData makeGroupData(int x, double y,
          {bool isTouched = false, double width = 2}) =>
      BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: isTouched ? y + 1 : y,
            color: isTouched
                ? context.colorScheme.primary
                : context.colorScheme.secondary,
            width: width,
            borderSide: isTouched
                ? BorderSide(color: context.colorScheme.secondary)
                : const BorderSide(color: Colors.white, width: 0),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: context.colorScheme.background,
            ),
          ),
        ],
      );

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
