;;; better defaults
(unless (or (fboundp 'helm-mode) (fboundp 'ivy-mode))
  (ido-mode t)
  (setq ido-enable-flex-matching t))

(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; https://www.emacswiki.org/emacs/SavePlace
(save-place-mode 1)

(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C-c C-/") 'comment-or-uncomment-region)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain)

(require 'dired-x)
(delete-selection-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1) ;; 自动加载更新内容
(fset 'yes-or-no-p 'y-or-n-p)
(setq custom-file (concat user-emacs-directory "custom.el"))
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil) ;; 不允许备份
(setq auto-save-default nil  ;; 不允许自动保存
      auto-save-silent t)
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)
(setq confirm-kill-emacs
      (lambda (prompt) (y-or-n-p-with-timeout "Whether to quit Emacs:" 10 "y")))
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always);;全部递归拷贝删除文件夹中的文件

(provide 'init-better)
