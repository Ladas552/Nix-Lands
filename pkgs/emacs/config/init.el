;; Update user-emacs-directory to use a non store location, so that packages may write there
;; thanks https://github.com/jordanisaacs/emacs-config/blob/3854525333a886c53a1dc966e0b4bb09a088e9fb/init.org?plain=1#L39-L48          
;; stolen from https://nezia.dev/
(setq user-emacs-directory (expand-file-name "emacs/" (getenv "XDG_STATE_HOME")))
(setq custom-file (locate-user-emacs-file "custom.el"))


;; default theme
(use-package catppuccin-theme
             :demand t
             :config
             (load-theme 'catppuccin :no-confirm)
             :custom 
             (catppuccin-flavor 'macchiato))

(use-package pretty-sha-path)

(use-package nyan-mode
             :init (nyan-mode)
             :custom
             (nyan-animate-nyancat t)
             (nyan-wavy-trail t))

(use-package meow
  :ensure t
  :init
  ;; Optional: Enables Vim-like behavior for 'a' key (append after cursor).
  (setq meow-use-cursor-position-hack t)
  :config
  (defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
  (meow-setup)
  (meow-global-mode 1))

(use-package magit)

(use-package nix-ts-mode
             :mode (("\\.nix\\'" . nix-ts-mode)))

(use-package which-key
             :hook (after-init . which-key-mode))

(use-package dired
             :custom
             (dired-dwim-target t)
             (dired-listing-switches "-AGhlv --group-directories-first --time-style=long-iso")
             (dired-kill-when-opening-new-dired-buffer t))

(use-package page-break-lines)
;; dashboard initialisation
(use-package dashboard
             :ensure t
             :init
             (dashboard-setup-startup-hook)
             :custom


             ;; Set the title
             ( dashboard-banner-logo-title "Time-Waste-Mode enabled")

             ;; Set the banner
             ( dashboard-startup-banner 'logo)

             ;; Content is not centered by default. To center, set
             ( dashboard-center-content t)

             ;; vertically center content
             (dashboard-vertically-center-content t)

             ;; items in dashboard
             ( dashboard-items '((bookmarks . 15)
                                 (agenda    . 5)))

             ;; enable cycle navigation between each section
             ( dashboard-navigation-cycle t)

             ;; To use icons
             ( dashboard-set-heading-icons nil) ; not `t` because some bug, idk
             ( dashboard-set-file-icons t)

             ;; modify the widget heading name
             ( dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
             ( dashboard-week-agenda t))
;; Add solaire integration
(use-package solaire-mode
             :hook
             (dashboard-before-initialize-hook . solaire-mode)
             :custom
             (solaire-global-mode +1))
