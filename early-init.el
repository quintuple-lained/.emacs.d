;; -*- mode: emacs-lisp; lexical-binding: t; -*-

;; no blind
(set-face-background 'default "#1d2021")
(set-face-foreground 'default "#ebdbb2")

(setq default-frame-alist
      '((background-color . "#1d2021")
	(foreground-color . "#ebdbb2")
	(cursor-color . "#fdf4c1")
	(vertical-scroll-bars . nil)
	(horizontal-scroll-bars . nil)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(ns-appearance . dark)
	(ns-transparent-titlebar . t)
	)
)

(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))
;(setq frame-resize-pixelwise t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
