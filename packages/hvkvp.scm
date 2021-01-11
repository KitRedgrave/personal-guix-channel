(define-module (kitredgrave packages hvkvp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download))

(define-public hvkvp
  (package
    (name "hvkvp")
    (version "2.0")
    (source (origin
	      (method git-fetch)
	      (uri (git-reference
		(url "https://github.com/ejsiron/hvkvp.git")
		(commit "v2.0")))
	      (sha256
		(base32
		  "131qy3mxj9yamp42ahlzsfnsjm6n5752k4k4i5zpypqzr3f5a3qf"))))
    (build-system gnu-build-system)
    (arguments
      '(#:phases (modify-phases %standard-phases
		   (delete 'configure)
		   (delete 'check)
		   (replace 'install
		      (lambda* (#:key outputs #:allow-other-keys)
			 (let* ((out (assoc-ref outputs "out"))
				(outdir (string-append out "/bin/")))
			   (install-file "hvkvp" outdir)
			   #t))))))
    (outputs '("out"))
    (synopsis "Hyper-V KVP Exchange for Linux")
    (description "Tools for talking to a Hyper-V hypervisor from a Linux guest")
    (home-page "https://github.com/ejsiron/hvkvp")
    (license license:expat)))

hvkvp
