(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "M-p") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "M-h") (lambda () (interactive)
			      (let ((file (concat 
					  (replace-regexp-in-string "\\..+$" "" 
								    (buffer-name))
					  ".hpp")))
				(if (file-exists-p file)
				    (progn
				      (split-window-below)
				      (find-file file))))))
(global-set-key (kbd "M-c") (lambda () (interactive)
			      (let ((file (concat 
					   (replace-regexp-in-string "\\..+$" "" 
								     (buffer-name))
					   ".cpp")))
				(if (file-exists-p file)
				    (progn
				      (split-window-below)
				      (find-file file))))))
(define-key minibuffer-local-filename-completion-map (kbd "SPC")
  'minibuffer-complete-word)


(add-to-list 'load-path "~/.emacs.d/cc-mode-5.32/")
(add-to-list 'load-path "~/.emacs.d/helm/")


(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq sort-fold-case t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(auto-save-mode -1)
(show-paren-mode 1)


(defalias 'make-local-hook
  (if (featurep 'xemacs)
      'make-local-hook
    'ignore))

(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Monospace-16"))
(fontify-frame nil)
(push 'fontify-frame after-make-frame-functions)

(defun sort-words (reverse beg end)
  (interactive "*P\nr")
  (sort-regexp-fields reverse "[^[:space:]]+" "\\&" beg end))

(defun my-goto-match-beginning ()
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))

(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)

(defadvice isearch-exit (after my-goto-match-beginning activate)
  "Go to beginning of match."
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))


(require 'ido)
(ido-mode t)
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(require 'cc-mode)
(add-to-list 'c++-mode-hook
             (lambda () (setq c-syntactic-indentation nil)))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


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


