package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

// https://developers.cardano.org/docs/integrate-cardano/creating-wallet-faucet/
// use cardano full node wallet, then query the address
//
// https://iohk.zendesk.com/hc/en-us/articles/900004340586-How-to-symlink-Daedalus-chain-folder
type CryptoTaxTrackerCSVTokenType int

// TODO: convert this to TurboTax universal template
// https://ttlc.intuit.com/turbotax-support/en-us/help-article/cryptocurrency/create-csv-file-unsupported-source/L1yhp71Nt_US_en_US
// Currency Name,Purchase Date,Date Sold,Proceeds,Cost Basis
const (
	CryptoTaxTrackerCSVTokenTypeCurrencyName CryptoTaxTrackerCSVTokenType = iota
	CryptoTaxTrackerCSVTokenTypePurchaseDate
	CryptoTaxTrackerCSVTokenTypeDateSold
	CryptoTaxTrackerCSVTokenTypeProceeds
	CryptoTaxTrackerCSVTokenTypeCostBasis
	CryptoTaxTrackerCSVTokenTypeNums
)

const CryptoTaxTrackerCSVDateTimeFormat = "01/02/2006"

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
				fmt.Fprintf(os.Stderr, ">>> Transaction #%d: %f (%v)\n", txIdx, transaction.ValueUSD, transaction.DateTime)
				transactionList = append(transactionList, transaction)
			} else {
				fmt.Fprintf(os.Stderr, ">>> Transaction #%d failed: %v\n", txIdx, transaction.Err)
			}
			transaction.Err = nil
			txIdx++
		}
	}

	// process transaction list to CryptoTaxTracker Format
	for _, transaction := range transactionList {
		var values [CryptoTaxTrackerCSVTokenTypeNums]string
		for tokenType := CryptoTaxTrackerCSVTokenTypeCurrencyName; tokenType < CryptoTaxTrackerCSVTokenTypeNums; tokenType++ {
			switch tokenType {
			case CryptoTaxTrackerCSVTokenTypeCurrencyName:
				// HACK: should parse this from transaction
				values[tokenType] = "ADA"
			case CryptoTaxTrackerCSVTokenTypePurchaseDate:
				values[tokenType] = transaction.DateTime.Format(CryptoTaxTrackerCSVDateTimeFormat)
			case CryptoTaxTrackerCSVTokenTypeDateSold:
				// TODO: Should this be empty when we're dealing with stake rewards?
				values[tokenType] = ""
				values[tokenType] = transaction.DateTime.Format(CryptoTaxTrackerCSVDateTimeFormat)
			case CryptoTaxTrackerCSVTokenTypeProceeds:
				values[tokenType] = fmt.Sprintf("%f", transaction.ValueUSD)
			case CryptoTaxTrackerCSVTokenTypeCostBasis:
				values[tokenType] = "0"
			}
		}

		fmt.Fprintln(os.Stdout, strings.Join(values[:], ","))
	}
}
