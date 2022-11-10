import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/extensions.dart';

import '../manager/auth_cubit.dart';

class LoginDialog extends ModalRoute<User> {
  final Color? backgroundColor;
  final AuthCubit cubit;

  LoginDialog(this.cubit, {this.backgroundColor});

  @override
  Color? get barrierColor => backgroundColor;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Center(
            child: Container(
              width: context.width * 0.85,
              height: context.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(kRadiusMedium),
              ),
              child: AnimationLimiter(
                child: BlocConsumer(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is AuthSuccess<User>) {
                      Navigator.of(context).pop(state.data);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: kListAnimationDuration,
                        childAnimationBuilder: (child) => SlideAnimation(
                          verticalOffset: kListSlideOffset,
                          child: FadeInAnimation(child: child),
                        ),
                        children: [
                          Image.asset(kAppLogo, height: context.height * 0.1),
                          const SizedBox(height: 12),
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
                            GestureDetector(
                              onTap: cubit.login,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                margin: const EdgeInsets.only(top: 16),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.secondary,
                                  borderRadius:
                                      BorderRadius.circular(kRadiusSmall),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      TablerIcons.brand_google,
                                      color: context.colorScheme.onSecondary,
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Sign in with Google',
                                      style: context.theme.textTheme.button
                                          ?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary
                                    .withOpacity(kEmphasisLowest),
                                borderRadius:
                                    BorderRadius.circular(kRadiusSmall),
                              ),
                              child: TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: context.colorScheme.secondary),
                                ),
                              ),
                            ),
                          },
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => kListAnimationDuration;
}
