# “pplists”: plists with multiple value forms

Have a look at `use-package`'s syntax for body forms:

```elisp
;; Illustrative example from Doom Emacs
;; https://github.com/doomemacs/doomemacs/blob/master/modules/tools/lookup/config.el#L202
;; Modified, to:
;; - not use Doom's own functions and
;; - only keep body-like keywords (removing :defer)
(use-package dash-docs
  :when want-docsets
  :init
  (add-hook '+lookup-documentation-functions #'+lookup-dash-docsets-backend-fn)
  :config
  (setq dash-docs-enable-debugging init-file-debug
        dash-docs-docsets-path (concat doom-data-dir "docsets/")
        dash-docs-min-length 2
        dash-docs-browser-func #'eww)
  (cond (use-helm
         (require 'helm-dash nil t))
        (use-helm
         (require 'counsel-dash nil t))))
```

These forms are like plists with multiple value forms, which is why I'm deciding to call them “pplists”. (The name can change if it turns out it's been used for something else.)

This library provides function(s) for working with them.

## Why

If I want to write a macro that does something similar to `use-package` in the body form, it's not immediately clear how to do so. This library is my solution to that.

## Doc

A pplist is a list that associates *keys* to *values*. Its *keys* are elements that are keywords. *Values* associated with a *key* are elements that come after the key but before the next key.

Consequences:

- Values are always lists. This is fine.
- Keywords cannot be values. `(:key :val)` is always two keys. Instead, wrap the value in another list like `(:key '(:val))`.

Functions:

- `pplist-elt (pplist key &optional dflt)`: return values in `pplist` associated with `key`. If `key` is not in `pplist`, return `dflt` (which defaults to nil).
- `pplist-get`: an alias to `pplist-elt` 
