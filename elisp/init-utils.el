(use-package super-save
  ;; 自动保存，用于替换默认的自动保存
  :ensure t
  :init
  (setq super-save-auto-save-when-idle t
	super-save-idle-duration 1)
  :config
  (super-save-mode +1))

(use-package which-key
  ;; emacs按键提示
  :ensure t
  :init
  (setq which-key-idle-delay 0.5)
  :config
  (which-key-mode))

(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(provide 'init-utils)
