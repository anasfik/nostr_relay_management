package main

import (
	"context"
	"fmt"
	"net/http"

	"github.com/fiatjaf/eventstore/sqlite3"
	"github.com/fiatjaf/khatru"

)

func main() {
	relay := khatru.NewRelay()

	db := sqlite3.SQLite3Backend{DatabaseURL: "khatru-sqlite-tmp"}

	if err := db.Init(); err != nil {
		panic(err)
	}


	relay.StoreEvent = append(relay.StoreEvent, db.SaveEvent)

	relay.QueryEvents = append(relay.QueryEvents, db.QueryEvents)

	relay.CountEvents = append(relay.CountEvents, db.CountEvents)

	relay.DeleteEvent = append(relay.DeleteEvent, db.DeleteEvent)

	relay.ReplaceEvent = append(relay.ReplaceEvent, db.ReplaceEvent)

	relay.ManagementAPI.ListAllowedKinds = func(ctx context.Context) ([]int, error) {
		return []int{0, 3, 10000, 10001, 10002, 10003, 10004, 10008, 10009, 10016, 30000}, nil
	}


	fmt.Printf("Listening on :3334\n")
	http.ListenAndServe(":3334", relay)


}
