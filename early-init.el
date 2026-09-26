;; -*- lexical-binding: t; -*-

(setopt custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)
(setopt package-archives '(("gnu"    . "https://elpa.gnu.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                           ("melpa"  . "https://melpa.org/packages/")))

;; (setopt package-retention-policy t)

(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.1)

(menu-bar-mode 0)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))

(setopt inhibit-startup-screen t)
(setopt initial-scratch-message nil)
(setopt inhibit-startup-echo-area-message (user-login-name))
