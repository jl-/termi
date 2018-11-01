;; Projectile
(use-package projectile
             :ensure t
             :init
             (setq projectile-require-project-root nil)
             :config
             (projectile-mode 1))

;; All The Icons
(use-package all-the-icons :ensure t)

;; NeoTree
(use-package neotree
             :ensure t
             :init
             (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

