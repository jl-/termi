;; Evil mode
;; C-z to toggle
(use-package evil
             :ensure t
             :init
             (setq evil-want-keybinding nil)
             :config
             (evil-mode 1))

(use-package evil-escape
             :ensure t
             :init
             (setq-default evil-escape-key-sequence "jk")
             :config
             (evil-escape-mode 1))

(use-package evil-collection
             :after evil
             :ensure t
             :config
             (evil-collection-init))
