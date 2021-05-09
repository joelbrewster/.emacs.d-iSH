;;; early-init.el --- -*- lexical-binding: t -*-

;; DeferGC
(setq gc-cons-threshold (* 50 1000 1000))
;; -DeferGC

;; UnsetPES
(setq package-enable-at-startup nil)
;; -UnsetPES

;; UnsetFNHA
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
;; -UnsetFNHA

;; UnsetSRF
(setq site-run-file nil)
;; -UnsetSRF

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; In Emacs 27+, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'.
(setq package-enable-at-startup nil)
(advice-add #'package--ensure-init-file :override #'ignore)

;; Speed up boot by limiting resize
(setq frame-inhibit-implied-resize t)

;; Resize off pixels
(setq frame-resize-pixelwise t)

;; Ignore X resources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Prevent unwanted runtime builds
(setq comp-deferred-compilation nil)

;; Make startup look cleaner
(setq-default inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq-default visual-line-fringe-indicators nil)

;; Remove the annoying cl is deprecated warning
(setq byte-compile-warnings '(cl-functions))

;;  (load "server")
;;  (unless (server-running-p) (server-start))
