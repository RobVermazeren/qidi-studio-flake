{
  pkgs,
  appimageTools,
  lib,
  ...
}: 

let
  appname = "QIDIStudio";
  pname = "qidi-studio";
  version = "2.02.00.61";
  architecture = "x86_64";

  src = pkgs.fetchurl {
    url = "https://github.com/QIDITECH/${appname}/releases/download/v${version}/${appname}_${version}_Ubuntu24.AppImage";
    hash = "sha256:e68443c5de3151642f8b987e0d8c8b027a3d9e2a33a315f13d895f0201d64cfc";
  };
  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs: [
    webkitgtk_4_1
  ];

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${appname}.desktop $out/share/applications/${appname}.desktop
      install -m 444 -D ${appimageContents}/${appname}.png $out/share/icons/hicolor/512x512/apps/${appname}.png
    '';

    meta = {
      description = "Professional 3D printer slicing software for QIDI 3D Printers, based on BambuStudio";
      longDescription = ''
        QIDIStudio is a professional 3D printer slicing software，which is perfectly compatible with all printers and 3D printing filaments of QIDI Technology. 
        Multi-platform support, simple inerface, easy to use, complate functions, easy to learn 3D printing.
      '';
      homepage = "https://github.com/QIDITECH/QIDIStudio";
      license = lib.licenses.agpl3Plus;
      # maintainers = with lib.maintainers; [ j0hax ];
      mainProgram = "${appname}";
      platforms = [ "x86_64-linux" ];
      # sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };

  }
