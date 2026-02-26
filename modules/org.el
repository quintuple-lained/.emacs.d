;; -*- mode: emacs-lisp; lexical-binding: t; -*-

;; could use some more work tbh
(use-package org
  :hook ((org-mode . visual-line-mode)
         (org-mode . flyspell-mode))
  :config
  (add-to-list 'org-export-backends 'md)
  (setq org-export-with-smart-quotes t)
  (setq org-image-actual-width nil)
  (setq org-todo-keywords
        '((sequence "TODO" "PROG" "WAIT" "|"  "DONE" "CNCL" "VOID")))
  (setq org-todo-keyword-faces
        '(("TODO" . "red")
          ("PROG" . "magenta")
          ("WAIT" . "orange")
          ("DONE" . "green")
          ("CNCL" . "olive drab")
          ("VOID" . "dim gray")))
  (setq org-tag-alist '((:startgroup) ("home" . ?h) ("work" . ?w) ("school" . ?s) (:endgroup)
                        (:newline)
                        (:startgroup) ("one-shot" . ?o) ("project" . ?j) ("tiny" . ?t) (:endgroup)
                        ("meta") ("review") ("reading"))))

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/org-roam"))
  (org-roam-db-autosync-mode)
)

(defun today-org (directory)
  "Create an .org file in the specified DIRECTORY named with the current date."
  (interactive "DDirectory: ")
  (let* ((current-date (format-time-string "%Y-%m-%d"))
         (filename (concat current-date ".org"))
         (filepath (expand-file-name filename directory)))
    (if (file-exists-p filepath)
        (message "File already exists: %s" filepath)
      (write-region "" nil filepath)
      (find-file filepath)
      (message "Created file: %s" filepath))))
