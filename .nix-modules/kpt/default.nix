{
  buildGoModule,
  fetchFromGitHub,
  lib,
  stdenv,
}:
buildGoModule rec {
  pname = "kpt";
  version = "1.0.0-beta.55";

  src = fetchFromGitHub {
    owner = "kptdev";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-MVrJUsMpt1L56ezy2b2G6Aac9kpe4QgfSosR+PeTuBQ=";
  };

  vendorHash = "sha256-2jJCvBtTiIYmpxA92p8eZnKl1UO74pKr1YFRH14keZY=";

  subPackages = ["."];

  ldflags = ["-s" "-w" "-X github.com/GoogleContainerTools/kpt/run.version=${version}"];

  meta = with lib; {
    description = "Toolkit to help you manage, manipulate, customize, and apply Kubernetes Resource configuration data files";
    mainProgram = "kpt";
    homepage = "https://kptdev.dev";
    license = licenses.asl20;
    maintainers = with maintainers; [mikefaille];
    broken = stdenv.hostPlatform.isDarwin;
  };
}
