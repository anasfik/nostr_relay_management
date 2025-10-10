package main

import (
	"context"
	"fmt"
	"net"
	"net/http"

	"github.com/fiatjaf/eventstore/sqlite3"
	"github.com/fiatjaf/khatru"
	"github.com/nbd-wtf/go-nostr/nip86"
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

	// RejectAPICall hooks (dummy: allow all)
	relay.ManagementAPI.RejectAPICall = append(relay.ManagementAPI.RejectAPICall, func(ctx context.Context, mp nip86.MethodParams) (bool, string) {
		return false, ""
	})

	// Pubkey management
	relay.ManagementAPI.BanPubKey = func(ctx context.Context, pubkey string, reason string) error { return nil }
	relay.ManagementAPI.AllowPubKey = func(ctx context.Context, pubkey string, reason string) error { return nil }

	relay.ManagementAPI.ListAllowedKinds = func(ctx context.Context) ([]int, error) {
		return []int{0, 3, 10000, 10001, 10002, 10003, 10004, 10008, 10009, 10016, 30000}, nil
	}

	relay.ManagementAPI.ListAllowedPubKeys = func(ctx context.Context) ([]nip86.PubKeyReason, error) {
		// Check if context is cancelled
		if ctx.Err() != nil {
			return nil, ctx.Err()
		}

		return []nip86.PubKeyReason{
			{
				PubKey: "pubkey1",
				Reason: "Spam",
			},
			{
				PubKey: "pubkey2",
				Reason: "Harassment",
			},
		}, nil
	}

	relay.ManagementAPI.ListAllowedEvents = func(ctx context.Context) ([]nip86.IDReason, error) {

		idsAndReasonEntrie := []nip86.IDReason{
			{
				ID:     "eventId3",
				Reason: "Verified content",
			},
			{
				ID:     "eventId4",
				Reason: "Trusted source",
			},
		}

		return idsAndReasonEntrie, nil

	}

	relay.ManagementAPI.ListBannedEvents = func(ctx context.Context) ([]nip86.IDReason, error) {

		idsAndReasonEntrie := []nip86.IDReason{
			{
				ID:     "eventId1",
				Reason: "Inappropriate content",
			},
			{
				ID:     "eventId2",
				Reason: "Spam",
			},
		}

		return idsAndReasonEntrie, nil
	}

	relay.ManagementAPI.ListDisAllowedKinds = func(ctx context.Context) ([]int, error) {

		kinds := []int{1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

		return kinds, nil
	}

	relay.ManagementAPI.ListBannedPubKeys = func(ctx context.Context) ([]nip86.PubKeyReason, error) {

		entries := []nip86.PubKeyReason{
			{
				PubKey: "pubkey1",
				Reason: "maybe spam",
			},
		}

		return entries, nil
	}

	relay.ManagementAPI.ListBlockedIPs = func(ctx context.Context) ([]nip86.IPReason, error) {

		entries := []nip86.IPReason{
			{
				IP:     "102.2.5.4",
				Reason: "suspicious activity",
			},
		}

		return entries, nil
	}

	relay.ManagementAPI.ListEventsNeedingModeration = func(ctx context.Context) ([]nip86.IDReason, error) {

		entries := []nip86.IDReason{
			{
				ID:     "eventId5",
				Reason: "contain sensitive content to be reviewed (detected by AI)",
			},
		}

		return entries, nil

	}

	// Event moderation
	relay.ManagementAPI.AllowEvent = func(ctx context.Context, id string, reason string) error { return nil }
	relay.ManagementAPI.BanEvent = func(ctx context.Context, id string, reason string) error { return nil }

	// Relay metadata changes
	relay.ManagementAPI.ChangeRelayName = func(ctx context.Context, name string) error { return nil }
	relay.ManagementAPI.ChangeRelayDescription = func(ctx context.Context, desc string) error { return nil }
	relay.ManagementAPI.ChangeRelayIcon = func(ctx context.Context, icon string) error { return nil }

	// Kind toggles
	relay.ManagementAPI.AllowKind = func(ctx context.Context, kind int) error { return nil }
	relay.ManagementAPI.DisallowKind = func(ctx context.Context, kind int) error { return nil }

	// IP blocking
	relay.ManagementAPI.BlockIP = func(ctx context.Context, ip net.IP, reason string) error { return nil }
	relay.ManagementAPI.UnblockIP = func(ctx context.Context, ip net.IP, reason string) error { return nil }

	// Stats and admin
	relay.ManagementAPI.Stats = func(ctx context.Context) (nip86.Response, error) {
		return nip86.Response{}, nil
	}
	relay.ManagementAPI.GrantAdmin = func(ctx context.Context, pubkey string, methods []string) error { return nil }
	relay.ManagementAPI.RevokeAdmin = func(ctx context.Context, pubkey string, methods []string) error { return nil }

	// Generic handler
	relay.ManagementAPI.Generic = func(ctx context.Context, request nip86.Request) (nip86.Response, error) {
		return nip86.Response{}, nil
	}

	fmt.Printf("Listening on :3334\n")
	http.ListenAndServe(":3334", relay)

}
