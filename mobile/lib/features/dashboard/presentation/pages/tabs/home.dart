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
                          }),

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

            /// monthly report
            SliverPadding(
              padding: const EdgeInsets.only(top: 28, left: 20, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Your monthly report',
                  style: context.theme.textTheme.subtitle1
                      ?.copyWith(color: context.colorScheme.onBackground),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: context.width,
                height: context.height * 0.22,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(kRadiusSmall),
                ),
                child: Row(
                  children: [
                    /// progress
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // todo => show progress
                        Text(
                          '68/90',
                          style: context.theme.textTheme.headline4?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tasks done',
                          style: context.theme.textTheme.subtitle2?.copyWith(
                            color: context.colorScheme.onSurface
                                .withOpacity(kEmphasisMedium),
                          ),
                        ),
                      ],
                    ),

                    /// chart
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRadiusSmall),
                        ),
                        child: BarChart(
                          BarChartData(
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups: showingGroups(),
                            gridData: FlGridData(show: false),
                          ),
                          swapAnimationDuration:
                              const Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
