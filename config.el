;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package doom-themes
             :custom
             (doom-themes-enable-italic t)
             (doom-themes-enable-bold t)
             :custom-face
             (doom-modeline-bar ((t (:background "#6272a4"))))
             :config
             (load-theme 'doom-opera t)
             (doom-themes-neotree-config)
             (doom-themes-org-config))

(use-package doom-modeline
             :custom
             (doom-modeline-buffer-file-name-style 'truncate-with-project)
             (doom-modeline-icon t)
             (doom-modeline-major-mode-icon nil)
             (doom-modeline-minor-modes nil)
             :hook
             (after-init . doom-modeline-mode)
             :config
             (line-number-mode 1)
             (column-number-mode 1)
             (doom-modeline-def-modeline 'main
                                         '(bar workspace-number window-number evil-state god-state ryo-modal xah-fly-keys matches buffer-info remote-host buffer-position parrot selection-info)
                                         '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker)))

(use-package neotree
             :after
             projectile
             :commands
             (neotree-show neotree-hide neotree-dir neotree-find)
             :custom
             (neo-theme 'nerd2)
             :bind
             ("<f9>" . neotree-projectile-toggle)
             :preface
             (defun neotree-projectile-toggle ()
               (interactive)
               (let ((project-dir
                      (ignore-errors
                                 ;;; Pick one: projectile or find-file-in-project
                        (projectile-project-root)
                        ))
                     (file-name (buffer-file-name))
                     (neo-smart-open t))
                 (if (and (fboundp 'neo-global--window-exists-p)
                          (neo-global--window-exists-p))
                     (neotree-hide)
                   (progn
                     (neotree-show)
                     (if project-dir
                         (neotree-dir project-dir))
                     (if file-name
                         (neotree-find file-name)))))))


(use-package which-key
             :diminish which-key-mode
             :hook (after-init . which-key-mode))
