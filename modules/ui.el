;; -*- mode: emacs-lisp; lexical-binding: t; -*-

;; good ol gruvbox
(use-package base16-theme)
(load-theme 'base16-gruvbox-dark-soft t)

(blink-cursor-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(global-hl-line-mode 1)
(setq visible-bell t)


(use-package nyan-mode
  :if (display-graphic-p)
  :config
  (setq nyan-wavy-trail t)
  (nyan-mode 1))

;; modeline stuff
(setq line-number-mode t)
(setq column-number-mode t)

;; things that are neat
(setq x-underline-at-descent-line nil)
(setq-default show-trailing-whitespace t)

;; git highlights my beloved
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))
