;;; file management workflow

;; open file 
(defun xah-open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.
When called in emacs lisp, if @fname is given, open that.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2019-11-04"
  (interactive)
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (w32-shell-execute "open" $fpath))
         $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))
         $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath)))
         $file-list))))))

(define-key dired-mode-map (kbd "<C-return>") 'xah-open-in-external-app)

;; sidebar browse
(use-package neotree
  :ensure t
  :init (setq neo-window-fixed-size nil
	      neo-theme (if (display-graphic-p) 'icons 'classic))
  :bind (("<f8>" . neotree-toggle)))

;; tabs navigation
(use-package centaur-tabs
  :ensure t
  :init (centaur-tabs-mode)
  :config
  (setq centaur-tabs-style "bar"
	centaur-tabs-height 22
	centaur-tabs-set-icons t
	centaur-tabs-plain-icons t
	centaur-tabs-gray-out-icons t
	centaur-tabs-set-close-button t
	centaur-tabs-set-modified-marker t
	centaur-tabs-show-navigation-buttons t
	centaur-tabs-set-bar 'left
	centaur-tabs-cycle-scope 'tabs
 	x-underline-at-descent-line nil)
  (centaur-tabs-headline-match)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.
 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ((ignore-errors
	 (and (string= "*xwidget" (substring (buffer-name) 0 8))
	      (not (string= "*xwidget-log*" (buffer-name)))))
       "Xwidget")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
	   (memq major-mode '(magit-process-mode
			      magit-status-mode
			      magit-diff-mode
			      magit-log-mode
			      magit-file-mode
			      magit-blob-mode
			      magit-blame-mode
			      )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
			  help-mode))
       "Help")
      ((memq major-mode '(org-mode
			  org-agenda-clockreport-mode
			  org-src-mode
			  org-agenda-mode
			  org-beamer-mode
			  org-indent-mode
			  org-bullets-mode
			  org-cdlatex-mode
			  org-agenda-log-mode
			  diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-c b" . centaur-tabs-backward)
  ("C-c n" . centaur-tabs-forward)
  ("C-c m" . centaur-tabs-forward-group)
  ("C-c v" . centaur-tabs-backward-group))

;; search file and content
(use-package swiper
  :ensure nil
  :bind (("C-s" . swiper)))

(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

(use-package bookmark
      :ensure nil
      :bind (("C-x r m" . bookmark-set)
	     ("C-x r d" . bookmark-delete)
	     ("C-x r j" . bookmark-jump)))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c c t" . counsel-load-theme)
         ("C-c c b" . counsel-bookmark)
         ("C-c c r" . counsel-rg)
         ("C-c c f" . counsel-fzf)
         ("C-c c g" . counsel-git)))

;; beautify dired
(use-package diredfl
  :ensure t
  :config (diredfl-global-mode t))

(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(provide 'init-filemanage)
