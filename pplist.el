;;; pplist.el --- Plists with multiple value forms -*- lexical-binding: t; -*-
;;
;; Author: Kisaragi Hiu <mail@kisaragi-hiu.com>
;; Version: 0.1.0
;; Keywords: extensions
;; Homepage: https://github.com/kisaragi-hiu/pplist
;; Package-Requires: ((emacs "24.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; `use-package' body has the syntax (:key body body ... :key body body body).
;; This body is like a plist, except keys are always keywords and everything
;; between a key and the next one is the previous key's value. This is a pretty
;; convenient format for writing a body.
;;
;; This library attempts to provide helpers for this data structure.
;;
;;; Code:

(defun pplist-elt (pplist key)
  "Get the value of KEY in PPLIST."
  (let ((reading-values nil)
        (values '()))
    (dolist (elem pplist)
      (cond
       ((eq elem key)
        (setq reading-values t))
       ((keywordp elem) ; but not KEY as it's matched above
        (setq reading-values nil))
       (reading-values
        (push elem values))
       (t nil)))
    (nreverse values)))

(defalias 'pplist-get 'pplist-elt)

(provide 'pplist)
;;; pplist.el ends here
