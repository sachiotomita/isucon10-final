package model

import (
	"github.com/isucon/isucon10-final/benchmarker/random"
	"net/http/cookiejar"
)

const (
	CONTESTANT_ID_LENGTH       = 12
	CONTESTANT_PASSWORD_LENGTH = 64
)

type Contestant struct {
	ID        string
	Password  string
	Name      string
	IsStudent bool

	CookieJar *cookiejar.Jar
}

func NewContestant() (*Contestant, error) {
	jar, err := cookiejar.New(&cookiejar.Options{})
	if err != nil {
		return nil, err
	}

	id := random.Alphabet(CONTESTANT_ID_LENGTH)

	return &Contestant{
		ID:        id,
		Password:  id, // random.Alphabet(CONTESTANT_PASSWORD_LENGTH),
		Name:      random.Alphabet(20),
		IsStudent: random.Pecentage(1, 10),
		CookieJar: jar,
	}, nil
}

func NewAdmin() (*Contestant, error) {
	admin, err := NewContestant()
	if err != nil {
		return nil, err
	}

	admin.ID = "admin"
	admin.Password = "admin"
	return admin, nil
}
