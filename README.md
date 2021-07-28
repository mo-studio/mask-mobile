# MASK Mobile 

The Flutter mobile application component of MASK, including Keycloak login and a simple list and detail interface driven by MASK API.

## Getting Started

[Install Flutter](https://flutter.dev/docs/get-started/install), taking good care with the **[Update your path](https://flutter.dev/docs/get-started/install)** section.

Once the environment is all set and `flutter doctor` produces good results, run `flutter pub get` in this repository's root directory to download the package dependencies. This should appear as all green check marks and that nothing is out of date. An error will appear as a read 'X' indicating that your enviorment is not set up properly. The doctor will inform you what is wrong with it. 

## Running, debugging, etc

All build and run operations can be accomplished from within VSCode as well as at the terminal.

If using Visual Studio Code (recommended), you can access the "Run / Debug" toolbar by opening `main.dart`.

See the Flutter documentation for [detailed instructions](https://flutter.dev/docs/get-started/test-drive?tab=vscode).

## Files of Interest

`pubspec.yaml` – this is the file that Flutter uses to manage app metadata, dependencies, etc

`lib/main.dart` – this is the entrypoint to the application code and where you can find the toolbar to run the app (via VS Code)

`lib/services/api.dart` – code lives here for communicating with the API

`lib/services/auth.dart` – authorization code for producing the login modal via Keycloak

`lib/services/blocs` – the two BLoCs used in the mobile app. BLoCs are a [state management solution](https://bloclibrary.dev/#/)

`lib/widgets/Welcome.dart` – the welcome screen widget that contains the "Get Started" button that will launch a Keycloak-driven login modal

`lib/widgets/TaskList.dart` – after logging in, the user will be brought to this page which displays a list of tasks (driven by MASK-API) which has pull-to-refresh and a logout button in the top right

`lib/widgets/TaskDetail.dart` – after tapping on a task from the list screen, users will be brought to this detail screen where they can view the task's details

## Models

Do not edit `model.g.dart` directly! If you make changes to `model.dart`, run `flutter pub run build_runner build --delete-conflicting-outputs` to generate a new `model.g.dart`.

## Unit Tests

To run unit the tests locally, run:

`flutter test --coverage ./lib`

## Producing and Uploading an iOS Build

The following steps assume you are already set up with an Apple Developer account within the BESPIN USAF Apple Developer organization and have set up an app within App Store Connect.

1. Run `flutter build ipa`
2. Open the generated `.ipa` file (the previous command should output its path)
3. This should open the Xcode Organizer window. With the build selected, click "Validate App"
4. If the validation succeeds, click "Distribute App" to upload it to App Store Connect

## Docker

You may notice that there is a Dockerfile in this repo. It's not really for local use, though. It's for testing and building the app in CI. When authenticated to the BESPIN GitLab's container registry via `docker login`, you can pull and push that image with `docker-compose pull` or `push` respectively.

## Pipeline

Current pipeline setup was pulled from both the MDaaS examples of Android and iOS apps and WFA as they have a working Flutter pipeline.

MDaaS iOS example: https://gitlab-dev.bespinmobile.cloud/mdaas/ios-test-app

MDaaS Android example: https://gitlab-dev.bespinmobile.cloud/mdaas/android-test-app

WFA: https://gitlab-dev.bespinmobile.cloud/wingfeedback/ui/wfa_ui/-/tree/develop/

The main file used to run the pipeline is the .gitlab-ci.yml file. This file must be named this and must be located in the root of the repository in order for a pipeline to run. A current problem that needs to be addressed is that MDaaS does not have any Mac containers so iOS builds have to be performed on local runners. To change many of the variables located in [gitlab-ci.yml](https://gitlab-dev.bespinmobile.cloud/corellian-engineering-corp-cec/mask/mask-mobile/-/blob/Hodge/Documentation/.gitlab-ci.yml), someone with maintainer access to the repo needs to go to Settings -> CI/CD -> Variables and change them there. 

## Stages
Stages implemented at the moment are test, coverage, build, and scan in that order.

The test phase not only runs the test but generates the coverage reports on lines covered.
Command used to run tests is `flutter test --coverage ./lib` which runs all tests located in the lib folder. If you move the tests you will have to edit this path.

The coverage stage simply runs a script that checks if a merge request meets or exceeds the code coverage of the develop branch. This is based on the coverage report generated earlier in the test phase. If the tests fail though, there will be no coverage report and this step will fail too.

The build phase creates either a develop or release version of an APK and IPA and uploads them as an artifact. You can download said artifact to use for your own deployment as it is the same APK/IPA if you built it using the terminal on your own machine.

The scan phase pulls these artifacts and scans the APK and IPA for vulnerabilities via NowSecure, as well as linting the actual code throught SonarQube. More details for these scans can be located via the MDaaS links posted above.
