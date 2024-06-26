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
            '(1 2)))
  (it "distinguishes between nil and not set"
    (expect (pplist-elt '(:key 1 2 3 4 :yes) :yes)
            :to-be nil)
    (expect (pplist-elt '(:key 1 2 3 4 :yes) :no)
            :to-be nil)
    (expect (pplist-elt '(:key 1 2 3 4 :yes) :yes 'not-found)
            :to-be nil)
    (expect (pplist-elt '(:key 1 2 3 4 :yes) :no 'not-found)
            :to-be 'not-found)))
