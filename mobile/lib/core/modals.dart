import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/extensions.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/app.text.field.dart';
import 'package:lottie/lottie.dart';

import '../features/shared/presentation/widgets/animated.column.dart';
import 'constants.dart';

/// create folder sheet
/// reference: https://stackoverflow.com/questions/52414629/how-to-update-state-of-a-modalbottomsheet-in-flutter
Future<NoteFolder?> createFolder(BuildContext context) async {
  final controller = TextEditingController();
  NoteFolder? folder;
  var selectedFolderType = FolderType.public;

  return await showModalBottomSheet<NoteFolder>(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              24, 16, 24, context.mediaQuery.viewInsets.bottom),
          child: AnimatedColumn(
            animateType: AnimateType.slideUp,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create your new folder',
                style: context.theme.textTheme.subtitle1
                    ?.copyWith(color: context.colorScheme.secondaryContainer),
              ),
              const SizedBox(height: 24),
              AppTextField(
                'Label',
                controller: controller,
                onChange: (input) {
                  folder ??= input == null || input.isEmpty
                      ? null
                      : NoteFolder(
                          id: '', label: '', updatedAt: DateTime.now());
                  folder = folder?.copyWith(label: input?.trim());
                },
                capitalization: TextCapitalization.words,
              ),
              AppDropdownField(
                label: 'Type',
                values: FolderType.values.map((e) => e.name).toList(),
                onSelected: (type) => setState(() {
                  selectedFolderType = FolderType.values
                      .firstWhere((element) => element.name == type);
                  folder = folder?.copyWith(type: selectedFolderType);
                }),
                current: selectedFolderType.name,
              ),
              const SizedBox(height: 40),
              SafeArea(
                top: false,
                child: FloatingActionButton.extended(
                  heroTag: kHomeFabTag,
                  onPressed: () => context.router.pop(
                      folder?.label == null || folder!.label.isEmpty
                          ? null
                          : folder),
                  icon: const Icon(TablerIcons.folder),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Create'),
                  ),
                  backgroundColor: context.colorScheme.secondary,
                  foregroundColor: context.colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// app details
Future<void> showAppDetailsSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AnimatedColumn(
            animateType: AnimateType.slideUp,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: kAppLoadingAnimation,
                child: LottieBuilder.asset(
                  kAppLoadingAnimation,
                  height: context.height * 0.2,
                  repeat: false,
                ),
              ),
              Text(
                kAppName,
                style: context.theme.textTheme.headline4?.copyWith(
                  color: context.colorScheme.secondaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                kAppDesc,
                style: context.theme.textTheme.subtitle2?.copyWith(
                  color: context.colorScheme.onSurface
                      .withOpacity(kEmphasisMedium),
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  kAppDevTeam,
                  style: context.theme.textTheme.caption?.copyWith(
                    color:
                        context.colorScheme.onSurface.withOpacity(kEmphasisLow),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              FloatingActionButton.extended(
                heroTag: kHomeFabTag,
                onPressed: context.router.pop,
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Dismiss'),
                ),
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// login sheet
Future<User?> showLoginSheet(BuildContext context, [String? tag]) async {
  final authCubit = context.read<AuthCubit>();

  return await showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => SafeArea(
        top: false,
        child: BlocConsumer(
          bloc: authCubit,
          listener: (context, state) {
            if (state is AuthSuccess<User>) {
              Navigator.of(context).pop(state.data);
            }
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedColumn(
              animateType: AnimateType.slideUp,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(kAppLoadingAnimation,
                    height: context.height * 0.25),
                Text(
                  'Sign in to get the best out of $kAppName',
                  style: context.theme.textTheme.subtitle1?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (state is AuthLoading) ...{
                  const CircularProgressIndicator.adaptive(),
                } else ...{
                  FloatingActionButton.extended(
                    heroTag: kOptionsFabTag,
                    onPressed: authCubit.login,
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Sign in with Google'),
                    ),
                    icon: const Icon(TablerIcons.brand_google),
                    enableFeedback: true,
                    backgroundColor: context.colorScheme.secondary,
                    foregroundColor: context.colorScheme.onSecondary,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
