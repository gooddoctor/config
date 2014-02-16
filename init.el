(add-to-list 'load-path "~/.emacs.d/cc-mode-5.32/")
(add-to-list 'load-path "~/.emacs.d/helm/")

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-p") 'other-frame)

(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-4") 'new-frame)

(global-set-key (kbd "C-c o") 'ff-find-other-file)

(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "C-x C-p") 'previous-multiframe-window)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(auto-save-mode -1) 
(show-paren-mode 1)

(setq make-backup-files nil) 
(setq inhibit-startup-message t)
(setq backup-inhibited t)
(setq auto-save-default nil)

(require 'ido)
(ido-mode t)

(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)


(defvar ff-other-file-alist'())
(add-to-list 'ff-other-file-alist '("\\.cpp\\'" (".h" ".hpp" ".hh")))
(add-to-list 'ff-other-file-alist '("\\.h\\'" (".cpp")))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'cc-mode)
(add-to-list 'c++-mode-hook
	     (lambda () (setq c-syntactic-indentation nil)))

(defalias 'make-local-hook
  (if (featurep 'xemacs)
      'make-local-hook
    'ignore))

(define-skeleton skeleton-guard
  "insert guard"
  ""
  > "#ifndef " 
  > "__" (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))) "_H" "\n"
  > "#define " 
  > "__" (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))) "_H" "\n"
  > _ "\n"
  > "#endif")

(define-skeleton skeleton-class
  "class skeleton"
  "Class name: "
  "class " str " {\n"
  "private:\n"
  "public:\n" 
  > str "()" " {\n"
  > _  "\n"
  "private:\n"
  "};")

(define-skeleton skeleton-main
  "main"
  ""
  "int main(int argc, char** argv) {\n"
  > _ "\n"
  "}")


