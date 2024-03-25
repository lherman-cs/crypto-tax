package main

import (
	"bufio"
	"errors"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
	"time"
)

// https://developers.cardano.org/docs/integrate-cardano/creating-wallet-faucet/
// use cardano full node wallet, then query the address
//
// https://iohk.zendesk.com/hc/en-us/articles/900004340586-How-to-symlink-Daedalus-chain-folder

type TurboTaxCSVToken int

const (
	TurboTaxCSVTokenDate TurboTaxCSVToken = iota
	TurboTaxCSVTokenType
	TurboTaxCSVTokenSentAsset
	TurboTaxCSVTokenSentAmount
	TurboTaxCSVTokenReceivedAsset
	TurboTaxCSVTokenReceivedAmount
	TurboTaxCSVTokenFeeAsset
	TurboTaxCSVTokenFeeAmount
	TurboTaxCSVTokenMarketValueCurrency
	TurboTaxCSVTokenMarketValue
	TurboTaxCSVTokenDescription
	TurboTaxCSVTokenTransactionHash
	TurboTaxCSVTokenTransactionID
	TurboTaxCSVTokenNums
)

type CryptoTaxTrackerCSVTokenType int

// Currency Name,Purchase Date,Date Sold,Proceeds,Cost Basis
const (
	CryptoTaxTrackerCSVTokenTypeCurrencyName CryptoTaxTrackerCSVTokenType = iota
	CryptoTaxTrackerCSVTokenTypePurchaseDate
	CryptoTaxTrackerCSVTokenTypeDateSold
	CryptoTaxTrackerCSVTokenTypeProceeds
	CryptoTaxTrackerCSVTokenTypeCostBasis
	CryptoTaxTrackerCSVTokenTypeNums
)

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

type Transaction struct {
	DateTime time.Time
	Err      error
	ValueUSD float64
	Amount   float64
	Ticker   string
}

func OutputToCryptoTaxTracker(writer io.Writer, transactionList []Transaction) {
	CryptoTaxTrackerCSVDateTimeFormat := "01/02/2006"

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

		fmt.Fprintln(writer, strings.Join(values[:], ","))
	}
}

// OutputToTurboTaxUniversal formats transactions to TurboTax universal template
//
// https://ttlc.intuit.com/turbotax-support/en-us/help-article/cryptocurrency/create-csv-file-unsupported-source/L1yhp71Nt_US_en_US
//
// Date,Type,Sent Asset,Sent Amount,Received Asset,Received Amount,Fee Asset,Fee Amount,Market Value Currency,Market Value,Description,Transaction Hash,Transaction ID
// 9/20/2022 23:33,Buy,USD,5000,BTC,0.25,USD,2.99,USD,5002.99,buy BTC on exchange,,255cef42-e04f-5a46-8885-b318fd4724ec
// 10/1/2022 15:21,Sale,BTC,0.2,USD,4500,USD,1.5,USD,4498.5,sold BTC on exchange,,
// 11/5/2022 10:11,Convert,BTC,0.05,ETH,1,USD,2.5,,,Converted BTC to ETH on exchange,,
// 2/1/2022 5:45,Income,,,ETH,1,,,,,Received 1 BTC for work done,,
// 12/1/2022 15:22,Rewards,,,ETH,0.005,,,,,,,
// 6/23/2022 15:21,Expense,ETH,0.1,,,,,,,,,
// 10/15/2022 23:23,Deposit,,,BTC,1,,,,,received 1 BTC from BTC wallet,,
// 9/15/2022 9:21,Mining,,,BTC,0.0000025,,,,,,,
// 10/15/2022 23:23,Withdrawal,BTC,1,,,,,,,Sent 1 BTC from BTC wallet to exchange,,
// 12/23/2022 23:15,Stake,,,0.05,ETH,,,,,received .05 ETH from staking rewards,0x12345abcde,
func OutputToTurboTaxUniversal(writer io.Writer, transactionList []Transaction, header bool) {
	// https://pkg.go.dev/time#pkg-constants
	dateFormat := "01/02/2006"
	floatingPointFormat := "%.8f" // TurboTax only allows up to 8 decimal points

	tokenToString := func(token TurboTaxCSVToken) string {
		switch token {
		case TurboTaxCSVTokenDate:
			return "Date"
		case TurboTaxCSVTokenType:
			return "Type"
		case TurboTaxCSVTokenSentAsset:
			return "Sent Asset"
		case TurboTaxCSVTokenSentAmount:
			return "Sent Amount"
		case TurboTaxCSVTokenReceivedAsset:
			return "Received Asset"
		case TurboTaxCSVTokenReceivedAmount:
			return "Received Amount"
		case TurboTaxCSVTokenFeeAsset:
			return "Fee Asset"
		case TurboTaxCSVTokenFeeAmount:
			return "Fee Amount"
		case TurboTaxCSVTokenMarketValueCurrency:
			return "Market Value Currency"
		case TurboTaxCSVTokenMarketValue:
			return "Market Value"
		case TurboTaxCSVTokenDescription:
			return "Description"
		case TurboTaxCSVTokenTransactionHash:
			return "Transaction Hash"
		case TurboTaxCSVTokenTransactionID:
			return "Transaction ID"
		default:
			return "Unknown"
		}
	}

	if header {
		var values [TurboTaxCSVTokenNums]string
		for token := TurboTaxCSVTokenDate; token < TurboTaxCSVTokenNums; token++ {
			values[token] = tokenToString(token)
		}
		fmt.Fprintln(writer, strings.Join(values[:], ","))
	}

	for _, transaction := range transactionList {
		var values [TurboTaxCSVTokenNums]string
		for token := TurboTaxCSVTokenDate; token < TurboTaxCSVTokenNums; token++ {
			switch token {
			case TurboTaxCSVTokenDate:
				values[token] = transaction.DateTime.Format(dateFormat)
			case TurboTaxCSVTokenType:
				// HACK: should parse this from transaction
				values[token] = "Stake"
			case TurboTaxCSVTokenSentAsset:
			case TurboTaxCSVTokenSentAmount:
			case TurboTaxCSVTokenReceivedAsset:
				values[token] = transaction.Ticker
			case TurboTaxCSVTokenReceivedAmount:
				values[token] = fmt.Sprintf(floatingPointFormat, transaction.Amount)
			case TurboTaxCSVTokenFeeAsset:
			case TurboTaxCSVTokenFeeAmount:
			case TurboTaxCSVTokenMarketValueCurrency:
				values[token] = "USD"
			case TurboTaxCSVTokenMarketValue:
				values[token] = fmt.Sprintf(floatingPointFormat, transaction.ValueUSD)
			case TurboTaxCSVTokenDescription:
				values[token] = fmt.Sprintf("received %.4f %s from staking rewards", transaction.Amount, transaction.Ticker)
			case TurboTaxCSVTokenTransactionHash:
			case TurboTaxCSVTokenTransactionID:
			}
		}

		fmt.Fprintln(writer, strings.Join(values[:], ","))
	}
}

func InputCryptoTaxTracker(reader io.Reader) []Transaction {
	// https://pkg.go.dev/time#pkg-constants
	// Date and Time will be merged from raw
  dateFormat := "02 Jan 06 15:04:05"

	scanner := bufio.NewScanner(reader)
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
			dateTime, err := time.Parse(dateFormat, dateTimeRaw)
			transaction.DateTime = dateTime
			transaction.Err = errors.Join(transaction.Err, err)
		case TokenTypeIncomingAmount:
			var sign rune
			var amount float64
			var ticker string
			_, err := fmt.Sscanf(line, "%c%f%s", &sign, &amount, &ticker)
			if sign == '-' {
				amount *= -1
			}
			transaction.Amount = amount
			transaction.Ticker = ticker
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

	return transactionList
}

func main() {
	transactionList := InputCryptoTaxTracker(os.Stdin)
	OutputToTurboTaxUniversal(os.Stdout, transactionList, true)
}
