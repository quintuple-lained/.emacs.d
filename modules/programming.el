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
  :hook (python-mode . uv-mode-auto-activate-hook)
)

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
