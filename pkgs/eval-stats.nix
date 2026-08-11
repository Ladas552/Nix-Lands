{ pkgs, ... }:
let
  inherit (pkgs)
    writeShellApplication
    jq
    writeText
    ;
  # script from @llakala to merge 2 nix-stat eval results
  jq-script =
    writeText "merge.jq" # jq
      ''
        def prettify: {
          "attrset": {
            "lookups": .nrLookups,
            "merges": .nrOpUpdates,
            "mergeCopies": .nrOpUpdateValuesCopied
          },
          "list": {
            "concats": .list.concats,
          },
          "parser": {
            expressions: .nrExprs
          },
          "memory": {
            "envs": .envs.bytes,
            "list": .list.bytes,
            "sets": .sets.bytes,
            "symbols": .symbols.bytes,
            "values": .values.bytes,
            "total": .envs.bytes + .list.bytes + .sets.bytes + .symbols.bytes + .values.bytes
          },
          "speed": {
            "primops": .nrPrimOpCalls,
            "functionCalls": .nrFunctionCalls,
            "thunksMade": .nrThunks,
            "thunksAvoided": .nrAvoided,
          }
        };

        def display_number:
        if . == 0 then
          null
        else
          if . > 0 then
            "+" + (. | tostring) + "%"
          else
            (. | tostring) + "%"
          end
        end;

        def percentage(places):
          # Round to the nearest n decimal places (after the decimal place)
          . * pow(10; places + 2) | round / pow(10; places) | tostring;

        def display_percentage:
          if . == 0 then
            null
          else
            if . > 0 then
              "+" + (. | percentage(2)) + "%"
            else
              (. | percentage(2)) + "%"
            end
          end;


        [(.[] | prettify)] as [$stats_before, $stats_after] |
        reduce ($stats_before | paths(numbers)) as $path (
          $stats_after;
            setpath(
              $path;
              getpath($path) as $after |
              ($stats_before | getpath($path)) as $before |
              if $before == 0 then
                false
              else
                (($after - $before) / $before) | display_percentage
              end
            )
        )
      '';
in
writeShellApplication {
  name = "eval";

  runtimeInputs = [
    jq
  ];

  text = # bash
    ''
      set -euo pipefail

      cmd="$1"
      shift

      case "$cmd" in
          merge)
              before="$1"
              after="$2"
              jq -s -f ${jq-script} "$before" "$after"
              ;;
          eval)
              name="$1"
              hostname="$2"
              NIX_SHOW_STATS_PATH="$name.json" NIX_SHOW_STATS=1 \
                  nix eval .#nixosConfigurations."$hostname".config.system.build.toplevel.outPath --no-eval-cache
              ;;
          *)
              echo "usage: $0 {merge <before.json> <after.json> | eval <name> <hostname>}" >&2
              exit 1
              ;;
      esac
    '';
}
