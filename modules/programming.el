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

;; many more to come
