(setq straight-use-package-by-default t)
(setq straight-vc-git-default-clone-depth 1)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(eval-and-compile
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6))

(setq user-full-name "Joel Brewster"
      user-mail-address "hi@joelbrewster.com")

(defun eshell-here ()
  (interactive)
  (let* ((parent (if (buffer-file-name)
		     (file-name-directory (buffer-file-name))
		   default-directory))
	 (name (car (last (split-string parent "/" t)))))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))
    ))
(global-set-key (kbd "C-c t") 'eshell-here)

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-hide-details-mode)))
(setq dired-dwim-target t)

(use-package magit
  :straight
  (magit
   :type git
   :host github
   :repo "magit/magit")
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :commands (magit-status magit-blame magit-log-buffer-file magit-log-all))
(add-hook 'magit-mode-hook
	  (lambda ()
	    (setq left-fringe-width 8)))

(use-package minions
  :straight
  (minions
   :type git
   :host github
   :repo "tarsius/minions")
  :init (minions-mode 1))

(setq org-use-speed-commands t)
(setq org-confirm-babel-evaluate 'nil)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d!)")))

(setq org-agenda-window-setup 'this-window)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-inhibit-startup t)
(setq org-agenda-skip-unavailable-files t)
(setq org-agenda-skip-scheduled-if-done t)

;; Use current window for agenda
(setq org-agenda-window-setup 'current-window)

;; Don't adapt content
(setq org-adapt-indentation nil)

;; Hide markup elements - emphasis markers
(setq org-hide-emphasis-markers t)

;; Be able to select whole lines with shift
(setq org-support-shift-select t)

(setq org-ellipsis " [+]")
(setq org-refile-targets
      '(("archive.org" :maxlevel . 1)
	("life.org" :maxlevel . 1)
	("work.org" :maxlevel . 2)))
;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-agenda-files (list "~/org/inbox.org"
			     "~/org/habit.org"
			     "~/org/dates.org"
			     "~/org/finances.org"
			     "~/org/calendar.org"
			     "~/org/weather.org"
			     "~/org/life.org"))
(setq org-capture-templates
      '(
	("i" "Inbox" entry (file "~/org/inbox.org")
	 "* TODO %?\n  %i\n")

	("l" "Life" entry (file "~/org/life.org")
	 "* TODO %?\n  %i\n")

	("w" "Work" entry (file "~/org/work.org")
	 "* TODO %?\n  %i\n")

	("b" "Bookmarks" entry (file "~/org/bookmarks.org")
	 "* %?\n  %i\n")

	("c" "Contacts" entry (file "~/org/contacts.org")
	 "* %?\n  %i\n")

	("r" "Resource" entry (file "~/org/life.org")
	 "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
	))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(with-eval-after-load 'org
  (bind-key "C-c C-f" #'browse-url-firefox org-mode-map))

(use-package project
  :bind
  (("C-c p" . project-switch-project)
   ("C-c f" . project-find-file)
   ("C-c g" . project-find-regexp)))

(use-package which-key
  :straight
  (which-key
   :type git
   :host github
   :repo "justbur/emacs-which-key")
  :init
  (which-key-mode))

;; overwrite selected text
(delete-selection-mode t)

;; y and n instead of yes and no everywhere
(fset 'yes-or-no-p 'y-or-n-p)

;; Make the backspace properly erase the tab instead of removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; Kill the whole line
(setq kill-whole-line t)

;; Normal delete setup
(normal-erase-is-backspace-mode 0)

;; Set history-length longer
(savehist-mode 1)
(setq-default history-length 500)

;; Save place mode
(save-place-mode +1)

;; Show Keystrokes quicker
(setq echo-keystrokes 0.1)

;; Visual wrap mode
;; (global-visual-line-mode 1)

;; Move Custom-Set-Variables to different file
(setq custom-file (concat user-emacs-directory "custom.el"))

;; So long for minified files
(when (require 'so-long nil :noerror)
  (global-so-long-mode 1))

;; Stop autosave and backups
(setq make-backup-files nil) ;; stop creating backup~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(setq create-lockfiles nil)  ;; stop creating lockfiles

;; Electric pair mode
(electric-pair-mode t)

;; Show paren mode
(show-paren-mode 1)

;; Replace selection on insert
(delete-selection-mode 1)

;; Turn Off Cursor Alarms
(setq ring-bell-function 'ignore)

;; Enable global auto-revert
(global-auto-revert-mode t)

;; Change cursor to be a bar
(setq-default cursor-type 'bar)

;; Window divider mode
(setq window-divider-default-right-width 1)
(setq window-divider-default-bottom-width 1)
(setq window-divider-default-places 'right-only)
(add-hook 'after-init-hook #'window-divider-mode)

;; Don't ask about opening large files
(setq large-file-warning-threshold nil)

(progn
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super)
  (global-unset-key (kbd "M-<down-mouse-1>"))
  (global-unset-key (kbd "M-<down-mouse-2>"))
  (global-set-key [M-down-mouse-1] #'mouse-drag-region-rectangle)
  (global-set-key [M-drag-mouse-1] #'ignore)
  (global-set-key [M-mouse-1]      #'mouse-set-point))
(bind-keys
 ("s-n" . make-frame-command)
 ("s-m" . iconify-frame)
 ("s-s" . save-buffer)
 ("s-o" . find-file)
 ("s-w" . delete-frame)
 ("s-q" . save-buffers-kill-terminal)
 ("s-a" . mark-whole-buffer)
 ("s-z" . undo-only) ;; Why no redo? Read up on it.
 ("s-x" . kill-region)
 ("s-c" . kill-ring-save)
 ("s-v" . yank)
 ("s-<up>" . beginning-of-buffer)
 ("s-<down>" . end-of-buffer)
 ("s-<left>" . beginning-of-visual-line)
 ("s-<right>" . end-of-visual-line)
 ("s-b" . switch-to-buffer)
 ("s-B" . ibuffer)
 ("s-[" . previous-buffer)
 ("s-]" . next-buffer)
 ("s-k" . kill-this-buffer)
 ("s-P" . project-switch-project)

 ("M-u" . upcase-dwim)
 ("M-l" . downcase-dwim)
 ("M-c" . capitalize-dwim)
 ("C-c C-f" . browse-url-firefox)
 ("C-c w" . eww)
 )

(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)
