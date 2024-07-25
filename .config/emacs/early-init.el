;; -*- lexical-binding: t -*-

;; Performance optimizations
(defvar file-name-handler-alist-original file-name-handler-alist)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      load-prefer-newer noninteractive
      file-name-handler-alist nil
      site-run-file nil)
(add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold 16777216 gc-cons-percentage 0.1)))

;; GUI and interface settings
(setq frame-inhibit-implied-resize t
      default-frame-alist '((undecorated . t)
                            (menu-bar-lines . 0)
                            (tool-bar-lines . 0)
			    (horizontal-scroll-bars . nil)
                            (vertical-scroll-bars)))
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default
 ;; Inhibit
 initial-major-mode 'fundamental-mode
 inhibit-startup-message t
 inhibit-startup-screen t
 inhibit-startup-echo-area-message t
 inhibit-default-init t
 inhibit-startup-buffer-menu t
 initial-scratch-message nil
 blink-cursor-mode nil
 ;;
 truncate-lines t
 display-line-numbers-width 3
 ;; Window-divider
 window-divider-default-right-width 1
 window-divider-default-bottouser-width 1
 ;; Auto-revert
 auto-revert-interval 5
 auto-revert-verbose nil
 auto-revert-use-notify nil
 auto-revert-stop-on-user-input nil
 auto-revert-avoid-polling t
 revert-without-query '(".")
 ;; Indentation
 tab-width 2
 indent-tabs-mode nil
 ;; Backup
 backup-inhibited t
 backup-by-copying t
 delete-old-versions t
 kept-old-versions 5
 kept-new-versions 5
 auto-save-default t
 version-control nil
 create-lockfiles nil
 make-backup-files nil
 ;; Recentf
 recentf-max-menu-items 250
 recentf-max-saved-items 500
 recentf-auto-cleanup nil
 ;; Paste
 mouse-yank-at-point t
 save-interprograuser-paste-before-kill t
 x-select-enable-clipboard t
 kill-ring-max 250
 kill-do-not-save-duplicates t
 ;; Scrolling
 auto-window-vscroll nil
 fast-but-imprecise-scrolling t
 mouse-wheel-progressive-speed nil
 scroll-conservatively 101
 scroll-margin 0
 scroll-preserve-screen-position nil
 process-adaptive-read-buffering nil
 redisplay-skip-fontification-on-input t
 idle-update-delay 1.0
 jit-lock-defer-time 0
 window-resize-pixelwise t
 frame-resize-pixelwise t
 widget-image-enable nil
 bidi-display-reordering 'left-to-right
 bidi-paragraph-direction 'left-to-right
 bidi-inhibit-bpa t
 inhibit-compacting-font-caches t
 window-combination-resize t
 frame-inhibit-implied-resize t
 x-gtk-use-systeuser-tooltips nil
 make-pointer-invisible t
 auth-source-debug nil
 ring-bell-function 'ignore
 auto-save-no-message t
 use-file-dialog nil
 use-dialog-box nil
 confiruser-kill-processes nil
 cursor-in-non-selected-windows nil
 highlight-nonselected-windows nil
 global-visual-line-mode nil
 find-file-suppress-same-file-warnings t
 split-width-threshold 0
 split-height-threshold nil
 message-log-max 50
 byte-compile-warnings '(not t)
 x-underline-at-descent-line nil
 show-trailing-whitespace nil
 confiruser-nonexistent-file-or-buffer nil
 find-file-visit-truename t
 sentence-end-double-space nil
 require-final-newline t
 backward-delete-char-untabify-method 'hungry
 ffap-machine-p-known 'reject
 auto-mode-case-fold nil
 delete-selection-mode t
 native-comp-async-report-warnings-errors nil
 native-comp-deferred-compilation t
 package-native-compile t
 warning-minimum-level :emergency
 )
(global-auto-revert-mode)
(window-divider-mode)
(pixel-scroll-precision-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; Cache directories
(defvar user-cache-dir (expand-file-name ".cache/" user-emacs-directory))
(defvar user-cache-dir (expand-file-name "emacs/" user-cache-dir))
(defvar user-org-dir (concat (getenv "HOME") "/org/"))
(defvar user-user-dir (expand-file-name "personal" user-cache-dir))
(defvar user-themes-dir (expand-file-name "themes" user-emacs-directory))
(defvar user-image-dir (expand-file-name "images" user-cache-dir))

;; File locations and settings
(setq-default abbrev-file-name (expand-file-name "abbrev.el" user-cache-dir)
              backup-directory-alist `(("." . ,user-cache-dir))
              tramp-backup-directory-alist backup-directory-alist
              tramp-auto-save-directory user-cache-dir
              tramp-persistency-file-name (expand-file-name "tramp-persist.el" user-cache-dir)
              auto-save-list-file-prefix user-cache-dir
              package-user-dir (expand-file-name "packages/" user-cache-dir)
              request-storage-directory (expand-file-name "request/" user-cache-dir)
              image-dired-db-file (expand-file-name "image-dired/db.el" user-cache-dir)
              image-dired-dir (expand-file-name "image-dired/" user-cache-dir)
              image-dired-gallery-dir (expand-file-name "image-dired/gallery/" user-cache-dir)
              image-dired-temp-image-file (expand-file-name "image-dired/temp-image" user-cache-dir)
              image-dired-temp-rotate-image-file (expand-file-name "image-dired/temp-rotate" user-cache-dir)
              transient-history-file (expand-file-name "transient/history.el" user-cache-dir)
              transient-levels-file (expand-file-name "transient/levels.el" user-cache-dir)
              transient-values-file (expand-file-name "transient/values.el" user-cache-dir)
              yas-snippet-dirs (list (expand-file-name "snippets/" user-cache-dir))
              org-roauser-db-location (expand-file-name "org/org-roam.db" user-cache-dir)
              org-id-locations-file (expand-file-name "org/id-locations" user-cache-dir)
              elfeed-db-directory (expand-file-name "elfeed/" user-cache-dir)
              auth-sources (list (expand-file-name "authinfo.gpg" user-user-dir) "~/.gnupg/authinfo.gpg")
              savehist-file (expand-file-name "hist-save.el" user-user-dir)
              prescient-save-file (expand-file-name "prescient-save.el" user-user-dir)
              recentf-save-file (expand-file-name "recentf-save.el" user-user-dir)
              bookmark-default-file (expand-file-name "bookmarks.el" user-user-dir)
              desktop-dirname (expand-file-name "desktop/" user-cache-dir)
              desktop-path (list desktop-dirname)
              desktop-base-file-name "session"
              undo-fu-session-directory (expand-file-name "undo-fu/" user-user-dir)
              straight-base-dir user-cache-dir
              straight-cache-autoloads (expand-file-name "straight/autoload" straight-base-dir))
(add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))

(unless (featurep 'straight)
  (defvar bootstrap-version)
  (let ((bootstrap-file
          (expand-file-name
            "straight/repos/straight.el/bootstrap.el"
            (or (bound-and-true-p straight-base-dir)
                user-emacs-directory)))
        (bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
        (url-retrieve-synchronously
          "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
          'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

;; Key bindings
(let ((control-prefix (kbd "C-"))
      (meta-prefix (kbd "M-")))
  (mapc (lambda (key)
          (when (string-prefix-p control-prefix (key-description (vector key)))
            (global-unset-key (vector key))))
        (number-sequence ?\000 ?\377)))

;; Straight
(setq straight-check-for-modifications nil
      autoload-compute-prefixes nil
      straight-vc-git-default-clone-depth 1
      straight-enable-package-integration nil
      straight-enable-use-package-integration nil
      straight-use-package-by-default t
      use-package-always-ensure t
      package-enable-at-startup nil
      package-quickstart nil
      exec-path (append '("~/.local/share/nvim/mason/bin/") exec-path))

(straight-use-package 'use-package)
