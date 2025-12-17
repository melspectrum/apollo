;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(whole-line-or-region-global-mode 1)
(global-set-key (kbd "<select>") 'move-end-of-line)

;; (after! cc-mode
;;   ;; Don't use treesitter versions.
;;   (add-to-list 'major-mode-remap-alist '(c-mode . nil))
;;   (add-to-list 'major-mode-remap-alist '(c++-mode . nil))
;;   (add-to-list 'major-mode-remap-alist '(c-or-c++-mode . nil)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq flycheck-checker-error-threshold nil)

(add-hook! 'json-mode-hook (setq-local +word-wrap-extra-indent 'single) (+word-wrap-mode +1))
(add-hook 'c-mode-common-hook #'visual-line-mode)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(after! cc-mode
  (setq indent-tabs-mode nil)
  (setq c-tab-always-indent nil)
  (setq c-basic-offset 2)
  (c-set-offset 'inclass 2)
  (c-set-offset 'topmost-intro 0)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'access-label '/)
)

(setq show-paren-context-when-offscreen 'echo)

;; (after! treesit
;;   (setq treesit-language-source-alist
;;         '((cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.22.0")
;;           (c "https://github.com/tree-sitter/tree-sitter-c" "v0.23.0")))
;;   ;; Run the install command again after adding the source alist
;;   ;; M-x treesit-install-language-grammar
;;   )

;; (add-to-list 'auto-mode-alist '("\\.\\(cpp\\|cxx\\|cc\\|C\\)\\'" . c++-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(hpp\\|hxx\\|hh\\|H\\)\\'" . c++-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-ts-mode))

;; (defun set-c++-ts-indentation ()
;;   "Indentation for C++ tree-sitter mode."
;;   (setq c-ts-mode-indent-offset 2 ; Sets the indentation level
;;         tab-width 2                 ; Sets how many columns a tab character displays as
;;         indent-tabs-mode nil))      ; Use spaces for indentation

;; (add-hook 'c++-ts-mode-hook #'set-c++-ts-indentation)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
