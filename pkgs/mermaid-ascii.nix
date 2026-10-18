{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "mermaid-ascii";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "AlexanderGrooff";
    repo = "mermaid-ascii";
    tag = finalAttrs.version;
    hash = "sha256-KYCJIgLwjJR5RM1AdGrV47UhFgpLqwro42E54pzhYWE=";
  };

  vendorHash = "sha256-S/K6W8KC6YzwZPioucoiwOMd29LPv0J22T3MS0X+W5g=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Render Mermaid graphs as ASCII art in the terminal";
    longDescription = ''
      mermaid-ascii reads a Mermaid `graph`/flowchart definition and renders it
      as ASCII or Unicode box-drawing art, so diagrams can be displayed in a
      terminal, a plain-text file, or a code comment without an image renderer.
    '';
    homepage = "https://github.com/AlexanderGrooff/mermaid-ascii";
    changelog = "https://github.com/AlexanderGrooff/mermaid-ascii/releases/tag/${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "mermaid-ascii";
    maintainers = with lib.maintainers; [ ismailkattakath ];
    platforms = lib.platforms.unix;
  };
})
