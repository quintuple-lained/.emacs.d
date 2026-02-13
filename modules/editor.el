;; -*- gMmode: emacs-lisp; lexical-binding: t; -*-

; general settings
(defalias 'yes-or-no-p 'y-or-n-p)
(setq initial-major-mode 'fundamental-mode)
(setq sentence-end-double-space nil)
(setq-default explicit-shell-file-name "/bin/fish")
(global-unset-key (kbd "C-z"))
(pixel-scroll-precision-mode)

; autosaves and such
(defvar autosave-dir (expand-file-name "~/.emacs-autosaves/"))
(unless (file-exists-p autosave-dir) (make-directory autosave-dir t))
(setq auto-save-filename-transforms `((".*" ,autosave-dir t)))
(setq make-backup-files nil)

;; files and history
(global-auto-revert-mode t)
(setq auto-revert-check-vc-info t)
(setq switch-to-buffer-obey-display-actions t)

;; completion stuff
(setq completion-cycle-threshold 1
      completions-detailed t
      tab-always-indent 'complete
      completion-styles '(basic initials substring)
      completion-auto-help 'always
      completions-max-height 20
      completions-format 'one-column
      completions-group t
      completion-auto-select 'second-tab)

;; neat keybinds totally original
(define-key global-map (kbd "C-x C-o") (kbd "C-x o"))  ;; Switch window
(define-key global-map (kbd "C-o") (kbd "C-e RET"))    ;; New line below
(define-key global-map (kbd "C-S-o") (kbd "C-p C-e RET")) ;; New line above
(define-key global-map (kbd "M-j") (kbd "C-u M-^"))    ;; Join line

;; my functions
(defun reload-emacs-conf ()
  "Reload the emacs config"
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory))
  (message "Reloaded emacs config"))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges) (car next-win-edges))
                                     (<= (cadr this-win-edges) (cadr next-win-edges)))))
             (splitter (if (= (car this-win-edges) (car (window-edges (next-window))))
                           'split-window-horizontally
                         'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-x |") 'toggle-window-split)

(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t)
)

(use-package savehist
  :init
  (savehist-mode 1)
)

(use-package marginalia
  :init
  (savehist-mode 1)
)

(use-package orderless
  :custom
  (completion-syles '(oderless basic))
  (completion-category-overrides '((file (syles basic partial-completion))))
)

(use-package consult
  :bind (
	("C-s" . consult-line)
	("C-x b" . consult-buffer)
	("M-y" . consult-yank-pop)
       )
)

(use-package avy
  :bind ("C-<tab>" . avy-goto-char-timer)
  :config
  (setq avy-timeout-seconds 0.3))

(use-package smartparens
  :bind (
	 ("<localleader>(" . sp-wrap-round)
         ("<localleader>{" . sp-wrap-curly)
         ("<localleader>[" . sp-wrap-square)
         ("<localleader>DEL" . sp-splice-sexp-killing-backward)
	)
)
