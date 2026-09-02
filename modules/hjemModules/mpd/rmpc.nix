{
  # Store inline rmpc configs
  hosts = ["pc" "laptop" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.rmpc
      ];

      # TODO. add keybinds for skiping to next album with `[` & `]` when it's added to rmpc
      hj.xdg.config.files."rmpc/config.ron".text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              address: "127.0.0.1:6600",
              theme: Some("bash"),
              cache_dir: "~/.cache/rmpc/",
              on_song_change: None,
              volume_step: 2,
              scrolloff: 2,
              enable_mouse: true,
              wrap_navigation: true,
              status_update_interval_ms: 1000,
              select_current_song_on_change: true,
              album_art: (
                  method: Auto,
              ),
              keybinds: (
                  global: {
                      "1":       QueueTab,
                      "2":       DirectoriesTab,
                      "3":       ArtistsTab,
                      "4":       AlbumsTab,
                      "5":       PlaylistsTab,
                      "6":       SearchTab,
                      "7":       ShowOutputs,
                      "?":       ShowHelp,
                      ":":       CommandMode,
                      "Q":       Stop,
                      "c":       ToggleSingle,
                      "<Tab>":   NextTab,
                      "<S-Tab>": PreviousTab,
                      "q":       Quit,
                      "n":       NextTrack,
                      "N":       PreviousTrack,
                      "b":       PreviousTrack,
                      ".":       SeekForward,
                      ",":       SeekBack,
                      "k":       VolumeDown,
                      "l":       VolumeUp,
                      "r":       ToggleRandom,
                      "C":       ToggleConsume,
                      "p":       TogglePause,
                      "R":       ToggleRepeat,
                  },
                  navigation: {
                      "<C-u>":   UpHalf,
                      "=":       NextResult,
                      "-":       PreviousResult,
                      "<Space>":       Add,
                      "A":       AddAll,
                      "g":       Top,
                      "G":       Bottom,
                      "<CR>":    Confirm,
                      "i":       FocusInput,
                      "J":       MoveDown,
                      "<Up>":       Up,
                      "<Down>":       Down,
                      "<Left>":       Left,
                      "<Right>":       Right,
                      "<C-d>":   DownHalf,
                      "/":       EnterSearch,
                      "<C-c>":   Close,
                      "<Esc>":   Close,
                      "K":       MoveUp,
                      "D":       Delete,
                  },
                  queue: {
                      "D":       DeleteAll,
                      "<CR>":    Play,
                      "<C-s>":   Save,
                      "a":       AddToPlaylist,
                      "d":       Delete,
                  },
              ),
          )
        '';
      # TODO get rid of lyrics and rounded corners for tab content pane
      hj.xdg.config.files."rmpc/themes/bash.ron".text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              default_album_art_path: None,
              format_tag_separator: " | ",
              browser_column_widths: [10, 38, 42],
              background_color: None,
              text_color: None,
              header_background_color: None,
              modal_background_color: None,
              modal_backdrop: false,
              preview_label_style: (fg: "yellow"),
              preview_metadata_group_style: (fg: "yellow", modifiers: "Bold"),
              highlighted_item_style: (fg: "blue", modifiers: "Bold"),
              current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
              borders_style: (fg: "blue"),
              highlight_border_style: (fg: "blue"),
              symbols: (song: "", dir: "", marker: "M", ellipsis: "",),
              level_styles: (
                  info: (fg: "blue", bg: "black"),
                  warn: (fg: "yellow", bg: "black"),
                  error: (fg: "red", bg: "black"),
                  debug: (fg: "light_green", bg: "black"),
                  trace: (fg: "magenta", bg: "black"),
              ),
              progress_bar: (
                  symbols: ["-", "C", "•"],
                  track_style: (fg: "white"),
                  elapsed_style: (fg: "green"),
                  thumb_style: (fg: "green", bg: "#1e2030"),
                  use_track_when_empty: true,
              ),
              scrollbar: (
                  symbols: ["│", "█", "▲", "▼"],
                  track_style: (),
                  ends_style: (),
                  thumb_style: (fg: "blue"),
              ),
              tab_bar: (
                  active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                  inactive_style: (),
              ),
              browser_song_format: [
                  (
                      kind: Group([
                          (kind: Property(Track)),
                          (kind: Text(" ")),
                      ])
                  ),
                  (
                      kind: Group([
                          (kind: Property(Artist)),
                          (kind: Text(" - ")),
                          (kind: Property(Title)),
                      ]),
                      default: (kind: Property(Filename))
                  ),
              ],
              song_table_format: [
                  (
                      prop: (kind: Property(Title),
                          default: (kind: Text("Unknown"))
                      ),
                      label_prop: (kind: Text("Title")),
                      width: "45%",
                  ),
                  (
                      prop: (kind: Property(Artist),
                          default: (kind: Text("Unknown"))
                      ),
                      label_prop: (kind: Text("Artist")),
                      width: "45%",
                  ),
                  (
                      prop: (kind: Property(Duration),
                          default: (kind: Text("-"))
                      ),
                      label_prop: (kind: Text("Duration")),
                      width: "10%",
                      alignment: Right,
                  ),
              ],
              layout: Split(
                  direction: Vertical,
                  panes: [
                      (
                          size: "4",
                          pane: Split(
                              direction: Horizontal,
                              panes: [
                                  (
                                      size: "50%",
                                      borders: "LEFT | TOP | BOTTOM",
                                      border_symbols: Inherited(parent: Plain, bottom_left: "├"),
                                      pane: Component("header_left")
                                  ),
                                  (
                                      size: "50%",
                                      borders: "RIGHT | TOP | BOTTOM",
                                      border_symbols: Inherited(parent: Plain, bottom_right: "┤"),
                                      pane: Component("header_right")
                                  ),
                              ]
                          )
                      ),
                      (
                          pane: Pane(Tabs),
                          borders: "RIGHT | LEFT | BOTTOM",
                          border_symbols: Plain,
                          size: "2",
                      ),
                      (
                          pane: Pane(TabContent),
                          size: "100%",
                      ),
                      (
                          size: "4",
                          borders: "TOP | BOTTOM | RIGHT | LEFT",
                          border_symbols: Plain,
                          border_title: [(kind: Text(" ")), (kind: Property(Status(QueueLength()))), (kind: Text(" songs / ")), (kind: Property(Status(QueueTimeTotal()))), (kind: Text(" total time "))],
                          border_title_alignment: Right,
                          pane: Split(
                              direction: Vertical,
                              panes: [
                                  (
                                      size: "1",
                                      pane: Pane(Property(
                                          content: [
                                              (kind: Property(Song(Title)), style: (fg: "yellow", modifiers: "Bold"),
                                                  default: (kind: Text("No Song"), style: (fg: "white", modifiers: "Bold"))),
                                          ], 
                                          align: Left,
                                          scroll_speed: 1
                                      ))
                                  ),
                                  (
                                      size: "1",
                                      pane: Component("progress_bar")
                                  ),
                              ]
                          )
                      ),
                  ],
              ),
              components: {
                  "state": Pane(Property(
                      content: [
                          (kind: Text("["), style: (fg: "yellow", modifiers: "Bold")),
                          (kind: Property(Status(StateV2( ))), style: (fg: "yellow", modifiers: "Bold")),
                          (kind: Text("]"), style: (fg: "yellow", modifiers: "Bold")),
                      ], align: Left,
                  )),
                  "title": Pane(Property(
                      content: [
                          (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                              default: (kind: Text("No Song"), style: (modifiers: "Bold"))),
                      ], align: Center, scroll_speed: 1
                  )),
                  "volume": Split(
                      direction: Horizontal,
                      panes: [
                          (size: "1", pane: Pane(Property(content: [(kind: Text(""))]))),
                          (size: "100%", pane: Pane(Volume(kind: Slider(symbols: (filled: "|", thumb: "'", track: "─"))))),
                          (size: "3", pane: Pane(Property(content: [(kind: Property(Status(Volume)), style: (fg: "blue"))], align: Right))),
                          (size: "2", pane: Pane(Property(content: [(kind: Text("%"), style: (fg: "blue"))]))),
                      ]
                  ),
                  "elapsed_and_bitrate": Pane(Property(
                      content: [
                          (kind: Property(Status(Elapsed))),
                          (kind: Text(" / ")),
                          (kind: Property(Status(Duration))),
                          (kind: Group([
                              (kind: Text(" (")),
                              (kind: Property(Status(Bitrate))),
                              (kind: Text(" kbps)")),
                          ])),
                      ],
                      align: Left,
                  )),
                  "artist_and_album": Pane(Property(
                      content: [
                          (kind: Property(Song(Artist)), style: (fg: "yellow", modifiers: "Bold"),
                              default: (kind: Text("Unknown"), style: (fg: "yellow", modifiers: "Bold"))),
                          (kind: Text(" - ")),
                          (kind: Property(Song(Album)), default: (kind: Text("Unknown Album"))),
                      ], align: Center, scroll_speed: 1
                  )),
                  "states": Split(
                      direction: Horizontal,
                      panes: [
                          (
                              size: "1",
                              pane: Pane(Empty())
                          ),
                          (
                              size: "100%",
                              pane: Pane(Property(content: [(kind: Property(Status(InputBuffer())), style: (fg: "blue"), align: Left)]))
                          ),
                          (
                              size: "6",
                              pane: Pane(Property(content: [
                                  (kind: Text("["), style: (fg: "blue", modifiers: "Bold")),
                                  (kind: Property(Status(RepeatV2(
                                      on_label: "R",
                                      off_label: "R",
                                      on_style: (fg: "yellow", modifiers: "Bold"),
                                      off_style: (fg: "blue", modifiers: "Dim"),
                                  )))),
                                  (kind: Property(Status(RandomV2(
                                      on_label: "r",
                                      off_label: "r",
                                      on_style: (fg: "yellow", modifiers: "Bold"),
                                      off_style: (fg: "blue", modifiers: "Dim"),
                                  )))),
                                  (kind: Property(Status(ConsumeV2(
                                      on_label: "C",
                                      off_label: "C",
                                      oneshot_label: "S",
                                      on_style: (fg: "yellow", modifiers: "Bold"),
                                      off_style: (fg: "blue", modifiers: "Dim"),
                                      oneshot_style: (fg: "red", modifiers: "Dim"),
                                  )))),
                                  (kind: Property(Status(SingleV2(
                                      on_label: "c",
                                      off_label: "c",
                                      oneshot_label: "s",
                                      on_style: (fg: "yellow", modifiers: "Bold"),
                                      off_style: (fg: "blue", modifiers: "Dim"),
                                      oneshot_style: (fg: "red", modifiers: "Bold"),
                                  )))),
                                  (kind: Text("]"), style: (fg: "blue", modifiers: "Bold")),
                                  ],
                                  align: Right
                              ))
                          ),
                      ]
                  ),
                  "header_left": Split(
                      direction: Vertical,
                      panes: [
                          (size: "1", pane: Component("state")),
                          (size: "1", pane: Component("elapsed_and_bitrate")),
                      ]
                  ),
                  "header_right": Split(
                      direction: Vertical,
                      panes: [
                          (size: "1", pane: Component("volume")),
                          (size: "1", pane: Component("states")),
                      ]
                  ),
                  "progress_bar": Split(
                      direction: Horizontal,
                      panes: [
                          (
                              size: "1",
                              pane: Pane(Empty())
                          ),
                          (
                              size: "100%",
                              pane: Pane(ProgressBar)
                          ),
                          (
                              size: "1",
                              pane: Pane(Empty())
                          ),
                      ]
                  )
              },
          )
        '';
    };
}
