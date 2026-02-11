;; -*- mode: emacs-lisp; lexical-binding: t; -*-

(defun my/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'my/display-startup-time)

;; customize management
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; straight el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; system specific stuff
(defvar my-system-type
  (cond
   ((string-match-p "Android" system-configuration) 'android)
   ((string-match-p "microsoft-standard" (shell-command-to-string "uname -r 2>/dev/null")) 'wsl)
   ((file-exists-p "/etc/gentoo-release") 'gentoo)
   ((file-exists-p "/etc/lsb-release") 'ubuntu)
   ((eq system-type 'gnu/linux) 'linux)
   (t system-type))
  "Identifies the current environment for loading specific configs.")

;; module loading stuff
(defun load-module (name)
  (let ((file (expand-file-name (format "modules/%s.el" name) user-emacs-directory)))
    (if (file-exists-p file)
        (load file)
      (message "Module %s not found" name))))

;; core modules, although some might have to move to system specific ones
(load-module "ui")
(load-module "editor")
(load-module "programming")
(load-module "org")

;; once ive got this more established i can load system specific stuff here
(let ((sys-file (expand-file-name (format "systems/%s.el" my-system-type) user-emacs-directory)))
  (if (file-exists-p sys-file)
      (load sys-file)
    (message "No system-specific config found for %s" my-system-type)))

;; load host specific config only if they exist
(let ((host-file (expand-file-name (format "hosts/%s.el" (system-name)) user-emacs-directory)))
  (when (file-exists-p host-file) (load host-file)))

;; reset gc threshold after init
(setq gc-cons-threshold (* 10 1024 1024))

;; emacs put these here so ig they should be here
(put 'downcase-region 'disabled nil)
