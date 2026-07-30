eval %sh{ kak-tree-sitter -dks --init $kak_session }

# -----LSP Setup-----
eval %sh{kak-lsp}
hook global WinSetOption filetype=(rust|nix) %{
    lsp-enable-window
}

hook global BufSetOption filetype=(nix) %{
    set-option buffer lsp_servers %{
        [nixd]
        root_globs = ["shell.nix", "flake.nix"]
        settings_section = "nixd"
        [nixd.settings.nixd]
        "nixpkgs.expr" = "import <nixpkgs> { }" 
    }
}
# -----End LSP Setup-----

add-highlighter global/ number-lines -hlcursor -relative -separator "  " -min-digits 5
# Bababooey because kak-tree-sitter
define-command -override tree-sitter-user-after-highlighter %{
  add-highlighter buffer/show-matching show-matching
}

# options
set-option global tabstop 2
set-option global indentwidth 2
set-option global scrolloff 6,3
set-option global autoreload yes
set-option global ui_options terminal_assistant=cat

# Unselect on esc
map global normal <esc> ";,"
# Comment lines
map global user c ":comment-line<ret>" -docstring "Comment line"
map global user . ":bn<ret>" -docstring "Next buffer"
map global user , ":bp<ret>" -docstring "Previous buffer"

# Make searches case insensitive
map global normal "/" "/(?i)"
map global normal "?" "?(?i)"
map global normal "<a-/>" "<a-/>(?i)"
map global normal "<a-?>" "<a-?>(?i)"

# map global normal <a-i> ":enter-user-mode lsp<ret>v"


# -----LSP Misc-----
set-option global modelinefmt "%opt{lsp_modeline} %opt{modelinefmt}"

map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

# map global goto d <esc>:lsp-definition<ret> -docstring 'LSP definition'
map global goto r <esc>:lsp-references<ret> -docstring 'LSP references'
map global goto y <esc>:lsp-type-definition<ret> -docstring 'LSP type definition'

map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Module Namespace Struct<ret>' -docstring 'LSP class or module'
map global object d '<a-semicolon>lsp-diagnostic-object error warning<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object error<ret>' -docstring 'LSP errors'

