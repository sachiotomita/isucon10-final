package model

import (
	"sync/atomic"

	"github.com/isucon/isucon10-final/benchmarker/random"
)

var (
	generatedClarCount int64 = 0
	disclosePer        int64 = 20
)

type Clarification struct {
	team     *Team
	id       int64
	TeamID   int64
	Question string
	Answer   string
	Disclose bool
	sent     uint32
	answered uint32
}

func NewClarification(team *Team) *Clarification {
	count := atomic.AddInt64(&generatedClarCount, 1)
	disclose := (count % disclosePer) == 0

	return &Clarification{
		team:     team,
		id:       -1,
		TeamID:   team.ID,
		Question: random.Question(),
		Answer:   random.Answer(),
		Disclose: disclose,
		sent:     0,
		answered: 0,
	}
}

func (s *Clarification) ID() int64 {
	return atomic.LoadInt64(&s.id)
}

func (s *Clarification) SetID(id int64) {
	atomic.StoreInt64(&s.id, id)
}

func (c *Clarification) IsSent() bool {
	return atomic.LoadUint32(&c.sent) != 0
}

func (c *Clarification) Sent() {
	atomic.StoreUint32(&c.sent, 1)
}

func (c *Clarification) IsAnswered() bool {
	return atomic.LoadUint32(&c.answered) != 0
}

func (c *Clarification) Answered() {
	atomic.StoreUint32(&c.answered, 1)
}
