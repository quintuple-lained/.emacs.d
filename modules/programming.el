;; -*- mode: emacs-lisp; lexical-binding: t; -*-

(use-package eglot
  :ensure nil
  :hook (
	 (python-mode . eglot-ensure)
	 (python-ts-mode . eglot-ensure)
	 )
  :config
  (add-to-list 'eglot-server-programs
	       '((python-mode python-ts-mode) . ("ruff" "server") )
	       )
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (when (derived-mode-p 'python-mode 'python-ts-mode)
                (add-hook 'before-save-hook #'eglot-format-buffer nil t)
		)
	      )
	    )
)

(use-package vterm)

(use-package markdown-mode
  :hook (markdown-mode . visual-line-mode)
)

(use-package yaml-mode)
(use-package json-mode)

;; kubernetes stuff here
(use-package k8s-mode
  :ensure t
  :hook (k8s-mode . yas-minor-mode)
)
;; python stuff here
(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :hook (python-mode . eglot-ensure)
  :config
  )


(use-package uv-mode
  :hook (python-mode . uv-auto-activate-hook)
  )

;; clojure support
(use-package clojure-mode
  :mode ("\\.clj\\'" . clojure-mode))

(use-package cider
  :hook (clojure-mode . cider-mode)
  :config
  ;; logical defaults for a streamlined repl experience
  (setq cider-repl-display-help nil                 ; keep repl buffer clean
        cider-repl-pop-to-buffer-on-connect t       ; focus repl on startup
        cider-repl-use-pretty-printing t            ; readable output
        cider-font-lock-dynamically t               ; highlight based on repl state
        cider-save-file-on-load t                   ; avoid prompt on C-c C-k
        cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory))
  (add-hook 'cider-mode-hook #'eldoc-mode)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(clojure-mode . ("clojure-lsp"))))

(add-hook 'clojure-mode-hook #'eglot-ensure)
  :hook (python-mode . uv-mode-auto-activate-hook))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode)
  )

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  )

(use-package treemacs
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)
	)
  )

(use-package breadcrumb
  :config (breadcrumb-mode 1)
  )

(use-package consult-lsp
  :bind (("M-S l" . consult-lsp-symbols))
  )

(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-mode))
;; many more to come
