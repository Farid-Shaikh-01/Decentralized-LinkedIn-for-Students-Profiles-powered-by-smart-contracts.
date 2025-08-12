;; Decentralized LinkedIn for Students

(define-map student-profiles
  principal
  {
    name: (string-ascii 50),
    bio: (string-ascii 200),
    skills: (list 10 (string-ascii 30)),
  }
)

(define-constant err-empty-name (err u100))
(define-constant err-empty-bio (err u101))

(define-public (set-profile
    (name (string-ascii 50))
    (bio (string-ascii 200))
    (skills (list 10 (string-ascii 30)))
  )
  (begin
    (asserts! (not (is-eq name "")) err-empty-name)
    (asserts! (not (is-eq bio "")) err-empty-bio)
    (map-set student-profiles tx-sender {
      name: name,
      bio: bio,
      skills: skills,
    })
    (ok "Profile created/updated successfully")
  )
)

(define-read-only (get-profile (student principal))
  (ok (map-get? student-profiles student))
)
