import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/presentation/widgets/animated.column.dart';
import 'package:libello/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:libello/features/shared/presentation/widgets/tag.item.dart';

class NoteDetailsPage extends StatefulWidget {
  final Note note;

  const NoteDetailsPage({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late var _currentNote = widget.note;

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: LoadingOverlay(
          child: AnimationLimiter(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                  sliver: SliverToBoxAdapter(
                    child: AnimatedColumn(
                      animateType: AnimateType.slideLeft,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentNote.title,
                          style: context.theme.textTheme.headline4,
                        ),

                        /// labels
                        if (_currentNote.tags.isNotEmpty) ...{
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(
                              'Labels',
                              style: context.theme.textTheme.subtitle1
                                  ?.copyWith(
                                      color: context.colorScheme.secondary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Wrap(
                              runSpacing: 12,
                              spacing: 8,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: AnimationConfiguration.toStaggeredList(
                                duration: kListAnimationDuration,
                                childAnimationBuilder: (child) =>
                                    SlideAnimation(
                                  horizontalOffset: kListSlideOffset,
                                  child: FadeInAnimation(child: child),
                                ),
                                children: _currentNote.tags
                                    .map(
                                      (e) => TagItem(
                                        label: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        },

                        /// description
                        if (_currentNote.body.isNotEmpty) ...{
                          Text(
                            _currentNote.body,
                            style: context.theme.textTheme.bodyText1?.copyWith(
                                color: context.colorScheme.onBackground
                                    .withOpacity(kEmphasisMedium)),
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
      heroTag: kHomeFabTag,
      // todo
      onPressed: () {},
      label: const Text('Edit note'),
      icon: const Icon(TablerIcons.edit),
      foregroundColor: context.colorScheme.onSecondary,
      backgroundColor: context.colorScheme.secondary,

    ),
      );
}
