# shell.nix

{ pkgs ? import <nixpkgs> {config.android_sdk.accept_license = true;} }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "12.0-rc15";
    toolsVersion = "26.1.1";
    platformToolsVersion = "34.0.5";
    buildToolsVersions = [ "34.0.0" ];
    includeEmulator = true;
    emulatorVersion = "34.1.9";
    platformVersions = [ "34" ];
    includeSources = true;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" ];
    cmakeVersions = [ "3.10.2" ];
    includeNDK = true;
    #ndkVersions = ["25"];
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeExtras = [
      "extras;google;gcm"
    ];
  };
in

pkgs.mkShell {

  buildInputs = [
    pkgs.nodejs
    pkgs.yarn
    pkgs.ruby
    pkgs.jdk17
    androidComposition.androidsdk
    pkgs.gradle_7
    pkgs.aapt
  ];

  shellHook = ''
    export PATH="$NODE_PATH/bin:$PATH"
    export ANDROID_HOME="${androidComposition.androidsdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="${androidComposition.androidsdk}/libexec/android-sdk";
    export ANDROID_NDK_ROOT="''${ANDROID_SDK_ROOT}/ndk-bundle";
    # Use the same buildToolsVersion here
    export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=''${ANDROID_SDK_ROOT}/build-tools/34.0.0/aapt2";
  '';
}
