; ~/.emacs.d/my-noexternals.el

;; Remove scrollbars, menu bars, and toolbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Set C-s to save
(global-set-key (kbd "C-s") 'save-buffer)

(add-hook 'python-mode-hook
  (lambda ()
    (set (make-local-variable 'compile-command)
      (concat "python3 " buffer-file-name))))

;; Use c++-mode for .h files.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(global-linum-mode 1)

(setq inhibit-splash-screen t)
