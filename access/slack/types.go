package main

import (
	"log"
	"strings"

	"github.com/gravitational/teleport-plugins/access"
)

type RequestData struct {
	User           string
	Roles          []string
	RequestReason  string
	ResolveReason  string
	SlackUserEmail string
}

type SlackData struct {
	ChannelID string
	Timestamp string
}

type PluginData struct {
	RequestData
	SlackData
}

func DecodePluginData(dataMap access.PluginDataMap) (data PluginData) {
	log.Printf("Decoding data: %+v \n", dataMap)

	data.User = dataMap["user"]
	data.Roles = strings.Split(dataMap["roles"], ",")
	data.ChannelID = dataMap["channel_id"]
	data.Timestamp = dataMap["timestamp"]
	data.RequestReason = dataMap["request_reason"]
	data.ResolveReason = dataMap["resolve_reason"]
	data.SlackUserEmail = dataMap["slack_user"]
	return
}

func EncodePluginData(data PluginData) access.PluginDataMap {
	log.Printf("Encoding data: %+v \n", data)

	return access.PluginDataMap{
		"user":           data.User,
		"roles":          strings.Join(data.Roles, ","),
		"channel_id":     data.ChannelID,
		"timestamp":      data.Timestamp,
		"request_reason": data.RequestReason,
		"resolve_reason": data.ResolveReason,
		"slack_user":     data.SlackUserEmail,
	}
}
