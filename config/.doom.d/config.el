;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "FiraCode" :size 14)
      doom-big-font (font-spec :family "Ubuntu" :size 18)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       _                        _  ___    ;;
;;   ___| |_ __ _ _ __  _____   _/ |/ _ \   ;;
;;  / __| __/ _` | '_ \|_  / | | | | | | |  ;;
;;  \__ \ || (_| | | | |/ /| |_| | | |_| |  ;;
;;  |___/\__\__,_|_| |_/___|\__,_|_|\___/   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;
(setq confirm-kill-emacs nil)
(setq auto-save-default t)
(setq evil-want-Y-yank-to-eol t)


;;;;;;;;;;;;;;;;
;; Copy/Paste ;;
;;;;;;;;;;;;;;;;
(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard.")
        (call-interactively 'clipboard-kill-ring-save))
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard.")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!"))))

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active"))
    (insert (shell-command-to-string "xsel -o -b"))))

(map! :leader
      :desc "copy-to-clipboard"
      "o y" #'copy-to-clipboard)
(map! :leader
      :desc "paste-from-clipboard"
      "o p" #'paste-from-clipboard)


;;;;;;;;;;;;;;
;; Key Maps ;;
;;;;;;;;;;;;;;
(evil-set-leader 'normal (kbd "SPC"))
(define-key evil-normal-state-map "U" 'evil-redo)

(define-key evil-normal-state-map "J" '(lambda()(interactive)(evil-next-line 5)))
(define-key evil-visual-state-map "J" '(lambda()(interactive)(evil-next-line 5)))

(define-key evil-normal-state-map "K" '(lambda()(interactive)(evil-previous-line 5)))
(define-key evil-visual-state-map "K" '(lambda()(interactive)(evil-previous-line 5)))

(define-key evil-normal-state-map "L" '(lambda()(interactive)(evil-forward-char 10)))
(define-key evil-visual-state-map "L" '(lambda()(interactive)(evil-forward-char 10)))

(define-key evil-normal-state-map "H" '(lambda()(interactive)(evil-backward-char 10)))
(define-key evil-visual-state-map "H" '(lambda()(interactive)(evil-backward-char 10)))


;;;;;;;;;;;;;;;;;;
;; Text Scaling ;;
;;;;;;;;;;;;;;;;;;
(map!
      :n "C-="    #'text-scale-increase
      :n "C--"    #'text-scale-decrease)


;;;;;;;;;;;;
;; Vimish ;;
;;;;;;;;;;;;
(map! :leader
      :desc "Add Line Below"
      "j" '+evil/insert-newline-below)

(map! :leader
      :desc "Add Line Abobe"
      "k" '+evil/insert-newline-above)

(map! :leader
      :desc "Append End Of Line"
      "a" 'evil-append-line)

(map! :leader
      :desc "End Of Line"
      ";" 'evil-end-of-line)

(map! :leader
      :desc "End Of Line"
      "C" '(lambda()""(interactive)(evil-invert-char)(evil-backward-char)))


;;;;;;;;;;;;;;
;; Treemacs ;;
;;;;;;;;;;;;;;
(map! :leader
      :desc "Toggle Treemacs"
      "e" '+treemacs/toggle)

(map!
      :desc "Toggle Treemacs"
      "M-1" '+treemacs/toggle)


;;;;;;;;;;;;;;
;; settings ;;
;;;;;;;;;;;;;;
(setq confirm-kill-emacs nil)
(setq auto-save-default t)
(setq evil-want-Y-yank-to-eol t)
