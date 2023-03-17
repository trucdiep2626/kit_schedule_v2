# kit_schedule_v2

#Flutter version 3.0.5

# Run to generated code with buiild_runner and freezed
- You setup build environment for the first time.
- You modified any code with the annotation `@freezed`.

```
flutter pub run build_runner build --delete-conflicting-outputs
```

# Run to generate translated message code

```
flutter pub run intl_utils:generate
```
Now, you can get the localized text by `L10n.of(context).msgap001`.

# Run to generate path icon
- docs: https://pub.dev/packages/flutter_gen
- note: do not create directory 'default'

```
fluttergen -c pubspec.yaml
```
- example:
import './generated/assets.gen.dart';
Now, you can get path icon from folder svg by `Assets.svg.icon.path`

# Common rules folow dart standard
1. Naming convention:
 - name file use snake case 
 - name class/ variable/ function use camel case
 
2. Common styles
- Declare common color/ textstyle/ dimension... in app_style.dart
- If the styles have just used locally in one screen one time it can be used as hard code
- Declare as constant in ahead of class if multiple use in one screen
- If these styles used multiple screen in one function such as login, put them in login/component/login_styles.dart

3. Naming branch
    - Develop branch: Dev
    - Production branch: main
    - features development: feat/name_ID_description    
    - bug fix: bug/name_ID_description                  
    - hot fix: hotfix/name_ID_description & branch target is main

