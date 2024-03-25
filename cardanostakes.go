package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"time"
)

// https://developers.cardano.org/docs/integrate-cardano/creating-wallet-faucet/
// use cardano full node wallet, then query the address
//
// https://iohk.zendesk.com/hc/en-us/articles/900004340586-How-to-symlink-Daedalus-chain-folder

type TokenType int

const (
	TokenTypeStakeLogo TokenType = iota
	TokenTypeCardanoLogo
	TokenTypeBlank0
	TokenTypeDate
	TokenTypeTime
	TokenTypeOutgoingAmount
	TokenTypeOutgoingIdentity
	TokenTypeAdaLogo
	TokenTypeBlank1
	TokenTypeIncomingAmount
	TokenTypeIncomingIdentity
	TokenTypeBlank2
	TokenTypeValue
	TokenTypeFee
	TokenTypeBlank3
	TokenTypeGain
	TokenTypeNums
)

// https://pkg.go.dev/time#pkg-constants
// Date and Time will be merged from raw
const DateTimeFormat = "02 Jan 06 15:04:05"

type Transaction struct {
	DateTime time.Time
	Err      error
	ValueUSD float64
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	tokenIdx := TokenTypeStakeLogo
	txIdx := 0
	dateRaw := ""
	var transaction Transaction
	var transactionList []Transaction

	for scanner.Scan() {
		line := scanner.Text()

		switch tokenIdx {
		case TokenTypeDate:
			dateRaw = line
		case TokenTypeTime:
			dateTimeRaw := fmt.Sprintf("%s %s", dateRaw, line)
			dateTime, err := time.Parse(DateTimeFormat, dateTimeRaw)
			transaction.DateTime = dateTime
			transaction.Err = errors.Join(transaction.Err, err)
		case TokenTypeValue:
			value, err := strconv.ParseFloat(line, 64)
			transaction.ValueUSD = value
			transaction.Err = errors.Join(transaction.Err, err)
		default:
		}

		tokenIdx = (tokenIdx + 1) % TokenTypeNums
		if tokenIdx == 0 {
			if transaction.Err == nil {
				fmt.Printf(">>> Transaction #%d: %f (%v)\n", txIdx, transaction.ValueUSD, transaction.DateTime)
				transactionList = append(transactionList, transaction)
			} else {
				fmt.Printf(">>> Transaction #%d failed: %v\n", txIdx, transaction.Err)
			}
			transaction.Err = nil
			txIdx++
		}
	}

	// process transaction list to CryptoTaxTracker Format
	fmt.Println(transactionList)
}
