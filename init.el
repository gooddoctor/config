(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "<s-tab>") 'complete-symbol)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-n") 'find-tag)
(global-set-key (kbd "M-p") 'pop-tag-mark)
(global-set-key (kbd "C-c o") 'ff-find-other-file)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq make-backup-files nil) 
(setq inhibit-startup-message t)


(require 'ido)
(ido-mode t)

(auto-save-mode -1) 
(show-paren-mode 1)

(defvar ff-other-file-alist'())
(add-to-list 'ff-other-file-alist '("\\.cpp\\'" (".h" ".hpp" ".hh")))
(add-to-list 'ff-other-file-alist '("\\.h\\'" (".cpp")))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-to-list 'load-path "~/.emacs.d/helm/")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)

(setq exec-path (cons "~/xref" exec-path))
(setq load-path (cons "~/xref/emacs" load-path))
(load "xrefactory")

(define-skeleton skeleton-guard
  "insert guard"
  ""
  > "#ifndef " 
  > "__" (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))) "_H__" "\n"
  > "#define " 
  > "__" (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))) "_H__" "\n"
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

(setq skeleton-pair 1)
(define-key global-map (kbd "(") 'skeleton-pair-insert-maybe)
(define-key global-map (kbd "{") 'skeleton-pair-insert-maybe)
(define-key global-map (kbd "[") 'skeleton-pair-insert-maybe)
(define-key global-map (kbd "\"") 'skeleton-pair-insert-maybe)
(define-key global-map (kbd "'") 'skeleton-pair-insert-maybe)
(define-key global-map (kbd "<") 'skeleton-pair-insert-maybe)


(defun my-column-ruler (width)
  "Display temp ruler at point."
  (interactive `(,(+ (window-hscroll)(window-width))))
  (momentary-string-display
   (let* ((iterations (/ (1- width) 10))
	  (result1 "|...|....|")
	  (result2 "1   5   10")
	  (inc1 "....|....|")
	  (inc2 "        %d0")
	  (i 1))
     (while  (<= i iterations)
       (setq i (1+ i))
       (setq result1 (concat result1 inc1))
       (setq result2 (concat result2 (substring (format inc2 i) -10))))
     (concat (substring result2 0 width) "\n"
	     (substring result1 0 width) "\n"))
   (line-beginning-position)
   "[space] Clears ruler"))


(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -type f -name \"*.h\" -or -name \"*.cpp\" -or -name \"*.c\" | /home/gooddocteur/bin/etags -" 
	   dir-name)))

(defun tag-info ()
  (interactive)
  (let ((tag (thing-at-point 'word)))
    (if (not (eq tag nil))
	(tags-apropos tag)
      (tags-apropos (read-from-minibuffer "Tag?: ")))))
(global-set-key (kbd "M-i") 'tag-info)







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((c++-font-lock-extra-types "\\sw+_t" "[A-Z]\\sw*[a-z]\\sw*")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
