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
;; Tree-sitter grammars
;; ---------------------------------------------------------

(after! treesit
  (dolist (g '((java       "https://github.com/tree-sitter/tree-sitter-java")
               (python     "https://github.com/tree-sitter/tree-sitter-python")
               (go         "https://github.com/tree-sitter/tree-sitter-go")
               (gomod      "https://github.com/camdencheek/tree-sitter-go-mod")
               (c          "https://github.com/tree-sitter/tree-sitter-c")
               (cpp        "https://github.com/tree-sitter/tree-sitter-cpp")
               (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
               (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
               (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
               (json       "https://github.com/tree-sitter/tree-sitter-json")
               (yaml       "https://github.com/ikatyang/tree-sitter-yaml")
               (css        "https://github.com/tree-sitter/tree-sitter-css")
               (html       "https://github.com/tree-sitter/tree-sitter-html")))
    (add-to-list 'treesit-language-source-alist g)))

(defun my/treesit-install-all-grammars ()
  "Install every grammar in `treesit-language-source-alist' that is missing."
  (interactive)
  (dolist (entry treesit-language-source-alist)
    (unless (treesit-language-available-p (car entry))
      (treesit-install-language-grammar (car entry)))))


;; ---------------------------------------------------------
;; Formatting (SPC c f)
;; ---------------------------------------------------------

;; Web languages: prefer prettier (via apheleia) over tsserver's formatter.
(setq-hook! '(js-mode-hook js-ts-mode-hook
              typescript-mode-hook typescript-ts-mode-hook tsx-ts-mode-hook
              web-mode-hook vue-mode-hook css-mode-hook css-ts-mode-hook
              json-mode-hook json-ts-mode-hook)
  +format-with-lsp nil)

;; ---------------------------------------------------------
;; Eglot
;; ---------------------------------------------------------

(after! eglot
  (setq eglot-sync-connect nil
        eglot-autoshutdown t
        eglot-events-buffer-config '(:size 0))

  ;; Python: force pyright (eglot's default is pylsp)
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio")))

  ;; Vue 3: see notes below
  (add-to-list 'eglot-server-programs
               `(vue-mode
                 . ,(lambda (&optional _interactive _project)
                      (let ((tsdk (expand-file-name
                                   "typescript/lib"
                                   (string-trim (shell-command-to-string "npm root -g")))))
                        `("vue-language-server" "--stdio"
                          :initializationOptions
                          (:vue (:hybridMode :json-false)
                           :typescript (:tsdk ,tsdk))))))))

;; .vue files get their own mode derived from web-mode, so eglot can target them
(after! web-mode
  (define-derived-mode vue-mode web-mode "Vue"))
(autoload 'vue-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

;; Optional: format Java on save through jdtls
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'java-mode 'java-ts-mode)
              (add-hook 'before-save-hook #'eglot-format-buffer nil t))))

(add-hook 'java-mode-local-vars-hook #'eglot-ensure)
(add-hook 'java-ts-mode-local-vars-hook #'eglot-ensure)

(defun my/format-java ()
  "Format Java via jdtls, everything else via Doom."
  (interactive)
  (if (and (bound-and-true-p eglot--managed-mode)
           (derived-mode-p 'java-mode 'java-ts-mode))
      (eglot-format-buffer)
    (call-interactively #'+format/region-or-buffer)))

(map! :leader :desc "Format buffer/region" "c f" #'my/format-java)

;; Hover docs: keep eldoc on, but stop it from flooding the echo area.
;; (Your old hook turned eldoc off, which makes `K' show nothing.)
(setq eldoc-echo-area-use-multiline-p nil)

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
