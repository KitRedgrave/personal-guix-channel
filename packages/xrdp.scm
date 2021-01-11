(define-module (kitredgrave packages xrdp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (gnu packages base)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages assembly))

(define-public xrdp
  (package
    (name "xrdp")
    (version "0.9.15")
    (source (origin
	      (method url-fetch)
	      (uri "https://github.com/neutrinolabs/xrdp/releases/download/v0.9.15/xrdp-0.9.15.tar.gz")
	      (sha256
		(base32
		  "0hdmz6k6bjqpc8wckcy3bzsbxia5jpgm023mzws6q8z5bzj820xd"))))
    (build-system gnu-build-system)
    (native-inputs
      `(("which" ,which)
	("pkg-config" ,pkg-config)
	("nasm" ,nasm)))
    (inputs
      `(("openssl" ,openssl)
	("linux-pam" ,linux-pam)
	("libX11" ,libx11)
	("libXfixes" ,libxfixes)
	("libXrandr" ,libxrandr)
        ("fuse" ,fuse)))
    (arguments
      `(#:configure-flags '("--enable-vsock" "--enable-strict-locations" "--enable-fuse")
	#:phases
	(modify-phases %standard-phases
	   (add-after 'unpack 'fix-pam-search-path
	      (lambda* (#:key inputs #:allow-other-keys)
		 (let* ((pam (assoc-ref inputs "linux-pam")))
		   (substitute* "instfiles/pam.d/mkpamrules"
		      (("^pam_module_dir_searchpath=(.*)$") (string-append "pam_module_dir_searchpath=" pam "/lib/security"))))
		 #t)))))
    (outputs '("out"))
    (synopsis "xrdp: an open source RDP server")
    (description "Microsoft Remote Desktop Protocol (RDP) server for Linux")
    (home-page "https://github.com/neutrinolabs/xrdp")
    (license license:asl2.0)))

xrdp
