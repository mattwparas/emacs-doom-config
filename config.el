;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;(after! neotree
 ; (setq doom-themes-neotree-file-icons 'icons)
  ;(setq doom-themes-neotree-enable-file-icons 'icons)
  ;(setq neo-theme 'icons))

;(after! doom-themes
  ;(setq doom-neotree-file-icons t))

(after! ivy
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order))))

(after! projectile
  (setq projectile-create-missing-test-files t)
  (projectile-register-project-type 'haskell-stack '("stack.yaml")
                                    :compile "stack build"
                                    :test "stack build --test"
                                    :test-suffix "Test")
  (projectile-mode)
  (projectile-load-known-projects))

(after! company
  (setq company-idle-delay 0))

(def-package! rust-mode
  :mode "\\.rs$"
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (setq rust-format-on-save t)
  (flycheck-mode))

;; (add-hook! flycheck-rust
;;   :after rust-mode
;;   :config
;;   (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; (def-package! racer
;;   :after rust-mode
;;   :config
;;   (setq racer-rust-src-path
;;         (concat
;;          (replace-regexp-in-string "\n$" "" (shell-command-to-string "rustc --print sysroot"))
;;          "/lib/rustlib/src/rust/src"))
;;   (company-mode)
;;   (eldoc-mode))

(def-package! flycheck-mix
  :after elixir-mode
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-mix-setup))

(def-package! flycheck-credo
  :after elixir-mode
  :config
  (setq flycheck-elixir-credo-strict t)
  (add-hook 'flycheck-mode-hook #'flycheck-credo-setup))

(def-package! lux-mode
  :mode "\\.lux$")

(def-package! erlang
  :mode "\\.erl$"
  :config
  (erlang-mode))

(def-package! racket-mode
  :mode "\\.rkt$"
  :config
  (company-mode)
  (flycheck-mode)
  (rainbow-delimiters-mode)
  (racket-unicode-input-method-enable))

(def-package! aggressive-indent
  :hook
  (clojure-mode . aggressive-indent-mode)
  (hy-mode . aggressive-indent-mode)
  (lisp-mode . aggressive-indent-mode))

(after! clojure-mode
  (define-clojure-indent
    (PUT 2)
    (POST 2)
    (GET 2)
    (PATCH 2)
    (DELETE 2)
    (context 2)
    (for-all 2)
    (checking 3))
  (setq clojure-align-forms-automatically t)
  (setq cider-cljs-lein-repl
        "(do (require 'figwheel-sidecar.repl-api)
         (figwheel-sidecar.repl-api/start-figwheel!)
         (figwheel-sidecar.repl-api/cljs-repl))")
  (setq cljr-magic-require-namespaces
        '(("io" . "clojure.java.io")
          ("sh" . "clojure.java.shell")
          ("jdbc" . "clojure.java.jdbc")
          ("set" . "clojure.set")
          ("time" . "java-time")
          ("str" . "cuerdas.core")
          ("path" . "pathetic.core")
          ("walk" . "clojure.walk")
          ("zip" . "clojure.zip")
          ("async" . "clojure.core.async")
          ("component" . "com.stuartsierra.component")
          ("http" . "clj-http.client")
          ("url" . "cemerick.url" )
          ("sql" . "honeysql.core")
          ("csv" . "clojure.data.csv")
          ("json" . "cheshire.core")
          ("s" . "clojure.spec.alpha")
          ("fs" . "me.raynes.fs")
          ("ig" . "integrant.core")
          ("cp" . "com.climate.claypoole")
          ("re-frame" . "re-frame.core")
          ("rf"       . "re-frame.core")
          ("re"       . "reagent.core")
          ("reagent"  . "reagent.core")
          ("u.core"   . "utopia.core"))))

(def-package! graphql-mode
  :mode "\\.gql$")

(def-package! lsp-mode
  :hook
  (haskell-mode . lsp)
  (python-mode . lsp)
  (rust-mode . lsp)
  :commands
  lsp)

(def-package! lsp-ui
  :commands
  lsp-ui-mode)

(def-package! company-lsp
  :commands company-lsp)

(def-package! lsp-haskell
  :after haskell-mode
  :config
  (setq lsp-haskell-process-path-hie "hie-wrapper"))

(def-package! yapfify
  :hook
  (python-mode . yapf-mode)
  (before-save . yapify-buffer))


(def-package! haskell-mode
  :mode "\\.hs$"
  :config
  (rainbow-delimiters-mode)
  ;; (setq haskell-font-lock-symbols t)
  (add-to-list ("<>" . "⊕"))
  (setq haskell-font-lock-symbols-alist
        (-reject
         (lambda (elem)
           (or))
         ;; (string-equal "::" (car elem))))
         haskell-font-lock-symbols-alist)))

(def-package! agda2-mode
  :mode "\\.agda$"
  :interpreter "agda2"
  :preface
  (let ((agda-mode-directory
         (file-name-directory
          (shell-command-to-string "agda-mode locate"))))
    (add-to-list 'load-path agda-mode-directory)
    (let ((inhibit-message t))
      (byte-recompile-directory agda-mode-directory 0)))
  :config
  (set-face-attribute 'agda2-highlight-bound-variable-face nil
                      :foreground "#ede0ce"
                      :slant 'italic)
  (set-face-attribute 'agda2-highlight-catchall-clause-face nil
                      :overline "#7bc275")
  (set-face-attribute 'agda2-highlight-coinductive-constructor-face nil
                      :foreground "#c57bdb")
  (set-face-attribute 'agda2-highlight-coverage-problem-face nil
                      :box '(:line-width 1 :color "#5cefff"))
  (set-face-attribute 'agda2-highlight-datatype-face nil
                      :foreground "#fcce7b")
  (set-face-attribute 'agda2-highlight-dotted-face nil
                      :foreground "#5e5e5e")
  (set-face-attribute 'agda2-highlight-error-face nil
                      :strike-through "#c82829")
  (set-face-attribute 'agda2-highlight-field-face nil
                      :foreground "#7bc275")
  (set-face-attribute 'agda2-highlight-function-face nil
                      :foreground "#ff5555")
  (set-face-attribute 'agda2-highlight-inductive-constructor-face nil
                      :foreground "#fb2874")
  (set-face-attribute 'agda2-highlight-keyword-face nil
                      :foreground "#268bd2"
                      :underline nil)
  (set-face-attribute 'agda2-highlight-macro-face nil
                      :foreground "#99bb66")
  (set-face-attribute 'agda2-highlight-module-face nil
                      :foreground "#d33682")
  (set-face-attribute 'agda2-highlight-number-face nil
                      :foreground "#7bc275")
  (set-face-attribute 'agda2-highlight-positivity-problem-face nil
                      :box '(:line-width 2 :color "#f6bfbc"))
  (set-face-attribute 'agda2-highlight-postulate-face nil
                      :foreground "#51afef")
  (set-face-attribute 'agda2-highlight-primitive-face nil
                      :foreground "#c57bdb")
  (set-face-attribute 'agda2-highlight-primitive-type-face nil
                      :foreground "#c57bdb")
  (set-face-attribute 'agda2-highlight-record-face nil
                      :foreground "#fcce7B")
  (set-face-attribute 'agda2-highlight-string-face nil
                      :foreground "#7bc275")
  (set-face-attribute 'agda2-highlight-symbol-face nil
                      :foreground "#5B6268")
  (set-face-attribute 'agda2-highlight-termination-problem-face nil
                      :box '(:line-width 2 :color "#a60033"))
  (set-face-attribute 'agda2-highlight-unsolved-constraint-face nil
                      :strike-through "#c57bdb")
  (set-face-attribute 'agda2-highlight-unsolved-meta-face nil
                      :box '(:line-width 1 :color "#fcce7B")))
