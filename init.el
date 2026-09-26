;; -*- lexical-binding: t; -*-

(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

(use-package recentf
  :init
  (setopt recentf-max-menu-items 25
          recentf-max-saved-items 100)
  :config
  (recentf-mode +1)
  (run-at-time "15 min" 300 #'recentf-save-list))

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-dark+ t))

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-mode)
  :hook ((c-ts-mode . lsp-mode)
         (c++-ts-mode . lsp-mode)
         (python-mode . lsp-mode))
  :init
  (setopt lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration)
  (setopt lsp-enable-diagnostics nil)
  (setopt lsp-auto-guess-root t))

(use-package whole-line-or-region
  :ensure t
  :config
  (whole-line-or-region-global-mode 1))

(use-package stripspace
  :ensure t
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))
  :custom
  (stripspace-only-if-initially-clean nil)
  (stripspace-restore-column t))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-count 15)
  (vertico-resize nil)
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#005f87" :foreground "#ffffff")))))

(use-package savehist
  :init
  (savehist-mode))

(use-package emacs
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package consult
  :ensure t
  :bind (("C-x b"   . consult-buffer)
         ("C-c s"   . consult-line)
         ("C-c g"   . consult-goto-line)
         ("C-c f r" . consult-recent-file))
  :config
  (setopt consult-ripgrep-command
      "rg --null --line-buffered --color=always --smart-case --no-heading --line-number --max-columns=1000 . -e ARG OPTS")
  (setopt consult-ripgrep-line-format "%5l:%2c  %f: %m")
  (setopt consult-preview-wrap nil)
  (setopt consult-preview-key nil)

  (defun my-consult-buffer-predicate (buffer)
    (not (string-match-p "^\\*scratch\\*\\|^\\*Messages\\*\\|^\\*SomethingElse\\* "
                         (buffer-name buffer))))
  (defvar my-consult-source-buffer
    `(:name "Buffer"
      :narrow ?b
      :category buffer
      :face consult-buffer
      :history buffer-name-history
      :state consult--buffer-state
      :default t
      :items (lambda ()
               (consult--buffer-query
                :sort 'visibility
                :exclude '("^ " "^\\*")
                :predicate 'my-consult-buffer-predicate
                :as #'buffer-name)))
    "My custom buffer source for `consult-buffer'.")

  (setopt consult-buffer-sources '(my-consult-source-buffer))
  (setopt consult-project-root-function #'projectile-project-root))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind
  (:map projectile-command-map
        ("s" . consult-ripgrep))
  :custom
  (projectile-completion-system 'default)
  (projectile-indexing-method 'alien)
  (projectile-enable-caching t))

(use-package embark
  :ensure t
  :after consult
  :init
  (setopt prefix-help-command #'embark-prefix-help-command)
  :config
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))

(use-package embark-consult
  :ensure t
  :after (embark consult))

(use-package orderless
  :ensure t
  :init
  (setopt completion-styles '(orderless basic)
          completion-category-defaults nil
          completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(add-to-list 'display-buffer-alist
             '("\\*rg\\*" . (nil . ((body-function . select-window)))))

(save-place-mode 1)
(global-set-key (kbd "<select>") #'move-end-of-line)
(show-paren-mode t)
(setq make-backup-files nil)
(setq-default c-basic-offset 2)

(setopt treesit-enabled-modes t)
(setopt treesit-auto-install-grammar 'always)

(defun set-c++-ts-indentation ()
  (setq c-ts-mode-indent-offset 2
        tab-width 2
        indent-tabs-mode nil))
(add-hook 'c++-ts-mode-hook #'set-c++-ts-indentation)

(setopt whitespace-style '(face trailing tabs empty))
(custom-set-faces
 '(whitespace-tab ((t (:background "red")))))
(global-whitespace-mode 1)

(setopt column-number-mode t)
(setq-default indent-tabs-mode nil)
(setopt resize-mini-windows t)
(setopt max-mini-window-height 0.4)
(blink-cursor-mode 0)
(setopt visible-bell t)
(setopt ring-bell-function #'ignore)
(setopt scroll-preserve-screen-position t)
(setopt scroll-error-top-bottom t)
(global-auto-revert-mode t)

(setopt tramp-auto-save-directory
        (expand-file-name "tramp-autosave/" user-emacs-directory))
