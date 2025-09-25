import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/custom_image_view.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/gen/assets.gen.dart';
import 'package:chatsy/main.dart';
import 'package:gap/gap.dart';

import '../../../common_widget/custom_text_field.dart';
import '../../home/controllers/ai_assistants_model.dart';
import '../controllers/create_ai_assistant_controller.dart';

class CreateAiAssistantView extends GetView<CreateAiAssistantController> {
  const CreateAiAssistantView({super.key});

  static Future<T?>? route<T>() {
    return Get.toNamed(Routes.CREATE_AI_ASSISTANT);
  }

  @override
  Widget build(BuildContext context) {
    var of = Languages.of(context)!;

    return FormFocus(
      child: AppScaffold(
        bottomNavigationBar: IntrinsicHeight(
          child: SafeArea(
            minimum: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Builder(
              builder: (context) {
                return CommonButton(
                  onTap: () => controller.onCreate(context),
                  title: of.create,
                );
              },
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            var scaffoldBackgroundColor =
                Theme.of(context).scaffoldBackgroundColor;

            var gap = Gap(16);
            return ListView(
              padding: MediaQuery.paddingOf(
                context,
              ).min(bottom: 16, right: 16, left: 16),
              children: [
                Center(
                  child: FormFieldAny(
                    validator:
                        (value) => AppValidation.imageValidation(
                          context,
                          controller.image.value,
                        ),
                    builder: (field, any) {
                      if (!field.hasError) {
                        return any;
                      }
                      var errorText = field.errorText;
                      if (errorText == null || errorText.isEmpty) {
                        return any;
                      }
                      return Column(
                        spacing: 8,
                        children: [
                          any,
                          Text(
                            errorText,
                            style:
                                TextFieldThemes.of(
                                  context,
                                ).borderedDecorationTheme.errorStyle,
                          ),
                        ],
                      );
                    },
                    any: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => controller.onMediaPick(context),
                          child: SizedBox.square(
                            dimension: 80,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipOval(
                                  child: ColoredBox(
                                    color: KColors.cyanLight,
                                    child: Obx(
                                      () => ImageView(
                                        controller.image.value ??
                                            Assets.svg.icProfile,
                                        inner:
                                            controller.image.value != null
                                                ? null
                                                : ImageSize(
                                                  dimension: 32,
                                                  alignment: Alignment.center,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 2,
                                  bottom: 2,
                                  child: ImageView(
                                    Assets.svg.icEdit2,
                                    shape: BoxShape.circle,
                                    decoration: BoxDecoration(
                                      color: KColors.cyan,
                                      border: Border.all(
                                        color: scaffoldBackgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                    inner: ImageSize(
                                      dimension: 10,
                                      alignment: Alignment.center,
                                    ),
                                    outer: ImageSize(
                                      dimension: 22,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Gap(32),
                HeaderText(
                  text: of.name,
                  child: TextInputField(
                    context: context,
                    controller: controller.nameController,
                    textCapitalization: TextCapitalization.words,
                    type: InputType.text,
                    suffixIcon:
                        Constants.magicStickPrompt == null
                            ? null
                            : GestureDetector(
                              onTap:
                                  () => controller.onGenerateAssistant(context),
                              child: Center(
                                child: ImageView(
                                  Assets.svg.icMagicStick,
                                  shape: BoxShape.circle,
                                  backgroundColor: KColors.cyan,
                                  outer: ImageSize(
                                    dimension: 25,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),

                    hintLabel: of.enterName,
                    validator:
                        (value) => AppValidation.nameValidation(context, value),
                  ),
                ),
                gap,

                HeaderText(
                  text: of.aIAssistantsTemplates,
                  child: FormFieldAny(
                    validator:
                        (value) => AppValidation.promptValidation(
                          context,
                          controller.promptController.text,
                        ),
                    builder: (field, any) {
                      return ListenableBuilder(
                        listenable: controller.focusNode,
                        builder: (context, child) {
                          return InputDecorator(
                            isFocused: controller.focusNode.hasFocus,
                            decoration: InputDecoration()
                                .applyDefaults(
                                  TextFieldThemes.of(
                                    context,
                                  ).borderedDecorationTheme,
                                )
                                .copyWith(errorText: field.errorText),
                            child: FocusScope(
                              onFocusChange: (value) {
                                if (!value) {
                                  field.validate();
                                }
                              },
                              child: any,
                            ),
                          );
                        },
                      );
                    },

                    any: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextInputField(
                          focusNode: controller.focusNode,
                          context: context,
                          themeType: ThemeType.transparent,
                          // minLines: 6,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1000),
                          ],
                          maxLines: 8,
                          hintLabel: of.backendPromptInputEx,
                          textInputAction: TextInputAction.newline,
                          controller: controller.promptController,
                          type: InputType.multiline,
                        ),
                        ListenableBuilder(
                          listenable: controller.promptController,
                          builder: (context, child) {
                            return Text(
                              '${controller.promptController.text.length}/1000',
                              style: HelveticaStyles.of(context).s12w400Grey,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                gap,
                HeaderText(
                  text: of.aiModels,
                  child: Column(
                    children:
                        [
                              (AIModel.gpt4o, of.GPT4o, of.mostPowerfulAiModel),
                              (
                                AIModel.gemini,
                                of.gemini,
                                of.moreHumanlyResponses,
                              ),
                            ]
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    if (e.$1 == AIModel.gemini &&
                                        Global.isSubscription.value != '1') {
                                      return;
                                    }

                                    controller.selectedModel.value = e.$1;
                                  },
                                  child: _Box(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: e.$2,
                                              style:
                                                  HelveticaStyles.of(
                                                    context,
                                                  ).s14w400,

                                              children: [
                                                TextSpan(
                                                  text: ' (${e.$3})',
                                                  style:
                                                      HelveticaStyles.of(
                                                        context,
                                                      ).s14w400Grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (e.$1 == AIModel.gemini &&
                                            Global.isSubscription.value != '1')
                                          DecoratedBox(
                                            decoration: ShapeDecoration(
                                              color: KColors.cyan,
                                              shape: StadiumBorder(),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 16,
                                              ),
                                              child: Text(
                                                'Pro',
                                                style:
                                                    HelveticaStyles.of(
                                                      context,
                                                    ).s14w400White,
                                              ),
                                            ),
                                          )
                                        else
                                          Obx(() {
                                            var isSelected =
                                                controller
                                                    .selectedModel
                                                    .value ==
                                                e.$1;
                                            return ImageView(
                                              Assets.svg.icDone,
                                              shape: BoxShape.circle,
                                              color:
                                                  isSelected
                                                      ? Colors.white
                                                      : scaffoldBackgroundColor,
                                              backgroundColor:
                                                  isSelected
                                                      ? KColors.cyan
                                                      : scaffoldBackgroundColor,

                                              decoration: BoxDecoration(
                                                border:
                                                    isSelected
                                                        ? null
                                                        : Border.all(
                                                          color:
                                                              TColors.of(
                                                                context,
                                                              ).greyBorder,
                                                        ),
                                              ),
                                              outer: ImageSize(
                                                dimension: 20,
                                                alignment: Alignment.center,
                                              ),
                                            );
                                          }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            );
          },
        ),

        appBar: CommonAppBar(context, title: of.assistants),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TColors.of(context).greyBorder),
      ),
      child: Padding(padding: EdgeInsets.all(16), child: child),
    );
  }
}

class AppScaffold extends Scaffold {
  const AppScaffold({
    super.key,
    required super.body,
    required super.appBar,
    super.bottomNavigationBar,
  });
}

class CommonAppBar extends AppBar {
  CommonAppBar(BuildContext context, {super.key, required String? title})
    : super(
        title: title == null ? null : Text(title),
        leading:
            (ModalRoute.of(context)?.impliesAppBarDismissal ?? false)
                ? Align(
                  alignment: Alignment.centerRight,
                  child: AppBackButton(),
                )
                : null,
      );
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var style =
        Theme.of(context).extension<IconButtonThemes>()?.iconButtonStyle;

    return IconButton(
      onPressed: onTap ?? Get.back,
      style: style,
      icon: Icon(Icons.arrow_back_ios),
    );
  }
}

class FormFocus extends StatelessWidget {
  const FormFocus({super.key, required this.child});

  final Widget child;

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool validate(BuildContext context) {
    unfocus(context);
    return Form.of(context).validate();
  }

  static bool validateWithScroll(BuildContext context) {
    unfocus(context);
    try {
      var state = Form.of(
        context,
      ).validateGranularly().firstWhere((element) => element.hasError);

      Scrollable.ensureVisible(
        state.context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.5,
        curve: Curves.easeInOut,
      );

      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Form(
        child: Builder(
          builder: (context) {
            return GestureDetector(onTap: () => unfocus(context), child: child);
          },
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.text, required this.child});

  final String text;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [Text(text, style: HelveticaStyles.of(context).s12w400), child],
    );
  }
}

class AppValidation {
  AppValidation._();

  static String? nameValidation(BuildContext context, String? value) {
    if (value == null || value.isEmpty)
      return Languages.of(context)?.pleaseEnterName;

    return null;
  }

  static String? promptValidation(BuildContext context, String? value) {
    if (value == null || value.isEmpty)
      return Languages.of(context)?.pleaseEnterPrompt;
    return null;
  }

  static String? imageValidation(BuildContext context, String? value) {
    if (value == null || value.isEmpty)
      return Languages.of(context)?.pleaseSelectImage;
    return null;
  }
}

typedef FormFieldAnyBuilder<T, A> =
    Widget Function(FormFieldState field, A any);

class FormFieldAny<T, A> extends FormField<T> {
  FormFieldAny({
    super.key,
    required this.any,
    required FormFieldAnyBuilder<T, A> builder,
    super.validator,
  }) : super(builder: (field) => builder(field, any));

  final A any;
}
