;;; package management
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://mirrors.cloud.tencent.com/elpa/gnu/")
			 ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(require 'init-better)
(require 'init-utils)
(require 'init-filemanage)
