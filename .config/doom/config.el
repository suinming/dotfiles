;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; ---------------------------------------------------------
;; Environment
;; ---------------------------------------------------------

;; Make ~/.local/bin available to Emacs
(let ((local-bin (expand-file-name "~/.local/bin")))
  (add-to-list 'exec-path local-bin)
  (setenv "PATH" (concat local-bin path-separator (getenv "PATH"))))

(use-package! exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))


;; ---------------------------------------------------------
;; Doom settings
;; ---------------------------------------------------------

(setq doom-font
      (font-spec :family "JetBrainsMono Nerd Font Mono" :size 20))
(setq doom-theme 'doom-tokyo-night)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")


;; ---------------------------------------------------------
;; Projectile
;; ---------------------------------------------------------

(after! projectile
  (setq projectile-project-search-path
        '("~/repo")))


;; ---------------------------------------------------------
;; LeetCode
;; ---------------------------------------------------------

(after! leetcode
  (setq leetcode-prefer-language "java")
  (setq leetcode-browser-function #'browse-url-default-browser))


;; ---------------------------------------------------------
;; Tree-sitter
;; ---------------------------------------------------------

(after! treesit
  (add-to-list
   'treesit-language-source-alist
   '(java "https://github.com/tree-sitter/tree-sitter-java")))


;; ---------------------------------------------------------
;; Consult
;; ---------------------------------------------------------

;; Enable preview when moving through project-search results
(after! consult
  (consult-customize
   consult-ripgrep
   +default/search-project
   :preview-key 'any))


;; ---------------------------------------------------------
;; Eglot
;; ---------------------------------------------------------

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eldoc-mode -1)))


;; ---------------------------------------------------------
;; Keybindings
;; ---------------------------------------------------------

;; Project search
;; SPC s p -> SPC f w
(map! :leader
      "s p" nil
      "f w" #'+default/search-project)
