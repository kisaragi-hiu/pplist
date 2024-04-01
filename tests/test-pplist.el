;; -*- mode: lisp-interaction; lexical-binding: t; -*-

(require 'pplist)
(require 'buttercup)

(describe "elt"
  (it "extracts values"
    (expect (pplist-elt '(:body "a" "b" "c" :another 1 2) :body)
            :to-equal
            '("a" "b" "c"))
    (expect (pplist-elt '(:body "a" "b" "c" :another 1 2) :another)
            :to-equal
            '(1 2)))
  (it "is leniant"
    (expect (pplist-elt '("a" "b" "c" :another 1 2) :another)
            :to-equal
            '(1 2))))
