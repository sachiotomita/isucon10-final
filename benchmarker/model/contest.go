package model

import (
	"sync"
	"time"
)

type Contest struct {
	mu                 sync.RWMutex
	RegistrationOpenAt time.Time
	ContestStartsAt    time.Time
	ContestFreezesAt   time.Time
	ContestEndsAt      time.Time
	GRPCHost           string
	GRPCPort           int64
	Teams              []*Team
	teamsByID          map[int64]*Team
}

func NewContest(now time.Time) *Contest {
	now = now.Truncate(time.Second)

	return &Contest{
		mu:                 sync.RWMutex{},
		RegistrationOpenAt: now,
		ContestStartsAt:    now.Add(10 * time.Second),
		ContestFreezesAt:   now.Add(50 * time.Second),
		ContestEndsAt:      now.Add(55 * time.Second),
		GRPCHost:           "",
		GRPCPort:           0,
		Teams:              []*Team{},
		teamsByID:          map[int64]*Team{},
	}
}

func (c *Contest) AddTeam(team *Team) {
	c.mu.Lock()
	defer c.mu.Unlock()

	c.Teams = append(c.Teams, team)
	c.teamsByID[team.ID] = team
}

func (c *Contest) GetTeam(id int64) *Team {
	c.mu.RLock()
	defer c.mu.RUnlock()

	return c.teamsByID[id]
}
